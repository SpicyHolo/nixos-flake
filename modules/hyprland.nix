{ config, pkgs, lib, hyprland, ...}: 

{
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland; #hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true; 
  };
}
