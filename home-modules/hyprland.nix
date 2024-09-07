{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      xwayland
    ];
  };
  programs.waybar.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      exec-once = [
        "waybar"
        "hyprlock"
      ];

      bind = [
        "$mod SHIFT, q, exec, pkill Hyprland"
        "$mod, q, killactive,"
        "$mod, g, togglegroup,"
        "$mod, r, togglesplit,"
        "$mod, z, fullscreen, 1"

        "$mod, SPACE, exec, wofi --show drun"
        "$mod, t, layoutmsg, orientationleft"
        "$mod, i, layoutmsg, addmaster"
        "$mod, o, layoutmsg, cyclenext"
        "$mod, y, layoutmsg, swapprev"
        "$mod, m, layoutmsg, focusmaster"

        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod CRTL, h, workspace, m-1"
        "$mod CRTL, l, workspace, m+1"

        "$mod SHIFT, h, focusmonitor, l"
        "$mod SHIFT, l, focusmonitor, r"

        "$mod, Return, exec, alacritty"
        "$mod, w, exec, firefox"
      ];
    };
  };
}
