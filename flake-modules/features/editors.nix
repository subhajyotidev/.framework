{
  flake.modules.homeManager.editors = {
    imports = [
      ../../modules/features/editors/emacs.nix
      ../../modules/features/editors/zed-editor.nix
    ];
  };
}
