# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, lib, ... }:
{
  imports = [
    ../modules/hyprland.nix
    ../modules/sddm.nix
    ../modules/hyprlock.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Boot loader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
	      editor = false;
	      configurationLimit = 100;
      };
    };
  };

# Enable samba service
  services.samba = {
    enable = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";  # Uncomment if you want to enable this option
        #"max protocol" = "smb2";  # Uncomment for SMB2 protocol
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };

      public = {
        "path" = "/mnt/Shares/Public";  # Make sure this path exists
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "username";    # Replace with actual username
        "force group" = "groupname";  # Replace with actual group name
      };

      private = {
        "path" = "/mnt/Shares/Private";  # Make sure this path exists
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "username";    # Replace with actual username
        "force group" = "groupname";  # Replace with actual group name
      };
    };
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.epson-escpr ];

  networking = {
    hostName = "nixos-holo"; # Define your hostname.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    nameservers = ["8.8.8.8" "8.8.4.4"];
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  
  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = { LC_TIME = "ja_JP.UTF-8"; };
    
    # Japanese input
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.waylandFrontend = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-nord # Theme
      ];
    };
  };

  # Fonts, DejaVu for english, IPA for Japanese
  fonts.packages = with pkgs; [
    ipafont
    fira-code
    fira-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    icomoon-feather
    iosevka
    nerd-fonts.iosevka
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "Fira Mono"
      "IPAMono"
    ];
    sansSerif = [
      "Fira Sans"
      "IPAPGothic"
    ];
    serif = [
      "Fira Serif"
      "IPAPMincho"
    ];
  };

  # Battery info
  services.upower.enable = true;

  # Pipewire audio mixer
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
};

  # Bluetooth support pipewire (future lua support)
  services.pipewire.wireplumber.configPackages = [
	(pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		} '')
  ];
  
  # Bluetooth
  hardware.bluetooth.enable = true;

  # Bluetooth manager
  services.blueman.enable = true;
  services.dbus.enable = true;
  
  # OpenGL / OpenCL support
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = [ pkgs.intel-compute-runtime ];
  
  #environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.holo = {
     isNormalUser = true;
     home = "/home/holo";
     description = "Holo";
     extraGroups = [ "wheel" "networkmanager" "docker"]; # Enable ‘sudo’ for the user.
   };
  
  environment.systemPackages = with pkgs; [
    neofetch
    xorg.xhost
    pavucontrol
    ntfs3g
    upower
    samba
    cifs-utils
  ];
  
  # Change shell to starship
  users.users.holo.shell = pkgs.bashInteractive;
  
  # Auto update nixos, unstable
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Auto purge older generations
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Add flakes support
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Enable wireless mouse support
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable nix-ld
  programs.nix-ld.enable = true;
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 137 138 139 445 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.11"; # Did you read the comment?
}



