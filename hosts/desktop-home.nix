{ config
, pkgs
, ...
}: {
  imports = [
    ../home-modules/zsh.nix
    ../home-modules/nixvim.nix
    ../home-modules/sytlix.nix
    ../home-modules/firefox.nix
    ../home-modules/hyprland.nix
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home = {
    username = "hoffmano";
    homeDirectory = "/home/hoffmano";
    stateVersion = "24.05";
    packages = with pkgs; [
      curl
      alacritty
      wofi
      ungoogled-chromium
      lf
    ];
  };

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      userName = "Hoffmano";
      userEmail = "hoffman.devs@gmail.com";
    };
  };
}
