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
    rev = "044b83bf3424cf27367e7949cbb98bc4866d03d1";
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
