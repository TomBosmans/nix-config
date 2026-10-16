{
  flake.nixosModules.sourceSans = { pkgs, ... }: {
    key = "nix-config:font:source-sans";

    fonts = {
      packages = [pkgs.source-sans];
      fontconfig.defaultFonts.sansSerif = ["Source Sans 3"];
    };
  };
}
