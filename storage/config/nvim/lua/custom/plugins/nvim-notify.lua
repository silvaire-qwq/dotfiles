return {
  'rcarriga/nvim-notify',
  lazy = true,
  event = 'VeryLazy',
  config = function(_, opts)
    vim.notify = require 'notify'
    require('notify').setup(vim.tbl_extend('keep', {
      background_colour = '#000000',
      render = 'wrapped-compact',
      timeout = '700',
    }, opts))
  end,
}
