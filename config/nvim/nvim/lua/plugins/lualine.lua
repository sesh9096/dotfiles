return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- See `:help lualine.txt`
  opts = {
    options = {
    icons_enabled = true,
    -- theme = 'auto',
    -- theme = 'codedark',
    theme = 'iceberg_dark',
    component_separators = '',
    section_separators = '',
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    },
    sections = {
      lualine_c = {
        {
          'buffers',
          mode = 0,
          buffers_color = {
            -- Same values as the general color option can be used here.
            active = 'Normal',     -- Color for active buffer.
            -- inactive = 'lualine_buffer_inactive', -- Color for inactive buffer.
          },
          symbols = {
            modified = '●',      -- Text to show when the buffer is modified
            alternate_file = '#', -- Text to show to identify the alternate file
            directory =  '',     -- Text to show when the buffer is a directory
          },
        },
      },
    },
    inactive_sections = {
      lualine_c = {'filename', 'branch'},
      lualine_x = {'progress', 'location'},
    },
  },
}
