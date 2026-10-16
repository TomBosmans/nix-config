{
  flake.nixosModules.jetbrainsMono = { pkgs, ... }: {
    key = "nix-config:font:jetbrains-mono";

    fonts = {
      packages = [pkgs.nerd-fonts.jetbrains-mono];
      fontconfig.defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
    };
  };
}
