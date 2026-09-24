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

    system.stateVersion = "${stateVersion}";

  };

}
