return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  keys = { ':', '/', '?' }, -- lazy load cmp on more keys along with insert mode
  config = function()
    require('noice').setup {
      lsp = {
        progress = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      messages = {
        enabled = true,
        view = 'notify',
        view_error = 'notify',
        view_warn = 'notify',
        view_history = 'messages',
        view_search = 'virtualtext',
      },
      health = {
        checker = false,
      },
    }
  end,
}
