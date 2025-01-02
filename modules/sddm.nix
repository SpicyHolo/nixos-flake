{ pkgs, config, lib, ... }: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    sugarCandyNix = {
      enable = true; # This set SDDM's theme to "sddm-sugar-candy-nix".
      settings = {
        Background = lib.cleanSource ../shared/rainnight.jpg;
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        FormPosition = "center";
        HaveFormBackground = false;
        FullBlur = true;
        ForceHideCompletePassword = true;
        ForceLastUser = true;
        ForcePasswordFocus = true;
        HeaderText = "";
      };
    };
  };
}
