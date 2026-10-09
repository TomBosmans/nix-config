{ self, inputs, ... }: {
  flake.nixosModules.noctalia = {
    imports = [self.nixosModules.sourceSans];
  };

  perSystem = { pkgs, system, ... }: let
    configHome = pkgs.writeTextDir "noctalia/config.toml" (builtins.readFile ./noctalia-config.toml);
  in {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      package = inputs.noctalia.packages.${system}.default;

      env.NOCTALIA_CONFIG_HOME = configHome;

      envDefault.FONTCONFIG_FILE = pkgs.makeFontsConf {
        fontDirectories = [pkgs.source-sans];
      };
    };
  };
}
