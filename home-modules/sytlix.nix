{ pkgs, ... }: {
  stylix = {
    enable = true;
    image = ./assets/bg.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  };
}
