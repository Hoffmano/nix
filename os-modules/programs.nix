{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ home-manager ];
  programs.zsh.enable = true;
  virtualisation.docker.enable = true;

  networking = {
    firewall = {
      allowedTCPPorts = [ 22 80 443 8080 3000 5432 ];
    };
  };

  services = {
    udisks2.enable = true;
    openssh.enable = true;
    logind.extraConfig = ''
      HandleLidSwitch = "ignore"
      HandleLidSwitchExternalPower = "ignore"
      HandleLidSwitchDocked = "ignore"
    '';
  };
}
