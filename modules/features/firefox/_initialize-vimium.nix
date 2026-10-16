{
  pkgs,
  vimiumSettingsFile,
}:
pkgs.writeShellApplication {
  name = "initialize-vimium";
  runtimeInputs = [
    pkgs.coreutils
    pkgs.gawk
    pkgs.procps
    pkgs.sqlite
  ];
  text = ''
    config_home="''${XDG_CONFIG_HOME:-$HOME/.config}"
    firefox_home="$config_home/mozilla/firefox"
    profiles_ini="$firefox_home/profiles.ini"

    [[ -f "$profiles_ini" ]] || exit 0
    while IFS= read -r pid; do
      [[ "$pid" == "$PPID" ]] || exit 0
    done < <(pgrep -u "$(id -u)" -x firefox || true)

    profile_record="$(${pkgs.gawk}/bin/awk -F= '
      function emit() {
        if (in_profile && is_default == "1" && path != "") {
          print is_relative "\t" path
          found = 1
          exit
        }
      }

      /^\[Profile[0-9]+\]$/ {
        emit()
        in_profile = 1
        is_default = ""
        is_relative = "1"
        path = ""
        next
      }

      /^\[/ {
        emit()
        in_profile = 0
        next
      }

      in_profile && $1 == "Default" { is_default = $2 }
      in_profile && $1 == "IsRelative" { is_relative = $2 }
      in_profile && $1 == "Path" { path = $2 }

      END {
        if (!found) emit()
      }
    ' "$profiles_ini")"

    [[ -n "$profile_record" ]] || exit 0
    is_relative="''${profile_record%%$'\t'*}"
    profile_path="''${profile_record#*$'\t'}"
    if [[ "$is_relative" == "1" ]]; then
      profile_path="$firefox_home/$profile_path"
    fi

    database="$profile_path/storage-sync-v2.sqlite"
    [[ -f "$database" ]] || exit 0

    if ! sqlite3 "$database" <<'SQL'
    .timeout 1000
    BEGIN IMMEDIATE;
    INSERT INTO storage_sync_data (ext_id, data, sync_change_counter)
    VALUES (
      '{d7742d87-e61d-4b78-b8a1-b469842139fa}',
      json(CAST(readfile('${vimiumSettingsFile}') AS TEXT)),
      1
    )
    ON CONFLICT (ext_id) DO UPDATE SET
      data = json_patch(
        COALESCE(storage_sync_data.data, '{}'),
        json(CAST(readfile('${vimiumSettingsFile}') AS TEXT))
      ),
      sync_change_counter = storage_sync_data.sync_change_counter + 1
    WHERE json(COALESCE(storage_sync_data.data, '{}')) IS NOT json(
      json_patch(
        COALESCE(storage_sync_data.data, '{}'),
        json(CAST(readfile('${vimiumSettingsFile}') AS TEXT))
      )
    );
    COMMIT;
    SQL
    then
      echo "warning: could not initialize Vimium settings" >&2
    fi
  '';
}
