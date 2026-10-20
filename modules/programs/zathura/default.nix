{ inputs, config, ... }: {
  flake.nixosModules.zathura = {
    imports = [config.flake.wrappers.myZathura.install];

    wrappers.myZathura.enable = true;
    xdg.mime.defaultApplications."application/pdf" = "org.pwmt.zathura.desktop";
  };

  flake.wrappers.myZathura = { pkgs, wlib, ... }: {
    imports = [wlib.wrapperModules.zathura];
    plugins = [pkgs.zathuraPkgs.zathura_pdf_mupdf];

    mappings = {
      "=" = "zoom in";
      "<C-=>" = "zoom specific";
    };

    extraSettings = ''
      include ${inputs.catppuccin-zathura}/themes/catppuccin-macchiato
      set recolor false
      set guioptions ""
    '';
  };
}
