{
  lib,
  config,
  pkgs,
  ...
}: {
  home.file."${config.xdg.configHome}/sway/assets/bg.jpg".source = ./assets/bg.jpg;

  wayland.windowManager.sway = let
    # Catpuccin mocha
    rosewater = "#f5e0dc";
    flamingo = "#f2cdcd";
    pink = "#f5c2e7";
    mauve = "#cba6f7";
    red = "#f38ba8";
    maroon = "#eba0ac";
    peach = "#fab387";
    yellow = "#f9e2af";
    green = "#a6e3a1";
    teal = "#94e2d5";
    sky = "#89dceb";
    sapphire = "#74c7ec";
    blue = "#89b4fa";
    lavender = "#b4befe";
    text = "#cdd6f4";
    subtext1 = "#bac2de";
    subtext0 = "#a6adc8";
    overlay2 = "#9399b2";
    overlay1 = "#7f849c";
    overlay0 = "#6c7086";
    surface2 = "#585b70";
    surface1 = "#45475a";
    surface0 = "#313244";
    base = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
  in {
    enable = true;
    checkConfig = false;
    config = rec {
      terminal = "kitty";
      modifier = "Mod4"; # win key
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      menu = "\"rofi -monitor 1 -combi-modes drun,run -show combi -show-icons\"";
      fonts = { names = [ "FiraCode" ]; };
      defaultWorkspace = "workspace number 1";
      output = {
         HDMI-A-1 = {
           bg = "./assets/bg.jpg fill";
           resolution = "1920x1080";
           position = "0,0";
         };
         DP-1 = {
           bg = "./assets/bg.jpg fill";
           resolution = "2560x1440";
           position = "1920,0";
         };
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "us,ru";
          xkb_variant = "dvorak,";
          xkb_options = "grp:win_space_toggle";
        };
      };
      keybindings = with config.wayland.windowManager.sway.config; let
        inherit modifier;
        inherit menu;
        calc = "\"rofi -monitor 1 -show calc\"";
      in lib.mkOptionDefault {
        "${modifier}+w" = "exec ${menu}";
        "${modifier}+d" = "layout tabbed";
        "${modifier}+n" = "exec ${calc}";
      };
      colors = {
        focused = {
          background = "${base}";
          border = "${lavender}";
          childBorder = "${lavender}";
          indicator = "${rosewater}";
          text = "${text}";
        };
        focusedInactive = {
          background = "${base}";
          border = "${overlay0}";
          childBorder = "${overlay0}";
          indicator = "${rosewater}";
          text = "${text}";
        };
        unfocused = {
          background = "${base}";
          border = "${overlay0}";
          childBorder = "${overlay0}";
          indicator = "${rosewater}";
          text = "${text}";
        };
        urgent = {
          background = "${base}";
          border = "${peach}";
          childBorder = "${peach}";
          indicator = "${overlay0}";
          text = "${peach}";
        };
        placeholder = {
          background = "${base}";
          border = "${overlay0}";
          childBorder = "${overlay0}";
          indicator = "${overlay0}";
          text = "${text}";
        };
        background = "${base}";
      };
      bars = [{command = "${pkgs.waybar}/bin/waybar";}];
    };
    extraConfig = ''
        workspace 9 output HDMI-A-1
        for_window [title="flameshot" app_id="flameshot"] fullscreen enable global
    '';
   extraSessionCommands = ''
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=sway
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export QT_AUTO_SCREEN_SCALE_FACTOR=0
      export QT_SCALE_FACTOR=1
      export QT_QPA_PLATFORM=wayland
      export GDK_SCALE=1
      export GDK_DPI_SCALE=1
      export MOZ_ENABLE_WAYLAND=1
    '';
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    xwayland = true;
  };
}