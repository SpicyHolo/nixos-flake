{ config, pkgs, ... }:

{
  imports =
    [ 
      ./discord.nix
      ./gnome.nix
      ./git.nix
    ];

  
  home.username = "holo";
  home.homeDirectory = "/home/holo";
  
  # don't change >:(
  home.stateVersion = "23.11";

  # Install packages for user
  home.packages = with pkgs; [
    anki-bin
    firefox
    tree
    neofetch
    vscode
    qbittorrent
    starship
    mpv
    libsForQt5.okular
    thunderbird
    prismlauncher

    # spotify
    spotify
    spicetify-cli
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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
    ".bashrc" = {
      text = ''
        eval "$(starship init bash)"
      '';
    };

  };

  home.sessionVariables = {
    EDITOR = "nvim"; # Default text editor
    TERM = "kitty"; # Default terminal
    GTK_THEME = "Catppuccin-Macchiato-Compact-Mauve-Dark"; # GTK Theme
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Enable starship
  programs.starship = { 
    enable = true;
    settings = {
      format = "$username$directory$character$all";
      add_newline = true;
      character = {
        success_symbol = "[➜](bold purple)";
        error_symbol = "[➜](bold red)";        
      };

    };
  };
}

