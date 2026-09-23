# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

let
  username = "michael";
in

{

  flake = {

    meta.users = {
      henry = {
        email = "michimussato@etik.com";
        name = "Michael Mussato";
        username = "${username}";
      };
    };

    modules.nixos."${username}" = { pkgs, ... }:

    {
      imports = with inputs.self.modules.nixos; [
        # developmentEnvironment
      ];

      users.users."${username}" = {
        # hashedPasswordFile = "/etc/passwd";
        initialPassword = "${username}";
        isNormalUser = true;
        description = "Michael Mussato";
        extraGroups = [ "networkmanager" "wheel" ];
        # https://wiki.nixos.org/wiki/SSH_public_key_authentication#SSH_server_configuration
        # - [x] works
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5Fc5JyKRrduxt/QD0A+Ud1hvOZzhCZexc+Pmnm36k4"
          # note: ssh-copy-id will add user@your-machine after the public key
          # but we can remove the "@your-machine" part
        ];
        # packages = with pkgs; [
        #   kdePackages.kate
        # ];
      };

  #      users.users."${username}" = {
  #        isNormalUser = true;
  #        initialPassword = "changeme";
  ##        shell = pkgs.zsh;
  #      };
  #      programs.zsh.enable = true;
    };

  };

#  flake.modules.homeManager."${username}" = {
#    imports = with inputs.self.modules.homeManager; [
#      system-desktop
#    ];
#    home.username = "${username}";
#  };
}

#{ ... }: {
#
#  flake = {
#
#    meta.users = {
#      henry = {
#        email = "michimussato@etik.com";
#        name = "Michael Mussato";
#        username = "michael";
#      };
#    };
#
#    modules.nixosUsers.michael = {pkgs, ...}: {
#
#      users.users."michael" = {
#        # hashedPasswordFile = "/etc/passwd";
#        initialPassword = "michael";
#        isNormalUser = true;
#        description = "Michael Mussato";
#        extraGroups = [ "networkmanager" "wheel" ];
#        # https://wiki.nixos.org/wiki/SSH_public_key_authentication#SSH_server_configuration
#        # - [x] works
#        openssh.authorizedKeys.keys = [
#          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5Fc5JyKRrduxt/QD0A+Ud1hvOZzhCZexc+Pmnm36k4"
#          # note: ssh-copy-id will add user@your-machine after the public key
#          # but we can remove the "@your-machine" part
#        ];
#        # packages = with pkgs; [
#        #   kdePackages.kate
#        # ];
#      };
#    };
#  };
#}
