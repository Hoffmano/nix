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
