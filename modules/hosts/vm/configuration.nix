{ self, inputs, ... }: {
  flake.nixosModules.vmConfiguration = { pkgs, lib, ... }: {
    # Hostname shown in prompts, hostname output, and DHCP requests
    networking.hostName = "vm";

    # State version pinned at install time; controls default behaviors across
    # releases, leave as-is and never bump casually
    system.stateVersion = "26.05";

    # Use systemd-boot as the EFI boot manager instead of GRUB
    boot.loader.systemd-boot.enable = true;

    # Allow NixOS to write EFI boot entries in firmware (needed to register systemd-boot)
    boot.loader.efi.canTouchEfiVariables = true;

    # MOVE OUT OF HERE
    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
