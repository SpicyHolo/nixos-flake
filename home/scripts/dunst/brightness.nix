{ pkgs, ... }:
let
  dunstifyBrightness = pkgs.writeShellScriptBin "dunstify-brightness" ''
    function get_brightness {
      current=$(brightnessctl get)
      max=$(brightnessctl max)
      percentage=$(( 100 * current / max ))
      echo $percentage
    }

    function send_notification {
      BRIGHTNESS=$(get_brightness)
      ICON="󰃠 "
      dunstify -h int:value:$BRIGHTNESS -r 102 -u low -t 1000 "$ICON $BRIGHTNESS $BAR"
    }

    send_notification
  '';
in
{
  home.packages = [
    dunstifyBrightness
  ];
}





