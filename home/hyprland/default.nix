
{ pkgs, lib, hyprland-plugins, hyprland, ...}:
{

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    settings = {
       monitor = ", preferred, auto, 1.2";
        
      # Default apps
      "$browser" = "firefox";
      "$terminal" = "kitty";
      
      exec-once = [
        "hyprctl setcursor Qogir 24"
        "waybar"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(e5b9c6ff) rgba(c293a3ff) 45deg";
        "col.inactive_border" = "0xff382D2E";
        no_border_on_floating = false;
        layout = "dwindle";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        vfr = true;
        vrr = 0;
        animate_manual_resizes = true;
        mouse_move_focuses_monitor = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          xray = true;
          ignore_opacity = true;
        };
        shadow = {
          enabled = false;
          ignore_window = true;
          offset = "1 2";
          range = 10;
          render_power = 5;
          color = "0x66404040";
        };
      };



      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      ### Keybinds
       bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        ws = binding "SUPER" "workspace";
        resizeactive = binding "SUPER CTRL" "resizeactive";
        mvactive = binding "SUPER ALT" "moveactive";
        mvtows = binding "SUPER SHIFT" "movetoworkspace";
        arr = [1 2 3 4 5 6 7];
      in [
        # Apps shortcuts
        "SUPER, W, exec,  $browser"
        "SUPER, Q, exec,  $terminal"

        # Window Managment
        "ALT, Tab,          focuscurrentorlast"
        "ALT, W,            killactive"
        "CTRL ALT, delete,  exit"
        "SUPER, F,          togglefloating"
        "SUPER, G,          fullscreen"
        "SUPER, P,          togglesplit"

        (mvfocus "k" "u")
        (mvfocus "j" "d")
        (mvfocus "l" "r")
        (mvfocus "h" "l")
        (ws "page_up" "e-1")
        (ws "page_down" "e+1")
        (mvtows "page_up" "e-1")
        (mvtows "page_down" "e+1")
        (resizeactive "k" "0 -20")
        (resizeactive "j" "0 20")
        (resizeactive "l" "20 0")
        (resizeactive "h" "-20 0")
        (mvactive "k" "0 -20")
        (mvactive "j" "0 20")
        (mvactive "l" "20 0")
        (mvactive "h" "-20 0")
       ] 
       ++ (map (i: ws (toString i) (toString i)) arr)
       ++ (map (i: mvtows (toString i) (toString i)) arr);
    };
  };
}

