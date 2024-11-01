{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.file."${config.xdg.configHome}/sway/assets/bg.jpg".source = ./assets/bg.jpg;
  home.file."${config.xdg.configHome}/sway/kill_waybar_no_tty.sh".source = ./kill_waybar_no_tty.sh;

  wayland.windowManager.sway =
    let
      # Catpuccin mocha
      rosewater = "#f5e0dc";
      peach = "#fab387";
      lavender = "#b4befe";
      text = "#cdd6f4";
      overlay0 = "#6c7086";
      base = "#1e1e2e";
    in
    {
      enable = true;
      checkConfig = false;
      config = rec {
        startup = [
          {
            command = "sh ${config.xdg.configHome}/sway/kill_waybar_no_tty.sh";
            always = true;
          }
        ];
        terminal = "kitty";
        modifier = "Mod4"; # win key
        left = "h";
        down = "j";
        up = "k";
        right = "l";
        menu = "\"rofi -monitor 1 -combi-modes drun,run -show combi -show-icons\"";
        fonts = {
          names = [ "FiraCode" ];
        };
        defaultWorkspace = "workspace number 1";
        input = {
          "type:keyboard" = {
            xkb_layout = "us,ru";
            xkb_variant = "dvorak,";
            xkb_options = "grp:win_space_toggle";
          };
        };
        keybindings =
          let
            inherit modifier;
            inherit menu;
            calc = "\"rofi -monitor 1 -show calc\"";
          in
          lib.mkOptionDefault {
            "${modifier}+w" = "exec ${menu}";
            "${modifier}+d" = "layout tabbed";
            "${modifier}+n" = "exec ${calc}";
            "${modifier}+Shift+f" = "floating toggle";
            "${modifier}+t" = "focus mode_toggle";
            "Print" = "exec $screenshot";
            "Shift+Print" = "exec $screenshot_all";
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
        bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];
      };
      extraConfig = ''
        workspace 9 output HDMI-A-1
        set $screenshots_pat $HOME/Pictures
        set $screenshot 'grim -g "$(slurp)" - | wl-copy'
        # set $screenshot 'XDG_CURRENT_DESKTOP=Sway QT_QPA_PLATFORM=wayland flameshot gui --clipboard --path $screenshots_path'
        # for_window [title="flameshot" app_id="flameshot"] fullscreen enable global
        set $screenshot_all 'grim - | wl-copy'
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
        export BROWSER=firefox-devedition
      '';
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      xwayland = true;
    };
}
