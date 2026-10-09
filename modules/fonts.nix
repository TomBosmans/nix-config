{
  flake.nixosModules = {
    jetbrainsMono = { pkgs, ... }: {
      fonts = {
        packages = [pkgs.nerd-fonts.jetbrains-mono];
        fontconfig.defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
      };
    };

    sourceSans = { pkgs, ... }: {
      fonts = {
        packages = [pkgs.source-sans];
        fontconfig.defaultFonts.sansSerif = ["Source Sans 3"];
      };
    };

    sourceSerif = { pkgs, ... }: {
      fonts = {
        packages = [pkgs.source-serif];
        fontconfig.defaultFonts.serif = ["Source Serif 4"];
      };
    };
  };
}
