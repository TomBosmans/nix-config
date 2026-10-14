{ config, ... }: {
  flake.nixosModules.git = {
    imports = [config.flake.wrappers.myGit.install];

    wrappers.myGit.enable = true;
  };

  flake.wrappers.myGit = { wlib, ... }: {
    imports = [wlib.wrapperModules.git];

    settings.user = {
      name = "tbosmans";
      email = "tom.94.bosmans@gmail.com";
    };
  };
}
