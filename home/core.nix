{ inputs, config, pkgs, lib, users, username, ... }: {

  imports = [
    ./sway
    ./waybar
    ./rofi
    ./bat
    ./nvim
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

# link the configuration file in current directory to the specified location in home directory
# home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

# link all files in `./scripts` to `~/.config/i3/scripts`
# home.file.".config/i3/scripts" = {
#   source = ./scripts;
#   recursive = true;   # link recursively
#   executable = true;  # make all files executable
# };

  fonts.fontconfig.enable = true;
# Packages that should be installed to the user profile.
  home.packages = with pkgs; [
# archives
      zip
      unzip
      grim
      slurp

      flameshot

# utils
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      eza # A modern replacement for ‘ls’

      firefox-devedition
      jetbrains-toolbox

      tldr
      thefuck
      atuin
      mpv

# development
      nodejs_22
      bun
      pnpm

      wl-clipboard
# messaging
      slack
      telegram-desktop

      playerctl

      (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  programs.fzf = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Vitalij Nykyforenko";
    userEmail = "vitalij.nykyforenko@gmail.com";
    delta = {
      enable = true;
      options = {
        "catppuccin-mocha" = {
          blame-palette = "#1e1e2e #181825 #11111b #313244 #45475a";
          commit-decoration-style = "box ul";
          dark = true;
          file-decoration-style = "#cdd6f4";
          file-style = "#cdd6f4";
          hunk-header-decoration-style = "box ul";
          hunk-header-file-style = "bold";
          hunk-header-line-number-style = "bold #a6adc8";
          hunk-header-style = "file line-number syntax";
          line-numbers = true;
          line-numbers-left-style = "#6c7086";
          line-numbers-minus-style = "bold #f38ba8";
          line-numbers-plus-style = "bold #a6e3a1";
          line-numbers-right-style = "#6c7086";
          line-numbers-zero-style = "#6c7086";
          minus-emph-style = "bold syntax #53394c";
          minus-style = "syntax #34293a";
          plus-emph-style = "bold syntax #404f4a";
          plus-style = "syntax #2c3239";
          map-styles = ''
            bold purple => syntax "#494060",
            bold blue => syntax "#384361",
            bold cyan => syntax "#384d5d",
            bold yellow => syntax "#544f4e"
            '';
          # Should match the name of the bat theme
          syntax-theme = "mocha";

        };


          navigate = true;
          line-number = true;
          side-by-side = true;
          features = "catppuccin-mocha";
      };
    };
  };

  programs.kitty = {
    enable = true;
# kitty has catppuccin theme built-in,
# all the built-in themes are packaged into an extra package named `kitty-themes`
# and it's installed by home-manager if `theme` is specified.
    theme = "Catppuccin-Mocha";
    font = {
      name = "FiraCode";
    };

# consistent with wezterm
    keybindings = {
    };

    settings = {
      background_opacity = "0.93";
      macos_option_as_alt = true; # Option key acts as Alt on macOS
      enable_audio_bell = false;
      confirm_os_window_close = 0;
    };
  };

  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      ls = "eza --tree --level=1 --icons=always";
      cd = "z";
      ci = "zi";
      cat = "bat -p";
    };

    plugins = [
    {
      name = "atuin";
      src = pkgs.fetchFromGitHub {
        owner = "atuinsh";
        repo = "atuin";
        rev = "main";
        sha256 = "09j99q2ialcrhqs03661bd2gnqsjrfksj1c0bqii51mjjiml8pbq";
      };
    }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "thefuck"
        "fzf"
      ];
      theme = "bira";
    };
  };


  services.dunst = {
    enable = true;
    settings = {
      global = {
          monitor = 1;
          follow = "none";
          width = 400;
          height = 300;
          origin = "top-right";
          offset = "10x36";
          scale = 0;
          notification_limit = 20;
          progress_bar = true;
          progress_bar_height = 10;
          progress_bar_frame_width = 1;
          progress_bar_min_width = 150;
          progress_bar_max_width = 300;
          progress_bar_corner_radius = 0;
          icon_corner_radius = 0;
          indicate_hidden = "yes";
          transparency = 0;
          separator_height = 2;
          padding = 8;
          horizontal_padding = 8;
          text_icon_padding = 0;
          frame_width = 3;
          frame_color = "#89B4FA";
          gap_size = 0;
          separator_color = "frame";
          sort = "yes";
          font = "FiraCode";
          line_height = 0;
          markup = "full";
          format = "<b>%s</b>\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = 60;
          ellipsize = "middle";
          ignore_newline = "no";
          stack_duplicates = true;
          hide_duplicate_count = false;
          show_indicators = "yes";
          enable_recursive_icon_lookup = true;
          icon_theme = "Adwaita";
          icon_position = "left";
          min_icon_size = 32;
          max_icon_size = 128;
          sticky_history = "yes";
          history_length = 20;
          #dmenu = "\"rofi -monitor 1 -combi-modes drun,run -show combi -show-icons\"";
          browser = "${pkgs.firefox-devedition}/bin/firefox-devedition";
          always_run_script = true;
          title = "Dunst";
          class = "Dunst";
          corner_radius = 4;
          ignore_dbusclose = false;
          force_xwayland = false;
          force_xinerama = false;
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
      };
      experimental = {
          per_monitor_dpi = false;
        };

      urgency_low = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          timeout = 10;
      };

      urgency_normal = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          timeout = 10;
        };

      urgency_critical = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          frame_color = "#FAB387";
          timeout = 0;
        };
    };
  };

# This value determines the home Manager release that your
# configuration is compatible with. This helps avoid breakage
# when a new home Manager release introduces backwards
# incompatible changes.
#
# You can update home Manager without changing this value. See
# the home Manager release notes for a list of state version
# changes in each release.
  home.stateVersion = "24.05";

# Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
