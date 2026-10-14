{ self, inputs, ... }: {
  flake.nixosModules.noctalia = {
    imports = [self.nixosModules.sourceSans];
  };

  flake.wrappers.myNoctalia = { pkgs, wlib, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
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
    imports = [wlib.wrapperModules.noctalia-shell];
    package = inputs.noctalia.packages.${system}.default;

    env.NOCTALIA_CONFIG_HOME = configHome;

    envDefault.FONTCONFIG_FILE = pkgs.makeFontsConf {
      fontDirectories = [pkgs.source-sans];
    };
  };
}
