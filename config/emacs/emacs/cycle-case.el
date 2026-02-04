(require 's)
(defun ss/merge-to-string-case (words seperator capitalization &optional first-word-capitalization)
  "merge `words'(list of strings) using `separator' between each word after applying `capitalization' to each word"
  (if (not (listp words)) (error "words must be list"))
  (if (eq words nil) ""
    (let ((retval (funcall (symbol-function (or first-word-capitalization capitalization)) (car words))))
      (dolist (word (cdr words) retval)
        (setq retval (concat retval seperator (funcall (symbol-function capitalization) word)))))))

(defcustom ss/cases-alist
      '((camelCase "" capitalize downcase)
        (PascalCase "" capitalize)
        (kebab-case "-" downcase)
        (snake_case "_" downcase)
        (MACRO_CASE "_" upcase)
        (flatcase "" downcase))
      "alist of cases to arguments `ss/merge-to-string-case'")

(defcustom ss/cycled-cases '(camelCase PascalCase snake_case)
  "list of cases in `ss/cases-alist' to cycle through")

(defun ss/change-case (key)
  "choose a different case for the symbol at point or in region"
  (interactive "c[c]amelCase [p]PascalCase [k]ebab-case [s]nake_case [m]MACRO_CASE [f]latcase")
  (let ((chosen-case
         (cl-case key
           (?c 'camelCase)
           (?p 'PascalCase)
           (?k 'kebab_case)
           (?s 'snake-case)
           (?m 'MACRO_CASE)
           (?f 'flatcase)))
        (bounds (if (region-active-p) (car (region-bounds)) (bounds-of-thing-at-point 'symbol))))
    (if bounds
        (insert (let* ((symbol (delete-and-extract-region (car bounds) (cdr bounds)))
                       (opts (alist-get chosen-case ss/cases-alist)))
                  (apply 'ss/merge-to-string-case (s-split-words symbol) opts))))))

(defun ss/cycle-case (&optional prefix)
  "guess case of the symbol at point or in region and then change to the next
case in `ss/cycled-cases`. If given a prefix, choose that element of `ss/cycled-cases`"
  (interactive "P")
  (let ((bounds (if (region-active-p) (car (region-bounds)) (bounds-of-thing-at-point 'symbol))))
    (if bounds
        (insert (let* ((symbol (delete-and-extract-region (car bounds) (cdr bounds)))
                       (chosen-case (or (if prefix (nth prefix ss/cycled-cases))
                                            (ss/next-elem (ss/guess-case symbol) ss/cycled-cases)))
                       (opts (alist-get chosen-case ss/cases-alist)))
                  (apply 'ss/merge-to-string-case (s-split-words symbol) opts))))))

(defun ss/next-elem (elem list)
  "return next element of list after `elem' or first element if `elem' is not in list"
  (let ((first-elem (car list)))
    (while (and list (not (eq elem (car list)))) (setq list (cdr list)))
    (or (car (cdr list)) first-elem)))

(defun ss/guess-case (string)
  "guess the case of the string and return a symbol,
one of (camelCase PascalCase kebab-case snake_case MACRO_CASE flatcase)"
  (let ((case-sensitive case-fold-search))
    (setq-local case-fold-search nil)
    (let* ((first-char (string-to-char string)) (guess
    (cond
     ((string-search "-" string) 'kebab-case)
     ((string-search "_" string) (if (string-match "[[:lower:]]" string) 'snake_case 'MACRO_CASE))
     (t (if (string-match "[[:upper:]]" string)
            (if (char-uppercase-p first-char) 'PascalCase 'camelCase) 'flatcase)))))
    (setq-local case-fold-search case-sensitive)
    guess)))
