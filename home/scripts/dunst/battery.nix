{ pkgs, ... }:
let
  dunstifyBattery = pkgs.writeShellScriptBin "dunstify-battery" ''
    function get_volume {
      pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -1 | tr -d '%'
    }

    function is_mute {
      pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'
    }

    function send_notification {
      VOLUME=$(get_volume)
      MUTE=$(is_mute)
      
      BAR=$(seq -s "─" $(($VOLUME/5)) | sed 's/[0-9]//g')
      echo "Volume: $VOLUME, muted: $MUTE"
      echo "$BAR"
      if [ "$MUTE" = "yes" ]; then
          ICON="󰖁 " # Muted icon
      else
          if [ "$VOLUME" -le 30 ]; then
              ICON=" " # Low volume icon
          elif [ "$VOLUME" -le 70 ]; then
              ICON=" " # Medium volume icon
          else
              ICON=" " # High volume icon
          fi
      fi
      dunstify -u low -t 1000 "$ICON $VOLUME $BAR"
    }

    send_notification
  '';
in
{
  home.packages = [
    dunstifyBattery
  ];
}





