{ pkgs, ... }:
let
  dunst-volume = pkgs.writeShellScriptBin "rename-images" ''
    function get_volume {
      pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -1 | tr -d '%'
    }

    function is_mute {
      pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'
    }

    function send_notification {
      volume=`get_volume`
      isMute=`is_mute`
      echo volume
      echo isMute
    }
  '';
in
{
  imports = [ 
    ./dunst
  ];
  
  home.packages = [
    dunst-volume
  ];
}





