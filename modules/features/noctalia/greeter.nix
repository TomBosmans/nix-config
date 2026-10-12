{ inputs, ... }: {
  flake.nixosModules.noctalia-greeter = { pkgs, ... }: {
    imports = [inputs.noctalia-greeter.nixosModules.default];

    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        cursor = {
          theme = "phinger-cursors-dark";
          size = 24;
          path = pkgs.phinger-cursors;
        };
      };
    };
  };
}
