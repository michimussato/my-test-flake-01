{ self, inputs, ... }: {

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.nixos = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.nixos-module
      {
        home.username = "nixos";
        home.homeDirectory = "/home/nixos";
      }
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules.nixos-module = { pkgs, ... }: {
    programs.bash.enable = true;
    programs.bash.shellAliases.ll = "ls -l";

    home.packages = [ pkgs.hello ];
    home.stateVersion = "26.05";
  };

}
