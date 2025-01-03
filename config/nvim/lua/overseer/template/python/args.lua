return {
  name = 'run python script (args)',
  condition = {
    filetype = { 'python' },
  },
  params = {
    args = { optional = false, type = 'list', delimiter = ' ' },
    cwd = { optional = true, type = 'string' },
    interactive = { optional = true, type = 'boolean', default = false },
  },
  builder = function(params)
    local args = { vim.fn.expand '%:p' }
    if params.interactive then
      table.insert(args, 1, '-i')
    end
    if params.args then
      args = vim.list_extend(args, params.args)
    end
    return {
      name = vim.fn.expand '%:t',
      cmd = 'python3',
      args = args,
      cwd = params.cwd and params.cwd or vim.fn.expand '%:p:h',
      components = {
        'task_list_on_start',
        'display_duration',
        'on_exit_set_status',
        'on_complete_notify',
      },
    }
  end,
}