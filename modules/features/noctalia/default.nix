{ self, inputs, ... }: {
  flake.nixosModules.noctalia = {
    imports = [self.nixosModules.sourceSans];
  };

  perSystem = { pkgs, system, ... }: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      package = inputs.noctalia.packages.${system}.default;
      settings = builtins.fromTOML (builtins.readFile ./noctalia-config.toml);

      envDefault.FONTCONFIG_FILE = pkgs.makeFontsConf {
        fontDirectories = [pkgs.source-sans];
      };
    };
  };
}
