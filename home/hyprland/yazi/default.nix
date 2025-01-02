{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [
    yazi 
  ];

  programs.yazi = {
    enable = true;
  };
}
