{ pkgs, ... }: {
  home.packages = [ pkgs.zsh ];
  programs = {
    zoxide.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        editNix = "nvim /home/hoffmano/serverFlake/home.nix";
        la = "ls -a";
        ll = "ls -l";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
      };
    };
  };
}
