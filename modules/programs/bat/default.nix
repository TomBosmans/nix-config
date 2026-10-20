# TODO: Use wrappers.bat.wrap once https://github.com/nix-community/nix-wrapper-modules/pull/494
# is merged with support for building custom theme caches.
{ self, inputs, ... }: {
  flake.nixosModules.bat = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myBat
    ];
  };

  perSystem = { pkgs, ... }: let
    theme = "${inputs.catppuccin-bat}/themes/Catppuccin Macchiato.tmTheme";
    config = pkgs.runCommand "bat-config" {
      nativeBuildInputs = [pkgs.bat];
    } ''
      mkdir -p "$out/config/themes" "$out/cache"
      ln -s ${pkgs.lib.escapeShellArg theme} "$out/config/themes/Catppuccin Macchiato.tmTheme"
      printf '%s\n' '--theme="Catppuccin Macchiato"' > "$out/config/config"

      BAT_CONFIG_DIR="$out/config" BAT_CACHE_PATH="$out/cache" \
        bat cache --build
    '';
  in {
    packages.myBat = pkgs.symlinkJoin {
      name = pkgs.bat.name;
      paths = [pkgs.bat];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram "$out/bin/bat" \
          --set BAT_CONFIG_DIR ${pkgs.lib.escapeShellArg "${config}/config"} \
          --set BAT_CACHE_PATH ${pkgs.lib.escapeShellArg "${config}/cache"}
      '';
      passthru.theme = theme;
      inherit (pkgs.bat) meta;
    };
  };
}
