{ self, inputs, ... }: {
  flake.nixosModules.git = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myGit
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.myGit = inputs.wrapper-modules.wrappers.git.wrap {
      inherit pkgs;

      settings.user = {
        name = "tbosmans";
        email = "tom.94.bosmans@gmail.com";
      };
    };
  };
}
