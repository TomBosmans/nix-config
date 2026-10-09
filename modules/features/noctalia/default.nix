{ self, inputs, ... }: {
  flake.nixosModules.noctalia = {
    imports = [self.nixosModules.sourceSans];
  };

  perSystem = { system, ... }: let
    pkgs = inputs.noctalia.inputs.nixpkgs.legacyPackages.${system};
    wallpapers = ../../../assets/wallpapers;
    configHome = pkgs.symlinkJoin {
      name = "noctalia-config";
      paths = [
        (pkgs.writeTextDir "noctalia/config.toml" (builtins.readFile ./noctalia-config.toml))
        (pkgs.writeTextDir "noctalia/wallpaper.toml" ''
          [wallpaper]
          directory = "${wallpapers}"

          [wallpaper.default]
          path = "${wallpapers}/forrest.png"
        '')
      ];
    };
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
