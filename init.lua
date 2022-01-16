-- 安装packer
local installPath = vim.fn.stdpath "data" ..
                        "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(installPath)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                       installPath)
end

-- 下载插件
local use = require("packer").use
require("packer").startup(function()
    use "wbthomason/packer.nvim" -- packer.nvim 插件管理器
    use "jiangmiao/auto-pairs" -- 括号自动补全
    use "tpope/vim-fugitive" -- 在vim中使用git
    use "joshdick/onedark.vim" -- onedark 主题
    use "skywind3000/vim-terminal-help" -- 方便的使用内置终端
    use "itchyny/lightline.vim" -- 让状态栏更好看
    use {"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons"} -- 标签页
    use {"neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer"} -- lsp
    use {"kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons"} -- 文件管理器
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"} -- 语法高亮
    use { -- telescope 模糊搜索
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/plenary.nvim"}}
    }
    -- 以下都是代码补全
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip",
            "rafamadriz/friendly-snippets", "onsails/lspkind-nvim",
            "hrsh7th/cmp-nvim-lua", "octaltree/cmp-look", "hrsh7th/cmp-calc",
            "f3fora/cmp-spell", "hrsh7th/cmp-emoji"
        }
    }
end)

-- vim.o    general setting         通用设定
-- vim.g    global variables        全局变量
-- vim.env  environment variables   环境变量
-- vim.wo   window scoped options   窗口范围设定
-- vim.bo   buffer scoped options   buffer范围设定

-- 设置主题
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme onedark]]
-- 使用 UTF-8 编码
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"
-- 上下移动光标时上下方保留4行
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4
-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = true
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
-- 缩进4个空格等于一个Tab
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
-- 新行对齐当前行，空格代替Tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 左移右移长度
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 搜索高亮
vim.o.hlsearch = true
-- 边输入边搜索
vim.o.incsearch = true
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止折行
-- vim.o.wrap = false
-- vim.wo.wrap = false
-- 太长时自动换行时保持相同缩进，必须允许折行才能看到效果
vim.o.breakindent = true
-- 支持鼠标
vim.o.mouse = "a"
-- 不要创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- 使用空格键作为 leader key
local keymap = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}
keymap("", "<Space>", "Nop", opt) -- 先让空格什么都不干
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- fw 保存
keymap("n", "fw", ":w<CR>", opt)
-- fc 退出
keymap("n", "fc", ":q<CR>", opt)
-- 分屏
keymap("n", "sv", ":vsp<CR>", opt) -- 水平分屏
keymap("n", "sh", ":sp<CR>", opt) -- 垂直分屏
keymap("n", "sc", "<C-w>c", opt) -- 关闭
keymap("n", "so", "<C-w>o", opt) -- 关闭其他
-- 分屏比例控制
keymap("n", "s>", ":vertical resize +10<CR>", opt)
keymap("n", "s<", ":vertical resize -10<CR>", opt)
keymap("n", "s=", "<C-w>=", opt)
keymap("n", "sj", ":resize +5<CR>", opt)
keymap("n", "sk", ":resize -5<CR>", opt)
-- 分屏窗口之间跳转
keymap("n", "<A-h>", "<C-w>h", opt)
keymap("n", "<A-j>", "<C-w>j", opt)
keymap("n", "<A-k>", "<C-w>k", opt)
keymap("n", "<A-l>", "<C-w>l", opt)
-- 打开 nvim-tree 文件管理器
keymap("n", "<A-e>", ":NvimTreeToggle<CR>", opt)
-- 切换标签页
keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 状态栏的设置
vim.g.lightline = {
    colorscheme = "onedark",
    active = {
        left = {
            {"mode", "paste"}, {"gitbranch", "readonly", "filename", "modified"}
        }
    },
    component_function = {gitbranch = "fugitive#head"}
}
-- telescope 的设置
keymap("n", "<leader><space>",
       [[<cmd>lua require("telescope.builtin").buffers()<CR>]], opt)
keymap("n", "<leader>sf",
       [[<cmd>lua require("telescope.builtin").find_files({previewer = false})<CR>]],
       opt)
keymap("n", "<leader>sb",
       [[<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>]],
       opt)
keymap("n", "<leader>sh",
       [[<cmd>lua require("telescope.builtin").help_tags()<CR>]], opt)
keymap("n", "<leader>st", [[<cmd>lua require("telescope.builtin").tags()<CR>]],
       opt)
keymap("n", "<leader>sd",
       [[<cmd>lua require("telescope.builtin").grep_string()<CR>]], opt)
keymap("n", "<leader>sp",
       [[<cmd>lua require("telescope.builtin").live_grep()<CR>]], opt)
keymap("n", "<leader>so",
       [[<cmd>lua require("telescope.builtin").tags{ only_current_buffer = true }<CR>]],
       opt)
keymap("n", "<leader>?",
       [[<cmd>lua require("telescope.builtin").oldfiles()<CR>]], opt)
-- treesitter 的设置
require("nvim-treesitter.configs").setup {
    -- 安装语言解析器
    ensure_installed = {
        "html", "css", "vim", "lua", "javascript", "typescript", "c", "go",
        "rust", "cpp", "cmake", "dockerfile", "fish", "gomod", "java", "json",
        "json5", "jsonc", "julia", "kotlin", "markdown", "python", "regex",
        "vue", "yaml"
    },
    -- 启用代码高亮
    highlight = {enable = true, additional_vim_regex_highlighting = false},
    -- 启用增量选择
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<TAB>",
            node_decremental = "<BS>"
        }
    },
    -- 启用基于 treesitter 的代码格式化
    indent = {enable = true},
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
            }
        }
    }
}
-- nvim-tree 文件管理器设置
require("nvim-tree").setup {
    -- 关闭文件时自动关闭
    auto_close = true
}
-- bufferline 标题栏设置
require("bufferline").setup {
    options = {
        -- 使用 nvim 内置 lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出 nvim-tree 的位置
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                Highlight = "Directory",
                text_align = "left"
            }
        }
    }
}
-- lsp 设置
local lspConfig = require "lspconfig"
local bufmap = vim.api.nvim_buf_set_keymap
-- lsp 快捷键设置
local onAttach = function(_, bufnr)
    bufmap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
    bufmap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
    bufmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
    bufmap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
    bufmap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
    bufmap(bufnr, "n", "<leader>wa",
           "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opt)
    bufmap(bufnr, "n", "<leader>wr",
           "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opt)
    bufmap(bufnr, "n", "<leader>wl",
           "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
           opt)
    bufmap(bufnr, "n", "<leader>D",
           "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt)
    bufmap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
    bufmap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
    bufmap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",
           opt)
    bufmap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>",
           opt)
    bufmap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
    bufmap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
    bufmap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>",
           opt)
    bufmap(bufnr, "n", "<leader>so",
           [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>]],
           opt)
    bufmap(bufnr, "n", "<space>f",
           ":w<CR><cmd>lua vim.lsp.buf.formatting()<CR>", opt)
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local servers = {"gopls", "clangd", "rust_analyzer", "pyright", "tsserver"}
for _, lsp in ipairs(servers) do
    lspConfig[lsp].setup {on_attach = onAttach, capabilities = capabilities}
end

-- 代码补全设置
local cmp = require "cmp"
local lspkind = require "lspkind"
cmp.setup {
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    -- 来源
    sources = {
        {name = "nvim_lsp"}, {name = "vsnip"}, {name = "buffer"},
        {name = "path"}, {name = "cmdline"}, {name = "look"}, {name = "calc"},
        {name = "spell"}, {name = "emoji"}
    },
    -- 样式
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            before = function(entry, vim_item)
                vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                return vim_item
            end
        })
    },
    -- 快捷键
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    }
}