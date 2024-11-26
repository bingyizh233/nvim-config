require "core.globals"

vim.cmd('source ~/.config/nvim/ftdetect/mlir.vim')
vim.cmd('source ~/.config/nvim/ftdetect/llvm.vim')
vim.cmd('source ~/.config/nvim/ftdetect/llvm-lit.vim')
vim.cmd('source ~/.config/nvim/ftdetect/tablegen.vim')
vim.cmd('source ~/.config/nvim/ftdetect/cuda.vim')

vim.cmd('source ~/.config/nvim/syntax/mlir.vim')
vim.cmd('source ~/.config/nvim/syntax/llvm.vim')
vim.cmd('source ~/.config/nvim/syntax/tablegen.vim')

vim.cmd('source ~/.config/nvim/ftplugin/llvm.vim')
vim.cmd('source ~/.config/nvim/ftplugin/tablegen.vim')

if vim.version().minor >= 11 then
  vim.tbl_add_reverse_lookup = function(tbl)
    for k, v in pairs(tbl) do
      tbl[v] = k
    end
  end
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.runtimepath:prepend(lazypath)

-- NOTE: lazy.nvim options
local lazy_config = require "core.lazy"

-- NOTE: Load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- Load the highlights
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end

require "options"
require "nvchad.autocmds"
require "core.commands"

vim.schedule(function()
  require "mappings"
end)

require "myinit"
