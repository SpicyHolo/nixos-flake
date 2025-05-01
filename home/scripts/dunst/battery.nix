{ pkgs, ... }:
let
  dunstifyBattery = pkgs.writeShellScriptBin "dunstify-battery" ''
    function send_notification {
      BATTERY=$(upower -e | grep battery)

      PERCENTAGE=$(upower -i $BATTERY | grep "percentage" | awk '{print $2}' | tr -d '%')
      STATUS=$(upower -i $BATTERY | grep "state" | awk '{print $2}')
      ICON=$(upower -i $BATTERY | grep "icon-name" | awk '{print $2}')
      
      if [ $STATUS == "charging" ]
      then
        dunstify -u low -t 1000 "$ICON Battery charging."
      else
        dunstify -u low -t 1000 "$ICON $PERCENTAGE "
      fi
    }
    send_notification
  '';
in
{
  home.packages = [
    dunstifyBattery
  ];
}





