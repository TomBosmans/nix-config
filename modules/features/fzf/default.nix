{ inputs, ... }: {
  perSystem = { pkgs, lib, ... }: let
    theme = "${inputs.catppuccin-fzf}/themes/catppuccin-fzf-macchiato.sh";
  in {
    packages.myFzf = pkgs.fzf.overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [pkgs.makeWrapper];
      postFixup = (oldAttrs.postFixup or "") + ''
        wrapProgram "$out/bin/fzf" --run ${lib.escapeShellArg ''
          inherited_opts="''${FZF_DEFAULT_OPTS-}"
          . ${lib.escapeShellArg theme}
          export FZF_DEFAULT_OPTS="''${inherited_opts:+$inherited_opts }$FZF_DEFAULT_OPTS"
        ''}
      '';
      passthru = (oldAttrs.passthru or {}) // {inherit theme;};
    });
  };
}
