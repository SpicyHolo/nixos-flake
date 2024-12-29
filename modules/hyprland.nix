{ config, pkgs, lib, ...}: 

{
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland; 
    xwayland.enable = true; 
  };
}
