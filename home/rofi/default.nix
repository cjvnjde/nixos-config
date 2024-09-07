{
  lib,
  config,
  pkgs,
  ...
}: {
  home.file."${config.xdg.configHome}/rofi/theme.rasi".source = ./theme.rasi;

  programs.rofi = let
  inherit (config.lib.formats.rasi) mkLiteral;
  in {
    enable = true;
    cycle = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    plugins = with pkgs; [ rofi-calc ];
    font = "FiraCode 14";
    location = "center";
    extraConfig = {
      modes =   "drun,run,calc";
      sidebar-mode = true;
          icon-theme = "Oranchelo";
          show-icons = true;
          drun-display-format = "{icon} {name}";
          disable-history = false;
          hide-scrollbar = true;
          display-drun ="   Apps ";
          display-run= "   Run ";
          display-window=" 﩯  Window";
          display-Network= " 󰤨  Network";
    };
    theme = "theme";
  };
}