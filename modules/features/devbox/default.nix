{ inputs, ... }: {
  flake.nixosModules.devbox = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.devbox
    ];
  };
}
