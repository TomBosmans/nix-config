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
      self.nixosModules.firefox
    ];

    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };

    environment.systemPackages = [pkgs.phinger-cursors];
  };

  flake.wrappers.myNiri = { pkgs, lib, wlib, ... }: let
    myPackages = self.packages.${pkgs.stdenv.hostPlatform.system};
    niri = lib.getExe pkgs.niri;
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
        "Mod+D".spawn-sh = lib.getExe (self.lib.mkMenu pkgs [
          {
            key = "f";
            desc = "Firefox";
            cmd = lib.getExe myPackages.myFirefox;
          }
          {
            key = "k";
            desc = "Kitty";
            cmd = kitty;
          }
          {
            key = "o";
            desc = "OpenCode";
            cmd = "${kitty} --detach ${lib.getExe myPackages.myOpencode}";
          }
          {
            key = "y";
            desc = "Yazi";
            cmd = "${kitty} --detach ${lib.getExe myPackages.myYazi}";
          }
        ]);
        "Mod+Space".spawn-sh = "${noctalia} msg panel-toggle launcher";
        "Mod+S".spawn-sh = lib.getExe (self.lib.mkMenu pkgs [
          {
            key = "c";
            desc = "Control Center";
            cmd = "${noctalia} msg panel-toggle control-center";
          }
          {
            key = "m";
            desc = "Media";
            cmd = "${noctalia} msg panel-toggle control-center media";
          }
          {
            key = "a";
            desc = "Audio";
            cmd = "${noctalia} msg panel-toggle control-center audio";
          }
          {
            key = "d";
            desc = "Monitor";
            cmd = "${noctalia} msg panel-toggle control-center monitor";
          }
          {
            key = "y";
            desc = "System";
            cmd = "${noctalia} msg panel-toggle control-center system";
          }
          {
            key = "n";
            desc = "Network";
            cmd = "${noctalia} msg panel-toggle control-center network";
          }
          {
            key = "b";
            desc = "Bluetooth";
            cmd = "${noctalia} msg panel-toggle control-center bluetooth";
          }
          {
            key = "e";
            desc = "Weather";
            cmd = "${noctalia} msg panel-toggle control-center weather";
          }
          {
            key = "k";
            desc = "Calendar";
            cmd = "${noctalia} msg panel-toggle control-center calendar";
          }
          {
            key = "o";
            desc = "Notifications";
            cmd = "${noctalia} msg panel-toggle control-center notifications";
          }
          {
            key = "t";
            desc = "Screen Time";
            cmd = "${noctalia} msg panel-toggle control-center screen-time";
          }
          {
            key = "p";
            desc = "Power";
            cmd = "${noctalia} msg panel-toggle control-center power";
          }
          {
            key = "h";
            desc = "Clipboard History";
            cmd = "${noctalia} msg panel-toggle clipboard";
          }
          {
            key = "w";
            desc = "Wallpaper";
            cmd = "${noctalia} msg panel-toggle wallpaper";
          }
          {
            key = "x";
            desc = "Session";
            cmd = "${noctalia} msg panel-toggle session";
          }
          {
            key = "s";
            desc = "Settings";
            cmd = "${noctalia} msg settings-toggle";
          }
        ]);

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

        # Resize and layout
        "Mod+R".spawn-sh = lib.getExe (self.lib.mkMenu pkgs [
          {
            key = "h";
            desc = "Narrower";
            cmd = "${niri} msg action set-column-width -- -10%";
            keep_open = true;
          }
          {
            key = "l";
            desc = "Wider";
            cmd = "${niri} msg action set-column-width -- +10%";
            keep_open = true;
          }
          {
            key = "j";
            desc = "Taller";
            cmd = "${niri} msg action set-window-height -- +10%";
            keep_open = true;
          }
          {
            key = "k";
            desc = "Shorter";
            cmd = "${niri} msg action set-window-height -- -10%";
            keep_open = true;
          }
          {
            key = "p";
            desc = "Next preset width";
            cmd = "${niri} msg action switch-preset-column-width";
            keep_open = true;
          }
          {
            key = "P";
            desc = "Previous preset width";
            cmd = "${niri} msg action switch-preset-column-width-back";
            keep_open = true;
          }
          {
            key = "r";
            desc = "Reset height";
            cmd = "${niri} msg action reset-window-height";
            keep_open = true;
          }
          {
            key = "f";
            desc = "Fullscreen";
            cmd = "${niri} msg action fullscreen-window";
          }
          {
            key = "m";
            desc = "Maximize column";
            cmd = "${niri} msg action maximize-column";
          }
          {
            key = "e";
            desc = "Maximize to edges";
            cmd = "${niri} msg action maximize-window-to-edges";
          }
        ]);

        # Position columns.
        "Mod+C".center-column = {};
        "Mod+Ctrl+C".center-visible-columns = {};

        # Managing columns
        "Mod+Shift+H".consume-or-expel-window-left = {};
        "Mod+Shift+J".consume-window-into-column = {};
        "Mod+Shift+K".expel-window-from-column = {};
        "Mod+Shift+L".consume-or-expel-window-right = {};
        "Mod+W".toggle-column-tabbed-display = {};

        # Floating windows
        "Mod+F".spawn-sh = lib.getExe (self.lib.mkMenu pkgs [
          {
            key = "t";
            desc = "Toggle floating";
            cmd = "${niri} msg action toggle-window-floating";
          }
          {
            key = "s";
            desc = "Switch floating or tiling focus";
            cmd = "${niri} msg action switch-focus-between-floating-and-tiling";
          }
        ]);

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
