
{ config, pkgs, ... }:
{
  imports = [
    ./volume.nix
    ./brightness.nix
    ./battery.nix
  ];
}
