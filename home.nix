{ config
, pkgs
, inputs
, ...
}: {
  home = {
    username = "hoffmano";
    homeDirectory = "/home/hoffmano";
    stateVersion = "24.05";
    packages = with pkgs; [
      git
      #neovim
      curl
      nginx
      zsh
      nodejs
      thefuck
      neofetch
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # Add your custom settings here
    # Here's a good example: https://github.com/fufexan/dotfiles/blob/main/home/programs/wayland/hyprland/settings.nix
    settings = {
      "$mod" = "SUPER";
    };
  };

  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
  };
  programs.git = {
    enable = true;
    userName = "Hoffmano";
    userEmail = "hoffman.devs@gmail.com";
  };
}
