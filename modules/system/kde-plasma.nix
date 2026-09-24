# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    nixosModules.kde-plasma-module = { pkgs, ... }:

    let
      # Define the custom background package with the correct relative path
      # background-package = pkgs.runCommand "background-image" {} ''
      #   cp ${./payload/Wallpapers/nploschenko_rain_drops.png} $out
      # '';
      sddm-background-package = pkgs.stdenvNoCC.mkDerivation {
        name = "sddm-background-image";
        src = ./payload/Wallpapers/nploschenko_rain_drops.png;  # Place wallpaper.jpg in the same directory as this config file
        dontUnpack = true;
        installPhase = ''
          cp $src $out
        '';
      };

      # https://nix.dev/tutorials/working-with-local-files.html#adding-files-to-the-nix-store
      # fs = lib.fileset;
      # sourceIcons = ./payload/sddm_icons;
      # sourceIcons = lib.fileset.fromSource (lib.sourceFilesBySuffices ../../users/payload/sddm_icons [ ".jpg" ".png" ]);
      # icons = lib.sourceFilesBySuffices ../../users/payload/sddm_icons [ ".jpg" ];

      sddm-icons-package = pkgs.stdenv.mkDerivation {
        name = "sddm-icons-package";
    #      src = fs.toSource {
    #        root = ./.;
    #        fileset = sourceIcons;
    #      };
    #      src = sourceIcons;
        src = ./payload/sddm_icons;
        dontUnpack = true;
        postInstall = ''
          mkdir -p $out

          # copy ONLY contents of $src to the final directory
          cp -R $src/* $out

          # remove extensions as sddm only reads the stem
          for f in $out/*
          do
            new_name=$(echo "$f" | cut -f 1 -d '.')
            mv $f $new_name
          done
        '';
      };

    #    pkgs.stdenv.mkDerivation {
    #      name = "fileset";
    #      src = fs.toSource {
    #        root = ./.;
    #        fileset = sourceIcons;
    #      };
    #      postInstall = ''
    #        # mkdir $out
    #        ln -sfn $out /var/lib/AccountsService/icons
    #      '';
    #    }
    in

    {

      # Enable the KDE Plasma Desktop Environment.
      # - https://forum.manjaro.org/t/cant-change-background-of-sddm/144466
      # - https://discourse.nixos.org/t/sddm-background-on-default-theme/46263
      services.displayManager.sddm = {
        enable = true;
        autoNumlock = true;
        theme = "breeze";
      };
      services.desktopManager.plasma6.enable = true;

      environment.systemPackages = with pkgs; [
        # This defines a custom global sddm background image
        # Todo:
        #  - [ ] move this to Plasma or SDDM
        (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
          [General]
          background="${sddm-background-package}"
          type=image
        '')
      ];

      systemd.tmpfiles = {
        rules = [
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
          "L+	/var/lib/AccountsService/icons	-	-	-	-	${sddm-icons-package}"
        ];
      };

    };

  };

}
