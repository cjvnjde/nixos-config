{
  config,
  pkgs,
  inputs,
  ...
}:
let
  neovimConfig = builtins.fetchGit {
    url = "https://github.com/cjvnjde/dotfiles.nvim.git";
    ref = "main";
    rev = "de12638a3e9e2f03d3538dbc071715f006bda245";
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
