# https://github.com/mightyiam/dendritic
#
# Based on:
# https://github.com/henrysipp/nix-setup/blob/nix-flakes/flake.nix


{

  description = "Dendritic Configuration Attempt";

  inputs =
# MUST NOT USE VARIABLES in flake.nix
# - https://discourse.nixos.org/t/why-cant-i-use-let-variables-in-flake-nix-inputs/39929
#  let
#    stateVersion = "26.05";
#  in

  {
    # https://github.com/NixOS/nixpkgs/tree/nixos-unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # https://github.com/nix-community/home-manager
    # Standalone Installation for now (https://nix-community.github.io/home-manager/installation.html):
    # - https://nix-community.github.io/home-manager/installation/standalone.html#standalone-installation
    # 26.05 required for Hyprland Lua config generation (configType = "lua")
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # plasma-manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager/trunk";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Dendritic

    # https://github.com/hercules-ci/flake-parts
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    # https://github.com/denful/import-tree
    import-tree.url = "github:denful/import-tree/main";

    # # https://github.com/nix-community/nix-wrapper-modules
    # wrapper-modules.url = "github:nix-community/nix-wrapper-modules";

#    ags.url = "github:Aylur/ags";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
#    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
#    nix-webapps.url = "github:TLATER/nix-webapps";
#    nixpkgs.url = "github:/nixos/nixpkgs/nixos-unstable";
#    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
#    nixpkgs-unstable.url = "github:/nixos/nixpkgs/nixpkgs-unstable";
#    nixvim.url = "github:nix-community/nixvim";
#    nixvim.inputs.nixpkgs.follows = "nixpkgs";
#    systems.url = "github:nix-systems/default/main";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
  {inherit inputs;}
  (inputs.import-tree ./modules);
#  {
#    imports = [
#      inputs.import-tree ./hosts
#      inputs.import-tree ./users
#    ];
#  };
#  (inputs.import-tree ./hosts);
#  (inputs.import-tree ./users)
  # inputs.home-manager.flakeModules.home-manager
  # Use this with caution:
  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    allow-unfree = true;
  };
}
