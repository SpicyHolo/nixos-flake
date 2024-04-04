{ pkgs, ... }: 
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-console
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gnome-terminal
    epiphany
    geary
    evince
    gnome-characters
    totem
    gnome-contacts
    gnome-initial-setup
  ]);

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.gnome-themes-extra
    gnomeExtensions.kimpanel
    ];
}
