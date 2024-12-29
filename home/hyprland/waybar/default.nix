{ pkgs, lib, config, ...}:
let
  waybar_config = import ./config.nix { inherit pkgs lib config; };
  waybar_style = import ./style.nix {inherit (config) colorscheme; };
in {
  home.packages = with pkgs; [
    cava
    playerctl
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = waybar_config;
    style = waybar_style;
  };
}
