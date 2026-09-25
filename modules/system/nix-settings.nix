# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    nixosModules.nix-settings-module = { pkgs, ... }:

    {

      nix = {

        # GC
        gc = {
          automatic = true;
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html?__goaway_challenge=meta-refresh&__goaway_id=7a61f9b5f162cd8d7bc631c2593fcbad&__goaway_referer=https%3A%2F%2Fsearch.nixos.org%2F
          dates = "daily";
          options = "--delete-older-than 30d";
          persistent = true;
        };

        extraOptions = ''
          min-free = ${toString (100 * 1024 * 1024)}
          max-free = ${toString (1024 * 1024 * 1024)}
        '';

        settings = {

          # To be verified...
          # OPTIMIZATION
          # https://nix.dev/manual/nix/2.34/command-ref/conf-file#conf-auto-optimise-store
          # this slows down builds but hardlinks duplicates
          # https://nixos.wiki/wiki/Storage_optimization
          auto-optimise-store = true;

          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

    };

  };

}
