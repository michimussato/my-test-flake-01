{ self, inputs, ... }: {

  flake.nixosModules.nixos-qemu-module = { pkgs, ... }:

  let
    stateVersion = "26.05";
  in

  {
    imports = [
      self.nixosModules.nixos-qemu-hardware
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos-qemu";
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
