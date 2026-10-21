# Run xremap as an isolated system user with exclusive input-device access.
# Each normal user gets a private socket used by a compositor-specific bridge
# (such as niri-xremap) to report the focused application to the shared daemon.
# Normal users need explicit UIDs because those UIDs form the socket paths.
{
  flake.nixosModules.xremap = { config, pkgs, lib, ... }: let
    normalUsers = lib.filterAttrs (_: user: user.isNormalUser) config.users.users;
    usersWithUid = lib.filterAttrs (_: user: user.uid != null) normalUsers;
    socketGroup = user: "xremap-${user}";
    runtimeDirectory = user: "/run/xremap/${toString usersWithUid.${user}.uid}";
    xremapConfig = pkgs.writeText "xremap-config.json" (builtins.toJSON (import ./_keymap.nix));
  in {
    assertions = lib.mapAttrsToList (user: userConfig: {
      assertion = userConfig.uid != null;
      message = "xremap requires normal user ${user} to have an explicit UID.";
    }) normalUsers;

    hardware.uinput.enable = true;

    users.groups = {
      xremap = {};
    } // lib.mapAttrs' (user: _: lib.nameValuePair (socketGroup user) {
      members = [user];
    }) normalUsers;

    users.users.xremap = {
      isSystemUser = true;
      group = "xremap";
      extraGroups = ["input" "uinput"] ++ map socketGroup (lib.attrNames normalUsers);
    };

    systemd.tmpfiles.rules = [
      "d /run/xremap 0755 xremap xremap -"
    ] ++ lib.mapAttrsToList (user: _: "d ${runtimeDirectory user} 2770 xremap ${socketGroup user} -") usersWithUid;

    systemd.services.xremap = {
      description = "Isolated keyboard remapping service";
      wantedBy = ["multi-user.target"];
      after = ["systemd-udevd.service"];

      serviceConfig = {
        User = "xremap";
        Group = "xremap";
        SupplementaryGroups = ["input" "uinput"] ++ map socketGroup (lib.attrNames normalUsers);
        ExecStart = "${lib.getExe pkgs.xremap.socket} --watch=device --allow-launch false ${xremapConfig}";
        Restart = "on-failure";
        RestartSec = 1;

        CapabilityBoundingSet = "";
        DevicePolicy = "closed";
        DeviceAllow = ["char-input r" "/dev/uinput rw"];
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        PrivateNetwork = true;
        PrivateTmp = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = "strict";
        RestrictAddressFamilies = ["AF_UNIX"];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
        UMask = "0077";
      };
    };
  };
}
