# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    modules.nixos.kde-plasma = { pkgs, ... }:

    {

      # Enable the KDE Plasma Desktop Environment.
      # - https://forum.manjaro.org/t/cant-change-background-of-sddm/144466
      # - https://discourse.nixos.org/t/sddm-background-on-default-theme/46263
      services.displayManager.sddm = {
        enable = true;
        autoNumlock = true;
        theme = "breeze";
      };
      services.desktopManager.plasma6.enable = true;

    };

  };

}
