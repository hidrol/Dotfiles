# A bare configuration.nix, with LXC specific stuff, for use with LXD
# https://www.srid.ca/2012301.html#running-nixos-in-lxd
#
# To initialize the container:
#   - cp /run/current-system/configuration.nix /etc/nixos/
#   - nixos-rebuild switch
{ config, lib, pkgs, modulesPath, ... }:



{
  imports =
    [ # add a copy of nixpkgs to the image

    ];


  # The majority of this indented snippet comes from
  # https://github.com/NixOS/nixpkgs/issues/9735#issuecomment-500164017

    # it is not perfect because `boot.isContainer` means NixOS containers
    # not LXC, but let have something to start with
    boot.isContainer = true;

    # `boot.isContainer` implies NIX_REMOTE = "daemon"
    # (with the comment "Use the host's nix-daemon")
    # Our host is Ubuntu, so we do not expect any "host's nix-daemon"
    environment.variables.NIX_REMOTE = lib.mkForce "";

    # (optional) suppress daemons which will vomit to the log about their unhappiness
    systemd.services."console-getty".enable = false;
    systemd.services."getty@"       .enable = false;


  fileSystems."/" = 
    { device = "/var/lib/lxd/disks/default.img";
      fsType = "btrfs";
    };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  environment.systemPackages = [ 
	pkgs.tmux
	pkgs.vim 
];

  # Allow SSH based login
  services.openssh = {
    enable = true;
    ports = [22];
  };

  networking = {
    # On my system eth0 is the interface used by the LXD container. YMMV.
    interfaces.eth0.useDHCP = true;
  };

  users.extraUsers.app = {
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.bash;
  };

  users.users.hidrol = {
    isNormalUser = true;
    home = "/home/hidrol";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };




  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "22.11"; # Did you read the comment?

  # copy the configuration.nix into /run/current-system/configuration.nix
  system.copySystemConfiguration = true;
}

