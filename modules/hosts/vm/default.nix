{ self, inputs, ... }: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.user-tbosmans
      self.nixosModules.vmConfiguration
      self.nixosModules.vmHardware
      self.nixosModules.btrfsSystemDisk
      self.nixosModules.experimentalFeatures
      self.nixosModules.garbageCollection
      self.nixosModules.niri
      self.nixosModules.noctalia-greeter
    ];
  };
}
