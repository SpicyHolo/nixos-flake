{ pkgs, config, lib, ...}: {
  services.displayManager.sddm = {
    enable = true;
    waylend.enable = true;
  };
}
