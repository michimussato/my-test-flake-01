{ inputs, self, lib, ... }:

let
  username = "root";
in

{

  flake = {

    meta.users = {
      root = {
        email = "nixos@etik.com";
        name = "Root User";
        username = "${username}";
      };
    };

    modules.nixos."${username}" = {pkgs, ...}: {
      users.users.root = lib.mkForce {
        # https://discourse.nixos.org/t/how-to-disable-root-user-account-in-configuration-nix/13235
        initialPassword = "${username}";
        description = "NixOS Root User";
        home = "/root";
        uid = 0;
        group = "root";
      };
    };
  };
}
