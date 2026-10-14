{ self, inputs, ... }: {
  flake.nixosModules.kitty = { pkgs, ... }: {
    imports = [self.nixosModules.jetbrainsMono];

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty
    ];
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;

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

      # Theme is managed by Noctalia on linux
      extraConfig = lib.optionalString pkgs.stdenv.isLinux ''
        include ''${HOME}/.config/kitty/themes/noctalia.conf
      '';

      # Set Catppuccin-Macchiato theme on mac
      themeFile = lib.mkIf pkgs.stdenv.isDarwin "Catppuccin-Macchiato";

      # Need to look into this a bit more, ctrl+v conflicts with nvim
      # keybindings = {
      #   "ctrl+v" = "paste_from_clipboard";
      #   "ctrl+c" = "copy_or_interrupt";
      # };
    };
  };
}
