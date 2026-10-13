{
  # Remove FreeDesktop trash entries older than 30 days on a daily schedule.
  flake.nixosModules.trash = { lib, pkgs, ... }: {
    systemd.user.services.trash-cleanup = {
      description = "Purge trash items older than 30 days";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${lib.getExe' pkgs.trash-cli "trash-empty"} 30";
      };
    };

    systemd.user.timers.trash-cleanup = {
      description = "Daily trash cleanup";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "5min";
        OnUnitActiveSec = "1d";
        Unit = "trash-cleanup.service";
      };
    };
  };
}
