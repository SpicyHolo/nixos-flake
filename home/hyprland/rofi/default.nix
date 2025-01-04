{ pkgs, config, lib, ...}:
let
  rofiFiles =pkgs.fetchFromGitHub {
    owner = "adi1090x";
    repo = "rofi";
    rev = "master";
    sha256= "0csvs6y7gxnq7i9ibfjy6crcbblh2nlnp1m14mysfrv06yhpnmjd";
  };
  
  colorScheme = "catppuccin";
  
  rofiThemeTemplate = ''
    @import "~/.config/rofi/colors/${colorScheme}.rasi";  # Use the variable for the color scheme
  '';

  in {
  home.file.".config/rofi".source = "${rofiFiles}/files";
  home.file.".config/rofi/launchers/type-2/shared/colors.rasi".text = rofiThemeTemplate;
  home.packages = with pkgs; [
    rofi-power-menu
  ];

  programs.rofi = {
    enable = true;
    terminal = "kitty";
    package = pkgs.rofi-wayland; 
    extraConfig = {
        modes = "window,drun,run,ssh,combi,calc,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
    };
  };
}

