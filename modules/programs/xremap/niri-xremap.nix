{ self, ... }: {
  flake.nixosModules.niri-xremap = { pkgs, lib, ... }: {
    imports = [self.nixosModules.xremap];

    systemd.user.services.xremap-bridge = {
      description = "Niri application context bridge for xremap";
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      after = ["graphical-session.target"];
      startLimitIntervalSec = 0;
      unitConfig.ConditionPathExists = "/run/xremap/%U";

      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.xremap.niri} --bridge --no-window-logging";
        Restart = "always";
        RestartSec = 1;
        LockPersonality = true;
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ReadWritePaths = ["/run/xremap/%U"];
        RestrictAddressFamilies = ["AF_UNIX"];
        RestrictRealtime = true;
        SystemCallArchitectures = "native";
        UMask = "0077";
      };
    };
  };
}
