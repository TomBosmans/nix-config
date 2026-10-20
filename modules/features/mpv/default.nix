{ inputs, config, ... }: {
  flake.nixosModules.mpv = {
    imports = [config.flake.wrappers.myMpv.install];

    wrappers.myMpv.enable = true;

    xdg.mime.defaultApplications = {
      "video/mkv" = "mpv.desktop";
      "video/mp4" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";
      "video/ogg" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
    };
  };

  flake.wrappers.myMpv = { pkgs, wlib, ... }: {
    imports = [wlib.wrapperModules.mpv];

    envDefault.FONTCONFIG_FILE = pkgs.makeFontsConf {
      fontDirectories = [pkgs.source-sans];
    };

    "mpv.conf".content = ''
      ${builtins.readFile "${inputs.catppuccin-mpv}/themes/macchiato/blue.conf"}
      osd-font='Source Sans 3'
      sub-font='Source Sans 3'
    '';

    "mpv.input".content = ''
      h seek -5
      l seek 5
      j seek -60
      k seek 60
      H add chapter -1
      L add chapter 1
      J playlist-prev
      K playlist-next
      a cycle audio
      c cycle sub
    '';
  };
}
