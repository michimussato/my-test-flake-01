# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    modules.nixos.ssh = { pkgs, ... }:

    {
      # Enable the OpenSSH daemon.
      services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings.PermitRootLogin = "yes";
        settings.PasswordAuthentication = true;
      };
    };

  };

}
