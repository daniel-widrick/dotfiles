print("Hello!")



local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
	{'folke/tokyonight.nvim'},
	{'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' }},
	{"nvim-telescope/telescope.nvim", dependencies = "tsakirist/telescope-lazy.nvim"},
	{'mbbill/undotree'},
	{'tpope/vim-fugitive'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'neovim/nvim-lspconfig'},
})

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "bash", "lua", "vim", "vimdoc", "go"}, auto_install = true }

require("tokyonight").setup {
	transparent = true,
}
vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')


--Install lsp_zero
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = { 
		'ansiblels',
		'bashls',
		'cssls',
		'dockerls',
		'eslint',
		'gopls',
		'html',
		'htmx',
		'biome',
		'sqlls',
		'tsserver',
		'vuels',
		'lua_ls','rust_analyzer' }
})




--Remap hotkeys
local telescope = require('telescope')
telescope.setup { pickers = {
	find_files = { hidden = true },
	live_grep = { additional_args = function(opts)
		return {"--hidden"}
	end }
} }
local tsbuiltin = require('telescope.builtin')

--Key bindings
vim.g.mapleader = " "
vim.keymap.set("n","<leader>fv",vim.cmd.Ex)
vim.keymap.set('n','<leader>ff', tsbuiltin.find_files, {})
vim.keymap.set('n','<leader>fg', tsbuiltin.live_grep, {})
vim.keymap.set('n','<leader>u', vim.cmd.UndotreeToggle)
vim.keymap.set('n','<leader>g', vim.cmd.Git)

--Set line colors
vim.wo.relativenumber = true
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='cornflowerblue' })
vim.api.nvim_set_hl(0, 'LineNr', { fg='cyan' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='cornflowerblue' })


