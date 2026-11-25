{ inputs, ... }:

{
  flake.modules.homeManager.kdeconnect-scrcpy =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      cfg = config.programs.kdeconnect-scrcpy;

      pythonEnv = pkgs.python3.withPackages (ps: [
        ps.dbus-python
        ps.pygobject3
      ]);

      kdeconnectScrcpy = pkgs.writeShellApplication {
        name = "kdeconnect-scrcpy";

        runtimeInputs = [
          pkgs.android-tools
          pkgs.scrcpy
          pythonEnv
        ];

        text = ''
          exec ${pythonEnv}/bin/python \
            ${inputs.kdeconnect-scrcpy}/kdeconnect-scrcpy "$@"
        '';
      };
    in
    {
      options.programs.kdeconnect-scrcpy.enable = lib.mkEnableOption "KDE Connect notification integration with scrcpy";

      config = lib.mkIf cfg.enable {
        home.packages = [
          kdeconnectScrcpy
        ];

        xdg.configFile."kdeconnect-scrcpy/config.toml".text = ''
          devices = []
          ignore_apps = ["com.android.systemui"]
          include_silent = false
          adb_serial = ""
          turn_screen_off = true
          scrcpy_args = ["--stay-awake"]
        '';

        systemd.user.services.kdeconnect-scrcpy = {
          Unit = {
            Description = "KDE Connect notifications with scrcpy";
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
          };

          Service = {
            Type = "simple";
            ExecStart = "${kdeconnectScrcpy}/bin/kdeconnect-scrcpy";
            Restart = "on-failure";
            RestartSec = "5s";
          };

          Install.WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
