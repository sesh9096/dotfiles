#!/bin/sh
# Previewer script for the lf file manager
# Arguments
# (1) current file name
# (2) width
# (3) height
# (4) horizontal position
# (5) vertical  position  of preview pane 
# (6) next file name to be previewed
# case "$1" in
#                *.tar*) tar tf "$1";;
#                *.zip) unzip -l "$1";;
#                *.rar) unrar l "$1";;
#                *.7z) 7z l "$1";;
#                *.pdf) pdftotext "$1" -;;
#                *) highlight -O ansi "$1";;
#            esac
case "$(file -Lb --mime-type -- "$1")" in
    image/*)
        # chafa -f sixel -s "$2x$3" --animate off --polite on "$1"
        # ls -l $1
        exiftool $1
        ;;
    text/* | */xml | application/json | application/x-ndjson | application/javascript) bat --terminal-width "$4" --style header,header-filesize,numbers -f "$1" ;;
    # text/* | */xml | application/json | application/x-ndjson) bat -p --theme ansi --terminal-width "$(($4-2))" -f "$1" ;;
    # *.tar*) tar tf "$1";;
    # *.zip) unzip -l "$1";;
    application/pdf) pdftotext -f 1 -l 3 "$1" - ;;
    application/x-tar)  tar tf "$1" ;;
    *)
        xdg-mime query filetype "$1"
		ls -lh "$1" | fold -w "$2"
        # stat "$1"
        file -b "$1" | fold -w "$2"
        ;;
esac
# case $(file --mime-type -Lb $f) in
#     text/*) lf -remote "send $id \$$EDITOR \$fx";;
#     *) for f in $fx; do $OPENER $f > /dev/null 2> /dev/null & done;;
# esac

