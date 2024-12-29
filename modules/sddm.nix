{ pkgs, config, lib, ... }: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enablbe = true;
  };
}
