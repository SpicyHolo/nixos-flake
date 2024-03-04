{ pkgs, ... }:
# Remember to configure ssh
{
  programs.git = {
    enable = true;

    userName = "SpicyHolo";
    userEmail = "41269364+SpicyHolo@users.noreply.github.com";

    extraConfig = {
      color.ui = "auto";
      pull.rebase = false;
      init.defaultBranch = "main";
    };
  };
}