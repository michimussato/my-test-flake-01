{ inputs, self, ... }:

let
  username = "nixos";
in

{

  flake = {

    meta.users = {
      nixos = {
        email = "nixos@etik.com";
        name = "Nixos Sandbox User";
        username = "${username}";
      };
    };

    nixosModules.nixos-qemu-module.home-manager.users."${username}" = self.homeModules."${username}-module";

    nixosModules.nixos-qemu-module.users.users."${username}" = { pkgs, ... }:

#      imports = with inputs.self.modules.nixos; [
#        # developmentEnvironment
#      ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    {
      # hashedPasswordFile = "/etc/passwd";
      initialPassword = "${username}";
      isNormalUser = true;
      description = "NixOS Sandbox User";
      extraGroups = [ "networkmanager" "wheel" ];
      # https://wiki.nixos.org/wiki/SSH_public_key_authentication#SSH_server_configuration
      # - authorizedKeys go to /etc/ssh/authorized_keys.d/${username}
      # - services.openssh needs to enabled in configuration.nix
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5Fc5JyKRrduxt/QD0A+Ud1hvOZzhCZexc+Pmnm36k4"
        # note: ssh-copy-id will add user@your-machine after the public key
        # but we can remove the "@your-machine" part
      ];
      # packages = with pkgs; [
      #   kdePackages.kate
      # ];
    };
  };
}
