local function opencode_toggle()
  local opencode_winid = nil
  local opencode_bufnr = nil

  for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local bufnr = vim.api.nvim_win_get_buf(winid)
    if vim.bo[bufnr].buftype == "terminal" and vim.api.nvim_buf_get_name(bufnr):match("opencode") then
      opencode_winid = winid
      opencode_bufnr = bufnr
      break
    end
  end

  if opencode_winid then
    vim.api.nvim_win_close(opencode_winid, false)
  else
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[bufnr].buftype == "terminal" and vim.api.nvim_buf_get_name(bufnr):match("opencode") then
        opencode_bufnr = bufnr
        break
      end
    end

    vim.cmd("botright vertical new")
    vim.cmd("vertical resize 60")

    local cwd = vim.fn.getcwd()
    vim.cmd("lcd " .. vim.fn.fnameescape(cwd))

    if opencode_bufnr then
      vim.api.nvim_win_set_buf(0, opencode_bufnr)
    else
      vim.cmd("terminal opencode")
      vim.bo.buflisted = false
    end
  end
end

vim.keymap.set("n", "<leader>ai", opencode_toggle, { desc = "Toggle OpenCode CLI" })

local opencode_focus = function()
  local opencode_winid = nil
  for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local bufnr = vim.api.nvim_win_get_buf(winid)
    if vim.bo[bufnr].buftype == "terminal" and vim.api.nvim_buf_get_name(bufnr):match("opencode") then
      opencode_winid = winid
      break
    end
  end
  if opencode_winid then
    vim.api.nvim_set_current_win(opencode_winid)
  else
    vim.notify("OpenCode не открыт. Используй <leader>ai сначала", vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<leader>af", opencode_focus, { desc = "Focus OpenCode" })
