{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  home.file."${config.xdg.configHome}/nvim" = {
    source = ./config;
    recursive = true;
  };

 home.activation.lazy-lock = lib.mkAfter ''
     chmod u+w ${config.xdg.configHome}/nvim/lazy-lock.json
  '';

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };
}
