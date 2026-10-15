{ self, inputs, noctaliaPalette, ... }: {
  flake.nixosModules.noctalia = {
    imports = [self.nixosModules.sourceSans];
  };

  flake.wrappers.myNoctalia = { pkgs, wlib, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
    myPackages = self.packages.${system};
    wallpapers = ../../../assets/wallpapers;
    configHome = pkgs.symlinkJoin {
      name = "noctalia-config";
      paths = [
        (pkgs.writeTextDir "noctalia/config.toml" (builtins.readFile ./noctalia-config.toml))
        (pkgs.writeTextDir "noctalia/palettes/declarative.json" (builtins.readFile noctaliaPalette.file))
        (pkgs.writeTextDir "noctalia/wallpaper.toml" ''
          [wallpaper]
          directory = "${wallpapers}"

          [wallpaper.default]
          path = "${wallpapers}/forrest.png"
        '')
      ];
    };
  in {
    imports = [wlib.wrapperModules.noctalia-shell];
    package = inputs.noctalia.packages.${system}.default.override {
      git = myPackages.myGit;
    };

    env.NOCTALIA_CONFIG_HOME = configHome;

    envDefault.FONTCONFIG_FILE = pkgs.makeFontsConf {
      fontDirectories = [pkgs.source-sans];
    };
  };
}
