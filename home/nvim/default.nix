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
    rev = "5f6e688302910cd3dac8e0c7c22847907c506660";
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
