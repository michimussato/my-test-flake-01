# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

let
  username = "michael";
  host = "nixos-qemu";
in

{

  flake.nixosModules."${host}-module" = {

    home-manager.users."${username}" = self.homeModules."${username}-module";

    users.users."${username}" = { pkgs, ... }:

    {
#      imports = with inputs.self.modules.nixos; [
#        # developmentEnvironment
#      ];

      # hashedPasswordFile = "/etc/passwd";
      initialPassword = "${username}";
      isNormalUser = true;
      description = "Michael Mussato";
      extraGroups = [ "networkmanager" "wheel" ];
      # https://wiki.nixos.org/wiki/SSH_public_key_authentication#SSH_server_configuration
      # - authorizedKeys go to /etc/ssh/authorized_keys.d/${username}
      # - services.openssh needs to enabled in configuration.nix
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5Fc5JyKRrduxt/QD0A+Ud1hvOZzhCZexc+Pmnm36k4"
        # note: ssh-copy-id will add user@your-machine after the public key
        # but we can remove the "@your-machine" part
      ];
      #packages = with pkgs; [
      #  kdePackages.kate
      #];
    };

  };

}
