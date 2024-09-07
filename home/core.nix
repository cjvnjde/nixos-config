{ config, pkgs, lib, users, username, ... }: {

  imports = [
    ./sway
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

# utils
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      eza # A modern replacement for ‘ls’
      fzf # A command-line fuzzy finder

      firefox-devedition
      jetbrains.idea-ultimate
      flameshot

      thefuck
      bat
      atuin

# development
      nodejs_22
      bun
      pnpm

# messaging
      slack
      telegram-desktop

      (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

#
      #nerdfonts.override { fonts = [ "FiraCode" ]; }
#
  programs.git = {
    enable = true;
    userName = "Vitalij Nykyforenko";
    userEmail = "vitalij.nykyforenko@gmail.com";
  };

  programs.rofi = {
    enable = true;
    terminal = "kitty";
    plugins = with pkgs; [ rofi-calc ];
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
    };
  };

  programs.neovim = {
    enable = true;
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
      cat = "bat -p --theme='Catppuccin Mocha'";
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
