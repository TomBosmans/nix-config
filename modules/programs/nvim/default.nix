{ self, config, ... }: {
  flake.nixosModules.nvim = {
    imports = [config.flake.wrappers.myNvim.install];

    wrappers.myNvim.enable = true;

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  flake.wrappers.myNvim = { pkgs, lib, wlib, ... }: let
    myPackages = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [wlib.wrapperModules.neovim];

    settings.config_directory = ./.;

    runtimePkgs = with pkgs;
      [
        cargo
        gcc
        git
        gnumake
        jq
        myPackages.myOpencode
        ripgrep
        rustc
        tree-sitter
      ]
      ++ lib.optionals stdenv.isLinux [wl-clipboard];
  };
}
