# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, lib, ... }:
{
  imports = [
    ../modules/hyprland.nix
    ../modules/sddm.nix

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

  services.printing.enable = true;

  networking.hostName = "nixos-holo"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.nameservers = ["8.8.8.8" "8.8.4.4"];

  # Allow unfree
  nixpkgs.config.allowUnfree = true;
  
  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Japanese language support
  
  # Fonts, DejaVu for english, IPA for Japanese
  fonts.packages = with pkgs; [
    ipafont
    fira-code
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
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

  # IME (Japanese Input)
  #i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.type = "fcitx5";
  i18n.inputMethod.enable = true;
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-mozc # JP fcitx5 engine?
    fcitx5-gtk # GTK support
  ];
  
  # Pipewire audio mixer
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}



