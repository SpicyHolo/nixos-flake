{ pkgs, ... }: 

{
  # GTK config
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        size = "compact";
        accents = [ "mauve" ];
        tweaks = [ "rimless" ];
      };
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  
  # Change cursor
  home.pointerCursor = {
    gtk.enable = true;
    #x11.enable = ture; # TODO

    name = "Catppuccin-Mocha-Mauve-Cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 28;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [

      ];
    };
  };
  home.packages = with pkgs; [
    gnomeExtensions.gtk-title-bar
  ];
}  
