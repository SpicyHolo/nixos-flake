{ pkgs, config, lib, ...}:
{
  catppuccin.dunst.enable = true;
  services.dunst = {
    enable = true;
     
  };
}

