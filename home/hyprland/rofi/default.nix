{ pkgs, config, lib, ...}:

{
  programs.rofi = {
    package = pkgs.rofi;
    enable = true;
    settings = {
      # General settings
      modi = "drun,run,filebrowser,window";
      case-sensitive = false;
      cycle = true;
      filter = "";
      scroll-method = 0;
      normalize-match = true;
      show-icons = true;
      icon-theme = "Papirus";
      steal-focus = false;

      # Matching settings
      matching = "normal";
      tokenize = true;

      # SSH settings
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      parse-hosts = true;
      parse-known-hosts = true;

      # Drun settings
      drun-categories = "";
      drun-match-fields = "name,generic,exec,categories,keywords";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      drun-show-actions = false;
      drun-url-launcher = "xdg-open";
      drun-use-desktop-cache = false;
      drun-reload-desktop-cache = false;
      drun.parse-user = true;
      drun.parse-system = true;

      # Run settings
      run-command = "{cmd}";
      run-list-command = "";
      run-shell-command = "{terminal} -e {cmd}";

      # Fallback Icon
      run.fallback-icon = "application-x-addon";
      drun.fallback-icon = "application-x-addon";

      # Window switcher settings
      window-match-fields = "title,class,role,name,desktop";
      window-command = "wmctrl -i -R {window}";
      window-format = "{w} - {c} - {t:0}";
      window-thumbnail = false;

      # History and Sorting
      disable-history = false;
      sorting-method = "normal";
      max-history-size = 25;

      # Display settings
      display-window = "Windows";
      display-windowcd = "Window CD";
      display-run = "Run";
      display-ssh = "SSH";
      display-drun = "Apps";
      display-combi = "Combi";
      display-keys = "Keys";
      display-filebrowser = "Files";

      # Misc settings
      terminal = "rofi-sensible-terminal";
      font = "Mono 12";
      sort = false;
      threads = 0;
      click-to-exit = true;

      # File browser settings
      filebrowser.directories-first = true;
      filebrowser.sorting-method = "name";

      # Timeout settings
      timeout.action = "kb-cancel";
      timeout.delay = 0;
    };
  };
}
