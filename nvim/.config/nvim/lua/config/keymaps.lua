vim.g.mapleader = " "

vim.keymap.set('n', '<leader>ch', function()
    if os.getenv("TMUX") then
        vim.cmd('silent !tmux split-window -h -l 35 "cat ~/.config/nvim/cheat.txt; read"')
    else
        print("Ты не в tmux!")
    end
end, { desc = "Открыть шпаргалку в tmux" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit to Normal Mode with jk" })
