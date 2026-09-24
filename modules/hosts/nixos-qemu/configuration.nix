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
      self.nixosModules.openssh-service-module
      self.nixosModules.systemd-module
      self.nixosModules.openssh-service-module
      self.nixosModules.localization-module
      self.nixosModules.xserver-module
      self.nixosModules.kde-plasma-module
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "${hostName}";
    networking.networkmanager.enable = true;

    system.stateVersion = "${stateVersion}";

  };

}
