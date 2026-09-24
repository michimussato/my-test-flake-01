{ self, inputs, ... }:

  let
    stateVersion = "26.05";
    hostName = "nixos-qemu";
  in

  {

  # Todo
  # - [ ] enable automatic GC; potentially in settings-module

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

    # To be verified...
    # OPTIMIZATION
    # https://nix.dev/manual/nix/2.34/command-ref/conf-file#conf-auto-optimise-store
    # this slows down builds but hardlinks duplicates
    nix.auto-optimise-store = true;
    # https://nixos.wiki/wiki/Storage_optimization

    # GC
    nix.gc = {
      automatic = true;
      # https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html?__goaway_challenge=meta-refresh&__goaway_id=7a61f9b5f162cd8d7bc631c2593fcbad&__goaway_referer=https%3A%2F%2Fsearch.nixos.org%2F
      dates = "daily";
      options = "--delete-older-than 30d";
      persistent = true;
    };

    nix.extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';

  };

}
