return { 
    { "octol/vim-cpp-enhanced-highlight" },
    { "jiangmiao/auto-pairs" },
    { "scrooloose/nerdcommenter" },
    { "tpope/vim-fugitive" },
    { "junegunn/gv.vim" },
    { "airblade/vim-rooter" },
    { "vim-autoformat/vim-autoformat" },
    { "mg979/vim-visual-multi", branch = "master" },
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = {
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        },
    },
    {
    	"catppuccin/nvim",
    	name = "catppuccin",
        commit = "ce8d176faa4643e026e597ae3c31db59b63cef09",
    	lazy = false,
    	priority = 1000,
    	config = function()
            require("catppuccin").setup({
                integrations = {
                    lualine = true,
                }
            })
    	  vim.cmd.colorscheme "catppuccin-macchiato"
    	end,
    },
    { "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                    component_separators = '',
                    section_separators = { left = '', right = '' },
                },
                sections = {
                  lualine_a = { { 'mode', separator = { left = '', right = '' }, right_padding = 2 } },
                  lualine_b = {
                    "branch",
                    "diff",
                  },
                  lualine_c = { { 'filename', path = 1} },
                  lualine_x = {
                      "encoding",
                      "fileformat",
                      "filetype",
                      {
                        "diagnostics",
                        sources = { 'nvim_workspace_diagnostic' },
                
                        sections = { 'error', 'warn' },
                        symbols = {
                          error = " ",
                          warn  = " ",
                        },
                
                        colored = true,
                        update_in_insert = false,
                      },
                    },
                    lualine_z = { { 'location', separator = { right = '', left = '' }, left_padding = 2 } },
                }
            })
    	end,
    },
    {
        "akinsho/bufferline.nvim", 
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
    	config = function()
            require("bufferline").setup({
                options = {
                    separator_style = "slope",
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end
                }
            })
    	end,
    },
    -------------------------------------------------------------------------
    -- GITSIGNS
    -------------------------------------------------------------------------
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup {
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end
                    map("n", "[c", gs.prev_hunk)
                    map("n", "]c", gs.next_hunk)
                    map("n", "<leader>hs", gs.stage_hunk)
                    map("n", "<leader>hr", gs.reset_hunk)
                    map("v", "<leader>hs", function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
                    map("v", "<leader>hr", function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
                    map("n", "<leader>hS", gs.stage_buffer)
                    map("n", "<leader>hu", gs.undo_stage_hunk)
                    map("n", "<leader>hR", gs.reset_buffer)
                    map("n", "<leader>hp", gs.preview_hunk)
                    map("n", "<leader>hb", function() gs.blame_line { full = true } end)
                    map("n", "<leader>tb", gs.toggle_current_line_blame)
                    map("n", "<leader>hd", gs.diffthis)
                    map("n", "<leader>hD", function() gs.diffthis("~") end)
                    map("n", "<leader>td", gs.toggle_deleted)
                end,
            }
        end,
    },

    -------------------------------------------------------------------------
    -- TELESCOPE
    -------------------------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.9",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup {
                defaults = {
                    layout_strategy = 'horizontal', 
                    layout_config = {
                      horizontal = {
                        prompt_position = 'top',
                        preview_width = 0.55, -- 55% of window width
                      },
                      vertical = {
                        mirror = false,
                      },
                      width = 0.8, -- Global width (e.g., 80%)
                      height = 0.8, -- Global height (e.g., 80%)
                      preview_cutoff = 60, -- Hide preview if window width < 60
                    },
                    sorting_strategy = 'ascending',
                    mappings = {
                        i = {
                            ["<esc>"] = require("telescope.actions").close,
                        },
                    },
                },
                pickers = {
                    lsp_document_symbols = {
                        symbols = {
                           "Class",
                           "Struct",
                           "Interface",
                           "Enum",
                           "EnumMember",
                           "Function",
                           "Method",
                           "Constructor",
                           "Module",
                           "Namespace",
                           "Package",
                           "Property",
                           --"Field",
                           "TypeParameter",
                        },
                    },
                    buffers = {
                        sort_mru = true,
                        ignore_current_buffer = true,
                    },
                },
            }
        end,
    },

    -------------------------------------------------------------------------
    -- NEO-TREE
    -------------------------------------------------------------------------
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
              window = {
                position = "float",
                popup = {
                  size = {
                    width = "60%",   -- ширина float окна
                    height = "85%",  -- высота float окна
                  },
                  position = "50%",  -- центр экрана
                },
                mappings = {
                  ["y"] = "none",  -- отключаем дефолтный yank чтобы работал yp
                  ["yp"] = function(state)
                    local node = state.tree:get_node()
                    local full_path = node:get_id()
                    local relative_path = vim.fn.fnamemodify(full_path, ":.")
                    vim.fn.setreg("+", relative_path, "c")
                  end,
                  ["yy"] = "copy_to_clipboard",
                }
              },
            
              popup_border_style = "rounded",
            
              filesystem = {
                follow_current_file = {
                    enabled = true,
                },
                hijack_netrw_behavior = "open_current",
              },
            })
        end,
    },
    -------------------------------------------------------------------------
    -- FLASH
    -------------------------------------------------------------------------
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
          jump = {
            autojump = true,
          },
        },
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    -------------------------------------------------------------------------
    -- CRATES
    -------------------------------------------------------------------------
    {
        "saecki/crates.nvim",
        tag = "stable",
        config = function()
            require("crates").setup()
        end,
    },

    ---------------------------------------------------------------------------
    -- LSP + Autocompletion
    ---------------------------------------------------------------------------
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "L3MON4D3/LuaSnip",
        },
        config = function()
          local cmp = require("cmp")
       
          cmp.setup({
            formatting = {
              fields = { "abbr", "menu", "kind" },
              format = function(entry, item)
                item.menu = ""
                local content = item.abbr
                local win_width = vim.api.nvim_win_get_width(0)
                local max_content_width = math.floor(win_width * 0.2)
       
                if #content > max_content_width then
                  item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
                else
                  item.abbr = content .. string.rep(" ", max_content_width - #content)
                end
                return item
              end,
            },
       
            snippet = {
              expand = function(args)
                require("luasnip").lsp_expand(args.body)
              end,
            },
       
            mapping = cmp.mapping.preset.insert({
              ["<Down>"] = cmp.mapping.select_next_item(),
              ["<Up>"] = cmp.mapping.select_prev_item(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }),
              ["<C-Space>"] = cmp.mapping.complete(),
            }),
       
            sources = {
              { name = "nvim_lsp" },
              { name = "buffer" },
            },
       
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
          })
        end,
    },
    
    ---------------------------------------------------------------------------
    -- LSP Servers using NEW Neovim 0.11+ API
    ---------------------------------------------------------------------------
    {
      "neovim/nvim-lspconfig", 
      config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
    
        local function on_attach(client, bufnr)
          local opts = { buffer = bufnr, noremap = true, silent = true }
          vim.keymap.set("n", "<F2>", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<F3>", function()
            require("telescope.builtin").lsp_definitions()
          end, { desc = "LSP Declarations" })
          vim.keymap.set("n", "<S-F3>", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "<A-S-r>", vim.lsp.buf.rename, opts)
    
          vim.diagnostic.config({
            underline = { severity = { max = vim.diagnostic.severity.INFO } },
            virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
          })
        end
    
        -----------------------------------------------------------------------
        -- Rust
        -----------------------------------------------------------------------
        vim.lsp.config["rust_analyzer"] = {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
            },
          },
        }
        vim.lsp.enable("rust_analyzer")
    
        -----------------------------------------------------------------------
        -- Go
        -----------------------------------------------------------------------
        vim.lsp.config["gopls"] = {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end,
        }
        vim.lsp.enable("gopls")
    
        -----------------------------------------------------------------------
        -- Clangd
        -----------------------------------------------------------------------
        vim.lsp.config["clangd"] = {
          name = "clangd",
          capabilities = capabilities,
          cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
          initialization_options = {
            fallback_flags = { "-std=c++17" },
          },
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end,
        }
        vim.lsp.enable("clangd")
    
      end,
    },

    -------------------------------------------------------------------------
    -- ILLUMINATE
    -------------------------------------------------------------------------
    { "RRethy/vim-illuminate" },

    -------------------------------------------------------------------------
    -- TREE-SITTER
    -------------------------------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "master", 
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "rust" },
                textobjects = {
                    move = {
                      enable = true,
                      set_jumps = true,

                      -- Переходы по блокам
                      goto_next_end = {
                        ["]f"] = "@function.outer",
                      },
                      goto_previous_start = {
                        ["[f"] = "@function.outer",
                      },
                    }
                },
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
