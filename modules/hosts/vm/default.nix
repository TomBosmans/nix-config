{ self, inputs, ... }: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.vmConfiguration
      self.nixosModules.vmHardware
      self.nixosModules.garbageCollection
      self.nixosModules.niri
      self.nixosModules.noctalia-greeter
      {
        users.users.tbosmans = {
          isNormalUser = true;
          hashedPassword = "$y$j9T$CFXZEUSxYXBhdGxt0OK2U0$pUqQ6svHOSUtpB5R8quh3GiXYjOFRQOItIxV8B0Dsn1";
          extraGroups = [ "wheel" ];
        };
      }
    ];
  };
}
