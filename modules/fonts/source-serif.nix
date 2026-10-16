{
  flake.nixosModules.sourceSerif = { pkgs, ... }: {
    key = "nix-config:font:source-serif";

    fonts = {
      packages = [pkgs.source-serif];
      fontconfig.defaultFonts.serif = ["Source Serif 4"];
    };
  };
}
