# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    modules.nixos.trusted-users = { pkgs, ... }:

    {

      # devenv
      # - https://discourse.nixos.org/t/devenv-sh-python-and-cachix-questions/78151/11
      # - https://devenv.sh/binary-caching/#adding-yourself-to-trusted-users
      nix.settings.trusted-users = [ "root" "@wheel" ];
  #    nix.settings.trusted-users = [
  #      "root"
  #      "nixos"
  #      # "michael"
  #    ];

    };

  };

}
