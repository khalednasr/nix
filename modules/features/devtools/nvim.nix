{ inputs, self, ... }:
let
  name = "nvim";

  customPackage =
    pkgs:
    inputs.nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvim {
      extraPackages = with pkgs; [
        ripgrep
        fzf
        fd
        gcc
      ];

      # Vim options
      opts = {
        termguicolors = true;
        number = true;
        relativenumber = true;
        wrap = false;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        autoindent = true;
        ignorecase = true;
        smartcase = true;
        hlsearch = false;
        incsearch = true;
        scrolloff = 8;
        sidescrolloff = 8;
      };

      # Colorscheme
      colorschemes.gruvbox-material = {
        enable = true;
        settings = {
          enable_italic = true;
          forground = "original";
          transparent_background = 2;
        };
      };

      # Simple plugins with minimal configuration
      plugins.flash.enable = true;
      plugins.noice.enable = true;
      plugins.web-devicons.enable = true;
      plugins.lualine.enable = true;
      plugins.bufferline.enable = true;
      plugins.visual-multi.enable = true;
      plugins.sleuth.enable = true;
      plugins.tmux-navigator.enable = true;

      # LSP configuration
      plugins.lsp = {
        enable = true;
        servers = {
          # Nix
          nil_ls.enable = true;

          # Python
          basedpyright = {
            enable = true;
            settings = {
              basedpyright.analysis.typeCheckingMode = "off"; # sorry
            };
          };
          ruff = {
            enable = true;
          };

          # Rust
          rust_analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };

          # System verilog
          svls = {
            enable = true;
          };
        };
      };

      # Treesitter
      plugins.treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # Yazi
      plugins.yazi.enable = true;
      dependencies.yazi.package = self.packages."${pkgs.stdenv.hostPlatform.system}".yazi;
      plugins.yazi.settings.open_for_directories = false;
      globals.loaded_netrwPlugin = 1;

      # Snacks
      plugins.snacks = {
        enable = true;
        settings = {
          picker.enable = true;
          bufdelete.enable = true;
          indent.enable = true;
          scroll.enable = true;
          words.enable = true;
        };
      };

      # Mini.nvim
      plugins.mini = {
        enable = true;
        modules = {
          ai = { };
          surround = { };
          move = {
            options.reindent_linewise = true;
            mappings = {
              left = "<C-h>";
              right = "<C-l>";
              down = "<C-j>";
              up = "<C-k>";
              line_left = "<C-h>";
              line_right = "<C-l>";
              line_down = "<C-j>";
              line_up = "<C-k>";
            };
          };
        };
      };

      # Autocomplete
      plugins.blink-cmp = {
        enable = true;
        settings = {
          signature.enabled = true;
          completion.documentation.auto_show = true;
          completion.list.selection.preselect = false;
          keymap = {
            preset = "default";
            "<CR>" = [
              "accept"
              "fallback"
            ];
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
            "<C-n>" = [
              "snippet_forward"
              "fallback"
            ];
            "<C-p>" = [
              "snippet_backward"
              "fallback"
            ];
          };
        };
      };

      plugins.dashboard = {
        enable = true;
        settings = {
          theme = "hyper";
          config = {
            mru.enable = false;
            project.enable = false;
            header = [
              "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
            footer = [
              "Made with ❤️"
            ];
            shortcut = [
              {
                desc = "File Picker";
                key = "f";
                action.__raw = "function() Snacks.picker.files() end";
              }
              {
                desc = "File Explorer";
                key = "e";
                action = "Yazi";
              }
            ];
          };
        };
      };

      # Custom keymaps
      globals.mapleader = " ";
      keymaps = [
        # Command line
        {
          key = "ö";
          action = ":";
          mode = "n";
          options.desc = "Command line";
        }

        # Buffers
        {
          key = "H";
          action = "<cmd>bp<cr>";
          mode = "n";
          options.desc = "Previous buffer";
        }
        {
          key = "L";
          action = "<cmd>bn<cr>";
          mode = "n";
          options.desc = "Next buffer";
        }
        {
          key = "<leader>x";
          action = "<cmd>bd<cr>";
          mode = "n";
          options.desc = "Next buffer";
        }

        # Horizontal scrolling
        {
          key = "<C-S-h>";
          action = "20zh";
          mode = [ "n" ];
          options.desc = "Scroll left";
        }
        {
          key = "<C-S-l>";
          action = "20zl";
          mode = [ "n" ];
          options.desc = "Scroll right";
        }

        # Flash navigation
        {
          key = "ä";
          action.__raw = "function() require(\"flash\").jump() end";
          mode = [
            "n"
            "x"
            "o"
          ];
          options.desc = "Flash jump";
        }
        {
          key = "Ä";
          action.__raw = "function() require(\"flash\").treesitter() end";
          mode = [
            "n"
            "x"
            "o"
          ];
          options.desc = "Flash treesitter";
        }

        # Add empty lines in normal mode
        {
          key = "<leader>o";
          action = "o<ESC>";
          mode = [ "n" ];
          options.desc = "Add empty line below";
        }
        {
          key = "<leader>O";
          action = "O<ESC>";
          mode = [ "n" ];
          options.desc = "Add empty line above";
        }

        # Clipboard interaction
        {
          key = "<leader>y";
          action = "\"+y";
          mode = [
            "n"
            "v"
          ];
          options.desc = "Yank to clipboard";
        }
        {
          key = "<leader>d";
          action = "\"+d";
          mode = [
            "n"
            "v"
          ];
          options.desc = "Delete into clipboard";
        }
        {
          key = "<leader>p";
          action = "\"+p";
          mode = [
            "n"
            "v"
          ];
          options.desc = "Paste from clipboard (after)";
        }
        {
          key = "<leader>P";
          action = "\"+P";
          mode = [
            "n"
            "v"
          ];
          options.desc = "Paste from clipboard (before)";
        }

        # File explorer and picker
        {
          key = "<leader>e";
          action = "<cmd>Yazi<cr>";
          mode = [
            "n"
            "v"
          ];
          options.desc = "Yazi at current buffer";
        }
        {
          key = "<leader>E";
          action = "<cmd>Yazi cwd<cr>";
          mode = [
            "n"
            "v"
          ];
          options.desc = "Yazi in CWD";
        }
        {
          key = "<leader>f";
          action.__raw = "function() Snacks.picker.files() end";
          mode = [ "n" ];
          options.desc = "Pick file";
        }

        # Search
        {
          key = "<leader>sf";
          action.__raw = "function() Snacks.picker.lines() end";
          mode = [ "n" ];
          options.desc = "Search in current file";
        }
        {
          key = "<leader>sw";
          action.__raw = "function() Snacks.picker.grep() end";
          mode = [ "n" ];
          options.desc = "Search files in CWD";
        }
        {
          key = "<leader>sd";
          action.__raw = "function() Snacks.picker.diagnostics_buffer() end";
          mode = [ "n" ];
          options.desc = "Search file diagnostics";
        }
        {
          key = "<leader>sc";
          action.__raw = "function() Snacks.picker.commands() end";
          mode = [ "n" ];
          options.desc = "Search commands";
        }
        {
          key = "<leader>sk";
          action.__raw = "function() Snacks.picker.keymaps() end";
          mode = [ "n" ];
          options.desc = "Search keymaps";
        }
        {
          key = "<leader>sh";
          action.__raw = "function() Snacks.picker.help() end";
          mode = [ "n" ];
          options.desc = "Search help pages";
        }
        {
          key = "<leader>sn";
          action.__raw = "function() Snacks.picker.notifications() end";
          mode = [ "n" ];
          options.desc = "Search notifications";
        }

        # LSP
        {
          key = "<leader>cf";
          action = "<cmd>lua vim.lsp.buf.format({async = true})<cr>";
          options.desc = "Format code";
        }
        {
          key = "<leader>ck";
          action = "<cmd>lua vim.lsp.buf.hover()<cr>";
          options.desc = "Hover Info";
        }
        {
          key = "<leader>cd";
          action = "<cmd>lua vim.lsp.buf.definition()<cr>";
          options.desc = "Go to definition";
        }
        {
          key = "<leader>cD";
          action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
          options.desc = "Go to declaration";
        }
        {
          key = "<leader>cs";
          action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
          options.desc = "Signature help";
        }
        {
          key = "<leader>cr";
          action = "<cmd>lua vim.lsp.buf.rename()<cr>";
          options.desc = "Rename";
        }
        {
          key = "<leader>ca";
          action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
          options.desc = "Code actions";
        }
        {
          key = "<leader>ct";
          action = "<cmd>lua vim.diagnostic.open_float()<CR>";
          options.desc = "Show line diagnostics";
        }

        # Disable q: command history shortcut
        {
          key = "q:";
          action = "<nop>";
          options.desc = "Nothing";
        }
      ];

    };
in
{
  flake-file.inputs = {
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.${name} = customPackage pkgs;
    };
}
