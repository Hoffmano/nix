{ pkgs, ... }: {
  users = {
    users.hoffmano = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
    };
    defaultUserShell = pkgs.zsh;
  };
}
