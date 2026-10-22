# This profile erases one system disk and creates a GUID Partition Table (GPT)
# with an EFI boot partition, disk swap, and a Btrfs system partition.
# Btrfs subvolumes separate the system, user data, and Nix store so they can be
# managed or snapshotted independently. Zstd saves space with low overhead;
# noatime avoids needless metadata writes on the system and Nix store while
# /home keeps normal access-time behavior for applications that may use it.
# Compressed zram handles memory pressure quickly before falling back to the
# slower disk swap partition.
{ inputs, ... }: {
  flake.nixosModules.btrfsSystemDisk = { config, lib, ... }: {
    imports = [inputs.disko.nixosModules.disko];

    options.my.storage = {
      device = lib.mkOption {
        type = lib.types.str;
        description = "Disk that Disko will erase and partition.";
        example = "/dev/disk/by-id/nvme-example";
      };

      efiSize = lib.mkOption {
        type = lib.types.str;
        default = "1G";
        description = "Size of the EFI system partition.";
      };

      swapSize = lib.mkOption {
        type = lib.types.str;
        default = "8G";
        description = "Size of the disk swap partition.";
      };
    };

    config = {
      zramSwap = {
        enable = lib.mkDefault true;
        memoryPercent = lib.mkDefault 50;
        algorithm = lib.mkDefault "zstd";
        priority = lib.mkDefault 5;
        swapDevices = lib.mkDefault 1;
      };

      disko.devices.disk.main = {
        type = "disk";
        device = config.my.storage.device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              size = config.my.storage.efiSize;
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            swap = {
              priority = 2;
              size = config.my.storage.swapSize;
              content.type = "swap";
            };

            root = {
              priority = 3;
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
