{ self, inputs, ... }: {
  flake.nixosModules.vmHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports = [(modulesPath + "/profiles/qemu-guest.nix")];

    boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/4c9f2e89-9fd2-4f07-936a-ca7a088c3a8c";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/402B-5820";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/f2b40cd7-a0d4-4011-8c81-825b733a6d9f"; }
      ];

    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}
