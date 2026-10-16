{ self, inputs, noctaliaPalette, ... }: {
  flake.nixosModules.noctalia-greeter = { pkgs, ... }: {
    imports = [
      self.nixosModules.sourceSans
      inputs.noctalia-greeter.nixosModules.default
    ];

    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        appearance = {
          scheme = "Synced";
          theme_mode = "dark";
          font_family = "Source Sans 3";
          corner_radius_scale = 1.0;
          scheme_selector_position = "hidden";
          hide_logo = true;

          palette = {
            primary = noctaliaPalette.dark.mPrimary;
            on_primary = noctaliaPalette.dark.mOnPrimary;
            secondary = noctaliaPalette.dark.mSecondary;
            on_secondary = noctaliaPalette.dark.mOnSecondary;
            tertiary = noctaliaPalette.dark.mTertiary;
            on_tertiary = noctaliaPalette.dark.mOnTertiary;
            error = noctaliaPalette.dark.mError;
            on_error = noctaliaPalette.dark.mOnError;
            surface = noctaliaPalette.dark.mSurface;
            on_surface = noctaliaPalette.dark.mOnSurface;
            surface_variant = noctaliaPalette.dark.mSurfaceVariant;
            on_surface_variant = noctaliaPalette.dark.mOnSurfaceVariant;
            outline = noctaliaPalette.dark.mOutline;
            shadow = noctaliaPalette.dark.mShadow;
            hover = noctaliaPalette.dark.mHover;
            on_hover = noctaliaPalette.dark.mOnHover;
          };

          wallpaper = {
            path = ../../../assets/wallpapers/forrest.png;
            fill_mode = "crop";
          };
        };

        cursor = {
          theme = "phinger-cursors-dark";
          size = 24;
          path = pkgs.phinger-cursors;
        };
      };
    };
  };
}
