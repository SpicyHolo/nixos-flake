{ config, pkgs, lib, inputs, ...}: {
  programs.hyprland.enable = true;

  # Use hyprwm/Hyprland package
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;


}
