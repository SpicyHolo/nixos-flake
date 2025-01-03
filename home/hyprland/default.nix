
{inputs, pkgs, config, lib, ...}: {
  imports = [ 
    ./waybar
    ./rofi
    ./yazi
  ];
  
  # Services
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      preload = "${config.home.homeDirectory}/wallpapers/rainnight.jpg";
      wallpaper = ", ${config.home.homeDirectory}/wallpapers/rainnight.jpg";
    };
  };
  

  # Fix electron apps
  home.sessionVariables.NIXOS_OZONE_WL = "1";


  home.packages = with pkgs; [
    pulseaudio # add pulsaudio cli
    cliphist
    wl-clipboard
    yazi
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    settings = {
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "GDK_BACKEND,wayland,x11"
        "MOZ_ENABLE_WAYLAND,1"
        "MOZ_DISABLE_RDD_SANDBOX,1"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      monitor = [
        "e-DP1, preferred, auto, 1.2"
        "DP-2, preferred, auto, 1"
        "HDMI-A-1, preferred, auto, 1"
      ];

      workspace = [
        "1, monitor:DP-2"
        "2, monitor:DP-2"
        "3, monitor:HDMI-A-1"
        "4, monitor:HDMI-A-1"
        "5, monitor:HDMI-A-1"
      ];
      
      windowrule = [
        "workspace 3, $browser"
        "workspace 4, vesktop"
        "workspace 5, Spotify"
      ];

      # Default apps
      "$browser" = "firefox";
      "$terminal" = "kitty";
      "$filebrowser" = "kitty -e yazi";
      "$applauncher" = "rofi -show drun";
      
      exec-once = [
        "hyprctl setcursor Qogir 24"
        "fcitx5 -d"
        "waybar"
        "wl-paste --watch cliphist store"
        "$terminal"
      ];

      general = {
        gaps_in = 12;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(3B294AFF)";
        "col.inactive_border" = "rgba(31313600)";
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
        rounding = 6;
        blur = {
            enabled = true;
            xray = true;
            special = false;
            new_optimizations = true;
            size = 4;
            passes = 4;
            brightness = 2;
            noise = 0;
            contrast = 2;
            popups = true;
            popups_ignorealpha = 0.6;
        };
        shadow = {
          enabled = false;
          ignore_window = false;
          range = 25;
          render_power = 2;
          color = "rgba(000000aa)";
          color_inactive = "rgba(1000002a)";
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
        "SUPER, Q, exec,  $terminal"
        "SUPER, W, exec,  $browser"
        "SUPER, E, exec,  $filebrowser"
        "SUPER, R, exec,  $applauncher"
  
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
      bindle = [
        ",XF86MonBrightnessUp,   exec, brightnessctl set +5%"
        ",XF86MonBrightnessDown, exec, brightnessctl set  5%-"
        ",XF86KbdBrightnessUp,   exec, brightnessctl -d asus::kbd_backlight set +1"
        ",XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set  1-"
        ",XF86AudioRaiseVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      ];

      bindl = [
        ", switch:off:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, 2560x1440, 0x0, 1'"
        ", switch:on:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, disable'"
      ];
    };
  };
}

