# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    nixosModules.localization-module = { pkgs, ... }:

    {

      # Set your time zone.
      time.timeZone = "Europe/Zurich";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";
    };

  };

}
