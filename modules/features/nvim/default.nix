{ self, inputs, ... }: {
  flake.nixosModules.nvim = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNvim
    ];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  perSystem = { pkgs, ... }: {
    packages.myNvim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;

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
  };
}
