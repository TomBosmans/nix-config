{
  flake.nixosModules.vmHardware = { lib,  modulesPath, ... }: {
    imports = [(modulesPath + "/profiles/qemu-guest.nix")];

    boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    environment.sessionVariables.KITTY_FORCE_SOFTWARE_RENDERING = "1";
    environment.etc."mpv/mpv.conf".text = "vo=wlshm\n";

    my.storage.device = "/dev/vda";

    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}
