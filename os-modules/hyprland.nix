{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;

  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
  };
}
