{ config, pkgs, ...} : {
    programs.kitty = {
        enable = true;
        themeFile = "Catppuccin-Mocha";
        settings = {
            font_family = "FiraCode Nerd Font";
            font_size = 13;

            # Style window
            window_padding_width = 20;
            background_opacity = "0.95";
            confirm_os_window_close = 0;
            hide_window_decoration = "yes";


            # Style tab bar
            tab_bar_min_tabs = 1;
            tab_bar_edge = "bottom";
            tab_bar_style = "powerline";
            tab_powerline_style = "slanted";
            tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
            
            # Tweaks
            enable_audio_bell = "no"; 
        };
        keybindings = {
            "ctrl+1" = "goto_tab 1";
            "ctrl+2" = "goto_tab 2";
            "ctrl+3" = "goto_tab 3";
            "ctrl+4" = "goto_tab 4";
        };
    };
}
