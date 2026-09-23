{ self, inputs, ... }: {

  flake.nixosModules.nixos-qemu = { pkgs, lib, ...  }:

#  let
#    stateVersion = "26.05";
#  in

  {

    imports = [
      self.nixosModules.hardware-nixos-qemu
      (self.modules.nixos.nixos)
      (self.modules.nixos.michael)
      # (self.modules.nixos.root)
      # Modules starting with _ are ignored by
      # import-tree, so they could be traditionally
      # referenced by their file names
      # ./_hardware-configuration.nix
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos-qemu";
    networking.networkmanager.enable = true;

#    services.xserver.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Set your time zone.
    time.timeZone = "Europe/Zurich";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable the KDE Plasma Desktop Environment.
    # - https://forum.manjaro.org/t/cant-change-background-of-sddm/144466
    # - https://discourse.nixos.org/t/sddm-background-on-default-theme/46263
#    services.displayManager.sddm = {
#      enable = true;
#      autoNumlock = true;
#      theme = "breeze";
#    };
#    services.desktopManager.plasma6.enable = true;

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

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
    #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #   wget
      git
      tree
      dnsutils
      htop
      btop
      lshw
      rsnapshot
      rclone
      gparted
      ffmpeg
      # qemu_full  # causes errors
      docker
      podman
      podman-compose
      podman-tui
      devenv
      # nvidia-container-toolkit
    ];

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

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings.PermitRootLogin = "yes";
      settings.PasswordAuthentication = true;
    };

    system = {
      # inherit stateVersion;
      stateVersion = "26.05";
    };

  };

}
