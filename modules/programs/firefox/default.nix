{ self, ... }: let
  vimiumCss = builtins.readFile ./catppuccin-vimium-macchiato.css;
  policies = import ./_policies.nix;
in {
  flake.nixosModules.firefox = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myFirefox
    ];
  };

  perSystem = { pkgs, ... }: let
    firefox = pkgs.firefox.override {
      extraPolicies = policies;
    };

    vimiumSettingsFile = pkgs.writeText "vimium-settings.json" (builtins.toJSON {
      settingsVersion = "2.4.2";
      userDefinedLinkHintCss = vimiumCss;
    });

    initializeVimium = pkgs.callPackage ./_initialize-vimium.nix {
      inherit vimiumSettingsFile;
    };
  in {
    packages.myFirefox = pkgs.symlinkJoin {
      name = firefox.name;
      paths = [ firefox ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/firefox" \
          --run ${initializeVimium}/bin/initialize-vimium
      '';
      meta.mainProgram = "firefox";
    };
  };
}
