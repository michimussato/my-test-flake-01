# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    nixosModules.settings-module = { pkgs, ... }:

    {

      nixpkgs = {
        config = {
          # Allow unfree packages
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
          permittedInsecurePackages = [
            # deps for djv
            "openexr-2.5.10"
            "ilmbase-2.5.10"
          ];
        };
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

    };

  };

}
