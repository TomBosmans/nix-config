{ config, noctaliaPalette, ... }: {
  flake.lib.mkMenu = pkgs: menu: (config.flake.wrappers.myWlrWhichKey.apply {
    inherit pkgs;
    settings = {inherit menu;};
  }).wrapper;

  flake.wrappers.myWlrWhichKey = { pkgs, wlib, ... }: let
    palette = noctaliaPalette.dark;
  in {
    imports = [wlib.wrapperModules.wlr-which-key];

    envDefault.FONTCONFIG_FILE = pkgs.makeFontsConf {
      fontDirectories = [pkgs.nerd-fonts.jetbrains-mono];
    };

    settings = {
      font = "JetBrainsMono Nerd Font 11";
      # Append an e6 alpha channel for roughly 90% opacity.
      background = "${palette.mSurface}e6";
      color = palette.mOnSurface;
      border = palette.mPrimary;
      separator = " > ";
      border_width = 2;
      corner_r = 8;
      padding = 14;
      rows_per_column = 8;
      column_padding = 24;
      anchor = "bottom-right";
      inhibit_compositor_keyboard_shortcuts = true;
      auto_kbd_layout = true;
    };
  };
}
