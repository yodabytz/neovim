-- Set the leader key to Space
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
vim.fn.system({
"git",
"clone",
"--filter=blob:none",
"https://github.com/folke/lazy.nvim.git",
"--branch=stable", -- latest stable release
lazypath,
})
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and configure plugins
require("lazy").setup({
-- Colorscheme: Tokyo Night
{
"folke/tokyonight.nvim",
priority = 1000, -- Load first
config = function()
vim.cmd("colorscheme tokyonight-night") -- Variants: night, storm, day, moon
end,
},
-- LSP Configuration
{
"neovim/nvim-lspconfig",
dependencies = {
"williamboman/mason.nvim", -- LSP server manager
"williamboman/mason-lspconfig.nvim",
},
config = function()
require("mason").setup()
require("mason-lspconfig").setup({
ensure_installed = {
"lua_ls", "pyright", "ts_ls", "clangd", "rust_analyzer",
},
})

local lspconfig = require("lspconfig")

-- Function to attach LSP mappings
local on_attach = function(client, bufnr)
local bufmap = function(mode, lhs, rhs, desc)
vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
end
bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
bufmap("n", "gr", vim.lsp.buf.references, "Show references")
bufmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
end

-- Lua Language Server configuration
lspconfig.lua_ls.setup({
settings = {
Lua = {
runtime = { version = "LuaJIT" },
diagnostics = { globals = { "vim" } }, -- Recognize `vim` as global
workspace = {
library = vim.api.nvim_get_runtime_file("", true), -- Neovim runtime
checkThirdParty = false, -- Disable third-party checking
},
telemetry = { enable = false }, -- Disable telemetry
},
},
on_attach = on_attach,
})

-- Configure other LSP servers
local servers = { "pyright", "ts_ls", "clangd", "rust_analyzer" }
for _, server in ipairs(servers) do
lspconfig[server].setup({ on_attach = on_attach })
end

-- Configure gopls explicitly with the binary path
lspconfig.gopls.setup({
cmd = { "/home/snoopy/go/bin/gopls" }, -- Adjust this path if needed
on_attach = on_attach,
})
end,
},
-- Autocompletion
{
"hrsh7th/nvim-cmp",
dependencies = {
"hrsh7th/cmp-nvim-lsp",
"hrsh7th/cmp-buffer",
"hrsh7th/cmp-path",
"L3MON4D3/LuaSnip",
},
config = function()
local cmp = require("cmp")
cmp.setup({
snippet = {
expand = function(args)
require("luasnip").lsp_expand(args.body)
end,
},
mapping = cmp.mapping.preset.insert({
["<C-Space>"] = cmp.mapping.complete(),
["<CR>"] = cmp.mapping.confirm({ select = true }),
}),
sources = cmp.config.sources({
{ name = "nvim_lsp" },
{ name = "buffer" },
{ name = "path" },
}),
})
end,
},
-- Treesitter
{
"nvim-treesitter/nvim-treesitter",
build = ":TSUpdate",
config = function()
require("nvim-treesitter.configs").setup({
ensure_installed = {
"lua", "python", "javascript", "typescript", "go", "c", "cpp", "rust",
},
highlight = { enable = true },
indent = { enable = true },
})
end,
},
-- Statusline
{
"nvim-lualine/lualine.nvim",
dependencies = { "kyazdani42/nvim-web-devicons" },
config = function()
require("lualine").setup({
options = { theme = "tokyonight" },
})
end,
},
-- File Explorer
{
"nvim-neo-tree/neo-tree.nvim",
branch = "v2.x",
dependencies = {
"nvim-lua/plenary.nvim",
"nvim-web-devicons",
"MunifTanjim/nui.nvim",
},
config = function()
require("neo-tree").setup()
end,
},
-- Telescope
{
"nvim-telescope/telescope.nvim",
dependencies = { "nvim-lua/plenary.nvim" },
config = function()
require("telescope").setup({
defaults = {
prompt_prefix = "🔍 ",
selection_caret = "➜ ",
},
})
end,
},
-- Startup Screen
{
"goolord/alpha-nvim",
dependencies = { "kyazdani42/nvim-web-devicons" },
config = function()
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
[[ ]],
[[  ]],
[[ ████ ██████ █████ ██ ]],
[[ ███████████ █████  ]],
[[ █████████ ███████████████████ ███ ███████████ ]],
[[ █████████ ███ █████████████ █████ ██████████████ ]],
[[ █████████ ██████████ █████████ █████ █████ ████ █████ ]],
[[ ███████████ ███ ███ █████████ █████ █████ ████ █████ ]],
[[ ██████ █████████████████████ ████ █████ █████ ████ ██████ ]],
[[ ]],
}
dashboard.section.buttons.val = {
dashboard.button("e", " New file", ":ene <BAR> startinsert <CR>"),
dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
dashboard.button("r", " Recent files", ":Telescope oldfiles<CR>"),
dashboard.button("q", " Quit", ":qa<CR>"),
}
alpha.setup(dashboard.opts)
end,
},
})

-- Key Mappings
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
