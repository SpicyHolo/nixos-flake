_: 
let
  fcitxScript = ''
    # Get the current input method from fcitx5-remote
    current_input=$(fcitx5-remote)

    if [ "$current_input" -eq 1 ]; then
        echo "A"
    elif [ "$current_input" -eq 2 ]; then
        echo "あ"
    else
        echo "?"
    fi
  '';
in {
  mainBar = {
    layer = "top";
    height = 20;
    modules-left = ["custom/nix" "hyprland/workspaces" "clock"];
    modules-center = ["custom/player" "cava"];
    modules-right = [
      "backlight"
      "network"
      "pulseaudio"
      "battery"
      "custom/powermenu"
    ];

    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
        "10" = "十";
      };
      "persistent-workspaces" = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
      "sort-by-number" = true;
    };

    "custom/nix" = {
      format = "󱄅 ";
      tooltip = false;
      on-click-release = "bemenu-run";
    };

    "custom/player" = {
      format = "Playing: <span>{}</span>";
      return-type = "json";
      max-length = 40;
      exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
      on-click = "";
    };


    "cava" = {
      framerate = 60;
      bars = 16;
      bar_delimiter = 0;
      hide_on_silence = true;
      stereo = false;
      format-icons = [
        "<span>▁</span>"
        "<span>▂</span>"
        "<span>▃</span>"
        "<span>▄</span>"
        "<span>▅</span>"
        "<span>▆</span>"
        "<span>▇</span>"
        "<span>█</span>"
      ];
    };

    "clock" = {
      format = "󰸗  {:%a %d/%m %H:%M} ";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };

    "backlight" = {
      format = "󰛨  {percent}%";
    };

    "battery" = {
      states = {
        good = "95";
        warning = "30";
        critical = "15";
      };
      format = "{icon} {capacity}%";
      tooltip-format = "{time} {capacity}%";
      format-charging = "󰂄  {capacity}%";
      format-plugged = " ";
      format-icons = ["  " "  " "  " "  " "  "];
    };

    "network" = {
      format-wifi = "󰤨  {essid}";
      format-ethernet = "󰈀  Ethernet";
      format-linked = "{ifname} (No IP) 󰈀 ";
      format-disconnected = "󰤮  Disconnected";
      on-click = "foot -e nmtui";
      tooltip-format = "{essid} {signalStrength}%";
    };

    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = "󰖁  {volume}%";
      format-icons = {
        default = [" " " " " "];
      };
      on-click = "pavucontrol";
    };

    "custom/powermenu" = {
      format = " ";
      on-click = "$HOME/.config/rofi/powermenu/powermenu.sh";
    };
    "custom/fcitx" = {
      exec = "fcitx5-remote";
      interval = 1;
      format = "{output}";
      tooltip = "Input Method";
    };
  };
}


