{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;

    package = pkgs.emacs-pgtk;

    extraPackages =
      epkgs:
      builtins.attrValues {
        inherit (epkgs.treesit-grammars)
          with-all-grammars
          ;
      }
      ++ builtins.attrValues {
        inherit (epkgs)
          meow
          vertico
          orderless
          consult
          corfu
          cape
          avy
          eat
          envrc
          clojure-ts-mode
          fish-mode
          haskell-mode
          kdl-mode
          nix-ts-mode
          ocaml-ts-mode
          ;
      };
  };

  services.emacs = {
    enable = true;

    client = {
      enable = true;
    };
  };

  xdg.configFile."emacs/init.el".source = ./emacs/init.el;
}
