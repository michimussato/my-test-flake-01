# Flake-parts: option `flake.modules’ is defined multiple times while it’s expected to be unique
#
# https://discourse.nixos.org/t/flake-parts-option-flake-modules-is-defined-multiple-times-while-its-expected-to-be-unique/71584/4

{ inputs, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];
}
