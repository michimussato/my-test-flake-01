# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    modules.nixos.system-packages = { pkgs, ... }:

    {

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
  #      programs.zsh.enable = true;
    };

  };

}
