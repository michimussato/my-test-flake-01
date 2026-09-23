{ self, inputs, ... }: {

  flake.nixosModules.nixos-qemu = { pkgs, lib, ...  }:

#  let
#    stateVersion = "26.05";
#  in

  {

    imports = [
      # Hardware
      self.nixosModules.hardware-nixos-qemu
      # System
      (self.modules.nixos.ssh)
      (self.modules.nixos.xserver)
      (self.modules.nixos.kde-plasma)
      (self.modules.nixos.localization)
      (self.modules.nixos.system-packages)
      # Users
      (self.modules.nixos.nixos)
      (self.modules.nixos.michael)
      # (self.modules.nixos.root)
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos-qemu";
    networking.networkmanager.enable = true;



    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # devenv
    # - https://discourse.nixos.org/t/devenv-sh-python-and-cachix-questions/78151/11
    # - https://devenv.sh/binary-caching/#adding-yourself-to-trusted-users
    # nix.settings.trusted-users = [ "root" "@wheel" ];
#    nix.settings.trusted-users = [
#      "root"
#      "nixos"
#      # "michael"
#    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Create basic default directories:
    # - https://www.man7.org/linux/man-pages/man5/tmpfiles.d.5.html
    # - https://search.nixos.org/options?channel=26.05&query=systemd.tmpfiles&type=options#show=option%253Asystemd.tmpfiles.rules
    systemd.tmpfiles = {
      rules = [
        # create the directory /data
        "d	/data	0777	root	root	-	-"
        # set chattr +i on /data
        "h	/data	-	-	-	-	+i"
        # https://www.reddit.com/r/NixOS/comments/1cot084/is_there_way_to_make_sddm_to_display_users_avatars/
        # - https://unix.stackexchange.com/a/755001
        #   - https://github.com/roberthoffmann/sddm/blob/develop/src/greeter/UserModel.cpp#L116
        # "L	/var/lib/AccountsService/icons/michael	-	-	-	-	${./path/to/your/picture.png}"
        # Todo:
        #  - [ ] Works, but fix hard coded path
        #        "L	/var/lib/AccountsService/icons/michael	-	-	-	-	/nix/store/dyj1kblmvrc42vbqmnr470yf12n4yw20-home-manager-files/.face"
        #"L	/var/lib/AccountsService/users2	-	-	-	-	${sddm-icons-package}"
        # https://www.mankier.com/5/tmpfiles.d:
        # L+    /symlink/to/[re]create                   -    -    -     -           symlink/target/path
#        "L+	/var/lib/AccountsService/icons	-	-	-	-	${sddm-icons-package}"
      ];
    };

    system.stateVersion = "26.05";

  };

}
