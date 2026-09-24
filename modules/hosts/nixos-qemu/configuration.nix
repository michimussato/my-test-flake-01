{ self, inputs, ... }:

  let
    stateVersion = "26.05";
    hostName = "nixos-qemu";
  in

  {

  flake.nixosModules."${hostName}-module" = { pkgs, ... }: {

    imports = [
      self.nixosModules."${hostName}-hardware"
      self.nixosModules.settings-module
      self.nixosModules.system-packages-module
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "${hostName}";
    networking.networkmanager.enable = true;

    environment.systemPackages = [
      pkgs.vim
      pkgs.firefox
      pkgs.tree
    ];

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = false;
    };

    system.stateVersion = "${stateVersion}";

  };

}
