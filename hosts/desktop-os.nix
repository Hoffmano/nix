{ ... }: {
  imports = [
    ../os-modules/dell-latitude-hardware.nix
    ../os-modules/nix.nix
    ../os-modules/boot.nix
    ../os-modules/user.nix
    ../os-modules/programs.nix
    ../os-modules/hyprland.nix
  ];
}
