{ config, ... }: {
  flake.nixosModules.nvim = {
    imports = [config.flake.wrappers.myNvim.install];

    wrappers.myNvim.enable = true;

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  flake.wrappers.myNvim = { pkgs, wlib, ... }: {
    imports = [wlib.wrapperModules.neovim];

    settings.config_directory = ./.;

    runtimePkgs = with pkgs; [
      cargo
      gcc
      gnumake
      ripgrep
      rustc
      tree-sitter
    ];
  };
}
