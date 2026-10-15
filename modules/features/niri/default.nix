{ self, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.noctalia
      self.nixosModules.kitty
      self.nixosModules.git
      self.nixosModules.opencode
      self.nixosModules.zsh
      self.nixosModules.nvim
      self.nixosModules.yazi
    ];

    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };

    environment.systemPackages = [pkgs.phinger-cursors];
  };

  flake.wrappers.myNiri = { pkgs, lib, wlib, ... }: let
    myPackages = self.packages.${pkgs.stdenv.hostPlatform.system};
    noctalia = lib.getExe myPackages.myNoctalia;
    kitty = lib.getExe myPackages.myKitty;
  in {
    imports = [wlib.wrapperModules.niri];

    settings = {
      spawn-at-startup = [noctalia];

      input.keyboard.xkb.layout = "us";
      input.keyboard.xkb.options = "ctrl:nocaps";
      input.keyboard.repeat-delay = 200;
      input.keyboard.repeat-rate = 25;
      input.touchpad.natural-scroll = {};

      cursor.xcursor-theme = "phinger-cursors-dark";
      cursor.xcursor-size = 12;

      layout.gaps = 5;
      layout.focus-ring.width = 2;

      layer-rules = [{
        matches = [{ namespace = "^noctalia-backdrop"; }];
        place-within-backdrop = true;
      }];

      window-rules = [
        {
          geometry-corner-radius = 0;
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
        {
          matches = [{ is-active = false; }];
          opacity = 0.90;
        }
        {
          matches = [{ is-active = true; }];
          opacity = 0.95;
        }
      ];

      binds = {
        "Mod+Q".close-window = {};
        "Mod+O".toggle-overview = {};
        "Mod+Return".spawn-sh = kitty;
        "Mod+Space".spawn-sh = "${noctalia} msg panel-toggle launcher";
        "Mod+S".spawn-sh = "${noctalia} msg panel-toggle control-center";
        "Alt+Tab".spawn-sh = "${noctalia} msg window-switcher hold";

        "Mod+Slash".spawn-sh = "${noctalia} msg settings-open";

        # Navigation
        "Mod+H".focus-column-left = {};
        "Mod+J".focus-window-or-workspace-down = {};
        "Mod+K".focus-window-or-workspace-up = {};
        "Mod+L".focus-column-right = {};

        # Move
        "Mod+Ctrl+H".move-column-left = {};
        "Mod+Ctrl+L".move-column-right = {};
        "Mod+Ctrl+J".move-window-down-or-to-workspace-down = {};
        "Mod+Ctrl+K".move-window-up-or-to-workspace-up = {};

        # Cycle through preset column widths.
        "Mod+R".switch-preset-column-width = {};
        "Mod+Shift+R".switch-preset-column-width-back = {};

        # Fine-grained width adjustment.
        "Mod+Minus".set-column-width = "-10%";
        "Mod+Equal".set-column-width = "+10%";

        # Height adjustment for vertically stacked windows.
        "Mod+Shift+Minus".set-window-height = "-10%";
        "Mod+Shift+Equal".set-window-height = "+10%";
        "Mod+Ctrl+R".reset-window-height = {};

        # Maximize and fullscreen.
        "Mod+F".maximize-column = {};
        "Mod+Shift+F".fullscreen-window = {};
        "Mod+M".maximize-window-to-edges = {};

        # Position columns.
        "Mod+C".center-column = {};
        "Mod+Ctrl+C".center-visible-columns = {};

        # Managing columns
        "Mod+BracketLeft".consume-or-expel-window-left = {};
        "Mod+BracketRight".consume-or-expel-window-right = {};
        "Mod+Comma".consume-window-into-column = {};
        "Mod+Period".expel-window-from-column = {};
        "Mod+W".toggle-column-tabbed-display = {};

        # Floating windows
        "Mod+Shift+Space".toggle-window-floating = {};

        # Notifications
        "Mod+N".spawn-sh = "${noctalia} msg panel-toggle control-center notifications";
        "Mod+Shift+N".spawn-sh = "${noctalia} msg notification-dnd-toggle";
        "Mod+Ctrl+N".spawn-sh = "${noctalia} msg notification-clear-active";

        # Clipboard
        "Mod+V".spawn-sh = "${noctalia} msg panel-toggle clipboard";
        "Mod+Ctrl+V".spawn-sh = "${noctalia} msg clipboard-clear";

        # Audio
        "XF86AudioRaiseVolume".spawn-sh = "${noctalia} msg volume-up";
        "XF86AudioLowerVolume".spawn-sh = "${noctalia} msg volume-down";
        "XF86AudioMute".spawn-sh = "${noctalia} msg volume-mute";
        "XF86AudioPlay".spawn-sh = "${noctalia} msg media toggle";
        "XF86AudioPause".spawn-sh = "${noctalia} msg media pause";
        "XF86AudioNext".spawn-sh = "${noctalia} msg media next";
        "XF86AudioPrev".spawn-sh = "${noctalia} msg media previous";
        "XF86AudioStop".spawn-sh = "${noctalia} msg media stop";

        # Brightness
        "XF86MonBrightnessUp".spawn-sh = "${noctalia} msg brightness-up";
        "XF86MonBrightnessDown".spawn-sh = "${noctalia} msg brightness-down";
      };
    };

    extraSettings = [{
      include = [
        { optional = true; }
        "~/.config/niri/noctalia.kdl"
      ];
    }];
  };
}
