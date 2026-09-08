{ pkgs, ... }:

let
  greetingTheme = pkgs.writeShellScriptBin "set-greeting-sound-theme" ''
    hour=$(date +%H)

    if [ "$hour" -ge 6 ] && [ "$hour" -lt 12 ]; then
      theme="morning"
    elif [ "$hour" -ge 12 ] && [ "$hour" -lt 18 ]; then
      theme="afternoon"
    else
      theme="evening"
    fi

    export GSETTINGS_SCHEMA_DIR="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-50.1/glib-2.0/schemas"

    ${pkgs.glib}/bin/gsettings set org.gnome.desktop.sound theme-name "$theme"
  '';
in
{
  home.packages = [
    greetingTheme
    pkgs.gsettings-desktop-schemas
  ];
}
