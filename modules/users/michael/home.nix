{ self, inputs, ... }:

let
  username = "michael";
  shellAliases = {
    gs = "git status";
    ".." = "cd ..";
    ls = "ls -alh";
  };
  # home-dir = "$HOME";
in

{

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations."${username}" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules."${username}-module"
      # {
      #   home.username = "${username}";
      #   home.homeDirectory = "/home/${username}";
      # }
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules."${username}-module" = { pkgs, ... }: {
    programs.bash = {
      enable = true;
      inherit shellAliases;
    };

    home.packages = [ pkgs.hello ];
    home.stateVersion = "26.05";
  };

}
