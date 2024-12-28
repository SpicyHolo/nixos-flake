{ pkgs, ... }:

{
  imports =
    [ 
      #./gnome.nix
      ./hyprland.nix
      ./git.nix
      ./nvim
      ./starship.nix
      ./kitty.nix
    ];

  
  home.username = "holo";
  home.homeDirectory = "/home/holo";
  
  # don't change >:(
  home.stateVersion = "23.11";

  # Install packages for user
  home.packages = with pkgs; [
    anki-bin
    firefox
    libsForQt5.okular
    libreoffice-qt
    mpv
    neofetch
    obsidian
    prismlauncher
    qbittorrent
    sxiv
    thunderbird
    tree
    vesktop
    vscode
    feh
    telegram-desktop
    # spotify
    spotify
    spicetify-cli
        
    # mpvacious dep

    # LSP
    lua-language-server 
    nil
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'hme.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # Use starship with bash
  #  ".bashrc" = {
  #    text = ''
  #      eval "$(starship init bash)"
  #    '';
  #  };
  # 
  };

  home.sessionVariables = {
    EDITOR = "nvim"; # Default text editor
    TERM = "kitty"; # Default terminal
    GTK_THEME = "Catppuccin-Macchiato-Compact-Mauve-Dark"; # GTK Theme
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  

  # Enable starship
  
  # Steam

}



