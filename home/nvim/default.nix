{
  config,
  pkgs,
  inputs,
  ...
}:
let
  neovimConfig = builtins.fetchGit {
    url = "https://github.com/cjvnjde/dotfiles.nvim.git";
    ref = "v2";
    rev = "349c5ec7ec05c5cdecbcc7ff9f7850cf8c572885";
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
