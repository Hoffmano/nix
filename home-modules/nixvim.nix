{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    # colorschemes.catppuccin.enable = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    globalOpts = {
      number = true;
      relativenumber = true;

      signcolumn = "yes";

      ignorecase = true;
      smartcase = true;

      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 0;
      expandtab = true;
      smarttab = true;

      clipboard = "unnamedplus";

      cursorline = true;

      ruler = true;

      gdefault = true;

      scrolloff = 5;
    };

    keymaps = [
      {
        key = "<C-h>";
        action = "<C-w>h";
        mode = "n";
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        mode = "n";
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        mode = "n";
      }

      {
        key = "<C-l>";
        action = "<C-w>l";
        mode = "n";
      }
      {
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Write";
        mode = "n";
      }
      {
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quit";
        mode = "n";
      }
      {
        key = "<leader><leader>";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find files";
        mode = "n";
      }
      {
        key = "<leader>tb";
        action = "<cmd>Telescope file_browser <CR>";
        options.desc = "Files browser";
        mode = "n";
      }
      {
        key = "<leader>g";
        action = "<cmd>LazyGit<CR>";
        mode = "n";
      }
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Neotree";
        mode = "n";
      }
    ];

    extraPlugins = [
      pkgs.vimPlugins.telescope-file-browser-nvim
    ];
    extraConfigLua = ''
            require("telescope").load_extension("lazygit")

      kind_icons = {
        Text = "󰊄",
          Method = "",
          Function = "󰡱",
          Constructor = "",
          Field = "",
          Variable = "󱀍",
          Class = "",
          Interface = "",
          Module = "󰕳",
          Property = "",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
            }
    '';
    plugins = {
      lualine = { enable = true; };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          experimental = { ghost_text = true; };
          snippet = {
            expand = "luasnip";
          };
          formatting = {
            fields = [
              "kind"
              "abbr"
              "menu"
            ];
          };
          sources = [
            {
              name = "nvim_lsp";
            }
            {
              name = "path";
            }
            {
              name = "buffer";
            }
            {
              name = "luasnip";
            }
          ];
          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item (), { 'i', 's' })";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          };
        };
      };
      cmp-buffer = { enable = true; };
      lazygit = { enable = true; };
      nix = { enable = true; };
      illuminate = { enable = true; };
      persistence = { enable = true; };
      noice = { enable = true; };
      comment = { enable = true; };
      todo-comments = { enable = true; };
      cmp-nvim-lsp = { enable = true; };
      cmp-path = { enable = true; };
      cmp_luasnip = { enable = true; };
      lint = {
        enable = true;
        lintersByFt = {
          text = [ "vale" ];
          json = [ "jsonlint" ];
          markdown = [ "markdownlint" ];
          ruby = [ "ruby" ];
          html = [ "htmlhint" ];
          inko = [ "inko" ];
          clojure = [ "clj-kondo" ];
          dockerfile = [ "hadolint" ];
          python = [ "black" ];
          zsh = [ "zsh" ];
          typescript = [ "tslint" ];
          javascript = [ "eslint" ];
        };
      };
      friendly-snippets = { enable = true; };
      nvim-autopairs = { enable = true; };
      telescope = { enable = true; };
      bufferline = { enable = true; };
      surround = { enable = true; };
      flash = { enable = true; };
      treesitter = { enable = true; };
      lsp = { enable = true; };
      lsp-format = { enable = true; };
      lsp-lines = { enable = true; };
      none-ls = {
        enable = true;
        sources = {
          code_actions = {
            statix.enable = true;
            gitsigns.enable = true;
          };
          diagnostics = {
            statix.enable = true;
            deadnix.enable = true;
            pylint.enable = true;
            checkstyle.enable = true;
          };
          formatting = {
            alejandra.enable = true;
            stylua.enable = true;
            shfmt.enable = true;
            nixpkgs_fmt.enable = true;
            google_java_format.enable = false;
            prettier = {
              enable = true;
              disableTsServerFormatter = true;
            };
            black = {
              enable = true;
            };
          };
          completion = {
            luasnip.enable = true;
            spell.enable = true;
          };
          hover = {
            dictionary = { enable = true; };
          };
        };
      };
      which-key = {
        enable = true;
        keyLabels = {
          "<leader>" = "Space";
          "<bs>" = "Backspace";
          "<esc>" = "Esc";
        };
        registrations = {
          "<Leader>t" = "Telescope";
        };
      };
      neo-tree = { enable = true; };
    };
  };
}
