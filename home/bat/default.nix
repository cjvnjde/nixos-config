{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "mocha";
    };
    themes = {
      "mocha" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "main";
          sha256 = "1g73x0p8pbzb8d1g1x1fwhwf05sj3nzhbhb65811752p5178fh5k";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };
}
