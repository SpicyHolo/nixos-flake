{ config, pkgs, lib, ...}: 
let
  hyprlock-blur = pkgs.writeShellScriptBin "hyprlock-blur" ''
    ${pkgs.hyprshot}/bin/hyprhsot -m DP-1 -m output -o /tmp/screenshot1.png" &
    ${pkgs.hyprshot}/bin/hyprhsot -m HDMI-A-1 -m output -o DP-1 -l 0 /tmp/screenshot2.png" &
    wait &&
    hyprlock
  '';
in {
  security.pam.services.hyprlock = {};

  environment.systemPackages = [ hyprlock-blur ];
}
