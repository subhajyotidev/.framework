{ inputs, ... }:

{
  flake.modules.homeManager.dux-calendar =
    { pkgs, ... }:

    let
      duxQtBase = (inputs.dfiles.lib.buildDfilesPkgs pkgs).dux-qt-base;

      dcal = pkgs.writeShellScriptBin "dcal" ''
        export LD_LIBRARY_PATH="${duxQtBase}/lib"
        export QML_IMPORT_PATH="${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml"

        exec /home/delllaptop/.local/bin/dcal "$@"
      '';
    in
    {
      home.packages = [
        dcal
      ];

      xdg.desktopEntries.dux-calendar = {
        name = "Dux Calendar";
        comment = "Calendar and events";
        exec = "${dcal}/bin/dcal run";
        icon = "x-office-calendar";
        terminal = false;
        categories = [
          "Office"
          "Calendar"
        ];
      };
    };
}
