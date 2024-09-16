{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  neovimConfig = builtins.fetchGit {
    url = "https://github.com/cjvnjde/dotfiles.nvim.git";
    ref = "v2";
    rev = "97e3e044ecf4a1d0a0df6ace9bcf8f7a2ca35baf";
  };
in
{

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  home.file."${config.xdg.configHome}/nvim" = {
    source = "${neovimConfig}";
    recursive = true;
  };
}
