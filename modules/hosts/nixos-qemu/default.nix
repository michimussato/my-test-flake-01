{ self, inputs, ... }: {

  flake.nixosConfigurations.nixos-qemu = inputs.nixpkgs.lib.nixosSystem {

    modules = [
      self.nixosModules.nixos-qemu-module
      self.nixosModules.home-manager-module
    ];

  };

}
