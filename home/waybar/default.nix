{ config, ... }:
{
  home.file."${config.xdg.configHome}/waybar/scripts" = {
    source = ./scripts;
    recursive = true;
  };

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "sway-session.target";
    };
    style = ./assets/waybar_style.css;
    settings = {
      main = {
        position = "top";
        output = "DP-1";
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/scratchpad"
          "custom/media"
        ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "custom/music"
          "tray"
          "custom/keyboardlayout"
          "custom/ups"
          "custom/dunst"
          "idle_inhibitor"
          "pulseaudio"
          "clock"
        ];
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "sway/scratchpad" = {
          format = "{icon} {count}";
          "show-empty" = false;
          "format-icons" = [
            ""
            ""
          ];
          "tooltip" = true;
          "tooltip-format" = "{app}: {title}";
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "start-activated" = true;
        };
        "tray" = {
          "spacing" = 10;
        };
        "clock" = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };
        "pulseaudio" = {
          "format" = "{icon} {volume}% {format_source}";
          "format-bluetooth" = " {icon} {volume}% {format_source}";
          "format-bluetooth-muted" = "  {icon} {format_source}";
          "format-muted" = "  {format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pavucontrol";
        };
        "custom/ups" = {
          "exec" = "${config.xdg.configHome}/waybar/scripts/ups_status.sh";
          "interval" = 60;
        };
        "custom/keyboardlayout" = {
          "interval" = 5;
          "exec" = "${config.xdg.configHome}/waybar/scripts/get_layout.sh";
        };
        "custom/music" = {
          interval = 5;
          "exec" = "playerctl metadata --format '{{status}}|{{artist}}|{{title}}'";
        };
        "custom/dunst" = {
          format = "{}";
          interval = 5;
          "exec" = "bash -c 'if dunstctl is-paused | grep -q true; then echo \"\"; else echo \"\"; fi'";
          "on-click" = "${config.xdg.configHome}/waybar/scripts/toggle_dunst.sh";
        };
      };
      second = {
        position = "top";
        output = "HDMI-A-1";
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "sway/scratchpad"
          "custom/media"
        ];
        modules-center = [ "sway/window" ];
        modules-right = [ "clock" ];
        "clock" = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };
      };
    };
  };
}
