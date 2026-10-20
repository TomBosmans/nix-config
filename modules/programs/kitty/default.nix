{ self, inputs, config, ... }: {
  flake.nixosModules.kitty = {
    imports = [
      self.nixosModules.jetbrainsMono
      config.flake.wrappers.myKitty.install
    ];

    wrappers.myKitty.enable = true;
  };

  flake.wrappers.myKitty = { pkgs, lib, wlib, ... }: {
    imports = [wlib.wrapperModules.kitty];

    envDefault.FONTCONFIG_FILE = pkgs.makeFontsConf {
      fontDirectories = [pkgs.nerd-fonts.jetbrains-mono];
    };

    # Kitty cannot start with UTM's VirGL renderer. Force software rendering
    # only for Kitty so Niri and the rest of the session remain GPU accelerated.
    runShell = lib.optionals pkgs.stdenv.isLinux [
      ''
        if [[ "''${KITTY_FORCE_SOFTWARE_RENDERING:-0}" == "1" ]]; then
          export LIBGL_ALWAYS_SOFTWARE=1
        fi
      ''
    ];

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };

    settings = {
      term = "xterm-256color";
      enable_audio_bell = false;
      hide_window_decorations = "titlebar-only";
      shell_integration = "no-cursor";
      cursor_shape = "block";
      cursor_blink_interval = 0;
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = "cursor";
      scrollback_lines = 10000;
      copy_on_select = "clipboard";
    };

    extraConfig = ''
      include ${inputs.catppuccin-kitty}/themes/macchiato.conf
    '';

    # Need to look into this a bit more, ctrl+v conflicts with nvim
    # keybindings = {
    #   "ctrl+v" = "paste_from_clipboard";
    #   "ctrl+c" = "copy_or_interrupt";
    # };
  };
}
