{ config, pkgs, lib, ...}: 
let
  hyprlock-blur = pkgs.writeShellScriptBin "hyprlock-blur" ''
    ${pkgs.hyprshot}/bin/hyprshot --silent -m DP-1 -m output -o /tmp -f screenshot1.png &
    ${pkgs.hyprshot}/bin/hyprshot --silent -m HDMI-A-1 -m output -o /tmp -f screenshot2.png &
    ${pkgs.hyprshot}/bin/hyprshot --silent -m eDP-1 -m output -o /tmp -f screenshot0.png &
    wait &&
    hyprlock
  '';
in {
  security.pam.services.hyprlock = {};

  environment.systemPackages = [ hyprlock-blur ];
} 
