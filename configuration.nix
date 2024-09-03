{ config
, lib
, pkgs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        device = "nodev";
        enable = true;
        efiSupport = true;
        useOSProber = true;
      };
    };
    kernelParams = [ "consoleblank=10" ];
  };

  users = {
    users.hoffmano = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
    defaultUserShell = pkgs.zsh;
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.catppuccin.enable = true;
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

    keymaps =
      let
        normal =
          lib.mapAttrsToList
            (key: action: {
              mode = "n";
              inherit action key;
            })
            {
              "C-h" = "<C-w>h";
              "C-j" = "<C-w>j";
              "C-k" = "<C-w>k";
              "C-l" = "<C-w>l";
              "<M-k>" = ":move-2<CR>";
              "<M-j>" = ":move+<CR>";
            };
        visual =
          lib.mapAttrsToList
            (key: action: {
              mode = "v";
              inherit action key;
            })
            {
              "M-k" = ":m '<-2<CR>gv=gv";
              "M-j" = ":m '>+1<CR>gv=gv";
            };
      in
      config.nixvim.helpers.keymaps.mkKeymaps
        { options.silent = true; }
        (normal ++ visual);

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
          snippet = { expand = "luasnip"; };
          formatting = { fields = [ "kind" "abbr" "menu" ]; };
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
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
      nvim-snippets = { enable = true; };
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
        settings = {
          diagnostics_format = "[#{c}] #{m} (#{s})";
          on_attach = ''
            function(client, bufnr)
              -- Integrate lsp-format with none-ls
              require('lsp-format').on_attach(client, bufnr)
            end
          '';
          on_exit = ''
            function()
              print("Goodbye, cruel world!")
            end
          '';
          on_init = ''
            function(client, initialize_result)
              print("Hello, world!")
            end
          '';
          root_dir = ''
            function(fname)
              return fname:match("my-project") and "my-project-root"
            end
          '';
          root_dir_async = ''
            function(fname, cb)
              cb(fname:match("my-project") and "my-project-root")
            end
          '';
          should_attach = ''
            function(bufnr)
              return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
            end
          '';
          temp_dir = "/tmp";
          update_in_insert = false;
        };
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
              settings = ''
                {
                   extra_args = { "--fast" },
                }
              '';
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
        settings = {
          delay = 100;
          expand = 1;
          notify = false;
          preset = false;
          replace = {
            desc = [
              [
                "<space>"
                "SPACE"
              ]
              [
                "<leader>"
                "SPACE"
              ]
              [
                "<[cC][rR]>"
                "RETURN"
              ]
              [
                "<[tT][aA][bB]>"
                "TAB"
              ]

              [
                "<[bB][sS]>"
                "BACKSPACE"
              ]
            ];
          };

          spec = [
            {
              desc = "Lazygit";
              __unkeyed-1 = "<leader>g";
              __unkeyed-2 = "<cmd>Lazygit<CR>";
            }
            {
              desc = "Save";
              __unkeyed-1 = "<leader>w";
              __unkeyed-2 = "<cmd>w<CR>";
            }
            {
              desc = "Neotree";
              __unkeyed-1 = "<leader>e";
              __unkeyed-2 = "<cmd>Neotree toggle<CR>";
            }
            {
              desc = "Telescope Find Files";
              __unkeyed-1 = "<leader><leader>";
              __unkeyed-2 = "<cmd>Telescope file_browser<CR>";
            }
            {
              desc = "Close Neovim";
              __unkeyed-1 = "<leader>c";
              __unkeyed-2 = "<cmd>qa<CR>";
            }
          ];
        };
      };
      neo-tree = { enable = true; };
    };
  };
  environment.systemPackages = with pkgs; [ home-manager ];

  programs.zsh.enable = true;

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    xserver.xkb.layout = "us";
    xserver.xkb.variant = "intl";
    openssh.enable = true;
    logind.extraConfig = ''
      HandleLidSwitch = "ignore"
      HandleLidSwitchExternalPower = "ignore"
      HandleLidSwitchDocked = "ignore"
    '';
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "hoffman.devs@gmail.com";
      group = "nginx";
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];

  services.nginx = {
    enable = true;
    virtualHosts."hoffmano.duckdns.org" = {
      serverAliases = [ "www.hoffmano.duckdns.org" ];
      root = "/var/www/hoffmano.duckdns.org";
    };
  };

  systemd.services.duckdns = {
    description = "DuckDNS update service";
    after = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/home/hoffmano/scripts/update-duckdns.sh";
    };
  };

  systemd.timers.duckdns = {
    description = "Run DuckDNS update script periodically";
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "1m";
    };
    wantedBy = [ "timers.target" ];
  };

  networking = {
    nftables.enable = true;
    firewall = {
      allowedTCPPorts = [ 22 80 443 8080 ];
    };
  };

  system.stateVersion = "24.05";
}
