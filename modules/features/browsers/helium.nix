{ lib, pkgs, ... }:

let
  version = "0.15.4.1";

  src = pkgs.fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
    hash = "sha256-h3yxZnMb/EHvPJALQlJgHUVYUNsfuv0pnewgf6K6sx8=";
  };

  appimageContents = pkgs.appimageTools.extractType2 {
    pname = "helium";
    inherit version src;
  };

  helium = pkgs.appimageTools.wrapType2 {
    pname = "helium";
    inherit version src;

    extraInstallCommands = ''
      export INSTALL='${lib.getExe' pkgs.coreutils "install"}'

      "$INSTALL" -m 444 -D \
        ${appimageContents}/helium.desktop \
        $out/share/applications/helium.desktop

      "$INSTALL" -m 444 -D \
        ${appimageContents}/helium.png \
        $out/share/icons/hicolor/512x512/apps/helium.png

      substituteInPlace $out/share/applications/helium.desktop \
        --replace 'Exec=AppRun' 'Exec=helium'
    '';
  };

in
{
  home.packages = [
    helium
  ];
}
