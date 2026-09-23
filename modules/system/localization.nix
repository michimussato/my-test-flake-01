# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    modules.nixos.localization = { pkgs, ... }:

    {

      # Set your time zone.
      time.timeZone = "Europe/Zurich";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";
    };

  };

}
