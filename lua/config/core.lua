vim.opt.cc = "81"
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.autoindent = true
vim.opt.encoding = 'utf-8'
vim.opt.guifont = 'JetBrainsMono Nerd Font:h12'
vim.opt.background = "dark"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true -- Ignore case
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 8
vim.opt.showmode = true -- Dont show mode since we have a statusline
vim.opt.title = true
vim.opt.wildmenu = true
vim.opt.signcolumn = "yes:2" -- Always show the signcolumn
vim.opt.smoothscroll = true
vim.opt.shiftwidth = 4
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.spelllang = { "en" }
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.softtabstop = 4
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.undolevels = 10000
vim.opt.undofile = true
vim.opt.errorbells = false
vim.opt.visualbell = true
vim.opt.laststatus = 2
vim.opt.foldenable = false
vim.opt.clipboard = "unnamedplus"
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  leadmultispace = '·┊'
}
vim.opt.list = true
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " "
}
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

vim.cmd("filetype plugin on")
vim.cmd("filetype plugin indent on")

vim.keymap
  .set("n", "<leader>q", function() vim.cmd("q") end, { noremap = true })
vim.keymap.set("n", "<Esc>", function() vim.cmd("nohlsearch") end)

-- Ctrl S even though I never use it anymore
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", function() vim.cmd("w") end,
               { desc = "Save File" })

-- Make sigle line navigation default
local function better_move(direction)
  return vim.v.count == 0 and "g" .. direction or direction
end
vim.keymap.set({ "n", "x" }, "j", function() return better_move("j") end,
               { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", function() return better_move("k") end,
               { desc = "Up", expr = true, silent = true })
