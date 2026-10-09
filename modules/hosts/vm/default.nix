{ self, inputs, ... }: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.vmConfiguration
      self.nixosModules.vmHardware
      self.nixosModules.garbageCollection
      self.nixosModules.niri
    ];
  };
}
