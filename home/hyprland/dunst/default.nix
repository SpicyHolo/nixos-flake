{ pkgs, config, lib, ...}:
{
  catppuccin.dunst.enable = true;
  services.dunst = {
    enable = true;
    settings = {
      global = {
        indicate_hidden = "yes";
        shrink = "no";
        notification_height = 0;
        gap_size = 3;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 0;
        sort = "yes";
        font = "FiraMono Nerd Font Medium 12";
        line_height = 0;
        markup = "full";
        progress_bar_frame_width = 0;
        progress_bar_height = 3;
        background = "#11111bbf";
        corner-radius = 4;
      }; 
    };
  }; 
}

