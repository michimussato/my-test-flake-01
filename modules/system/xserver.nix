# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    modules.nixos.xserver = { pkgs, ... }:

    {

      services.xserver.enable = true;

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
    };

  };

}
