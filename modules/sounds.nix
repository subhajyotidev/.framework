{ pkgs, ... }:

let
  schemaDir = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-${pkgs.gsettings-desktop-schemas.version}/glib-2.0/schemas";

  dmsStartup = pkgs.writeShellScriptBin "dms-startup" ''
    export GSETTINGS_SCHEMA_DIR="${schemaDir}"

    hour=$(date +%H)

    if [ "$hour" -ge 6 ] && [ "$hour" -lt 12 ]; then
      theme="morning"
    elif [ "$hour" -ge 12 ] && [ "$hour" -lt 18 ]; then
      theme="afternoon"
    else
      theme="evening"
    fi

    ${pkgs.glib}/bin/gsettings set org.gnome.desktop.sound theme-name "$theme"

    exec dms run
  '';
in
{
  home.packages = [
    pkgs.gsettings-desktop-schemas
    dmsStartup
  ];

  home.sessionVariables.GSETTINGS_SCHEMA_DIR = schemaDir;
}
