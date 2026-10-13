# TODO: Use wrappers.eza.wrap once https://github.com/nix-community/nix-wrapper-modules/pull/619
# is merged with support for external theme files and preserving eza's separate man output.
{ inputs, ... }: {
  perSystem = { pkgs, ... }: let
    theme = "${inputs.catppuccin-eza}/themes/macchiato/catppuccin-macchiato-blue.yml";
    config = pkgs.linkFarm "eza-config" [{
      name = "theme.yml";
      path = theme;
    }];
  in {
    packages.myEza = pkgs.eza.overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [pkgs.makeWrapper];
      postFixup = (oldAttrs.postFixup or "") + ''
        wrapProgram "$out/bin/eza" \
          --set EZA_CONFIG_DIR ${pkgs.lib.escapeShellArg config}
      '';
      passthru = (oldAttrs.passthru or {}) // {inherit theme;};
    });
  };
}
