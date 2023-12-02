{ config, pkgs,lib, ... }:
{
	home.packages = with pkgs; [
    (pkgs.python3.withPackages (ps: [
      ps.debugpy
    ]))
	  # pkgs is the set of all packages in the default home.nix implementation
    #tmux
    #neofetch
    #fzf # used for formarks
    # glfw
    #kitty
    # zsh-autosuggestions
    # zsh-syntax-highlighting
    # zsh-vi-mode
    #chromium
    #gnumake
    #lldb # c debugger
    #direnv # for nix shell
    gnome.nautilus # gui finder
    #gdb # c debugger
    #ripgrep # used for telescope
    #fd # needed for telescop or recommended
    #man-pages
    firefox
    #ccls #c language server
    #ctags
    #nil # nix language server
    #nodePackages.pyright
    #vscode
    #screen
    #dtc # for decompiling dtb files
    #ubootTools # for extracting fitimage files
    wireshark
    #nmap
    #nix-index
    autorandr
    #xclip
    #python3
    #unzip
    #zip
    epdfview
    #git
    #wget 
    #tmux 
    joplin-desktop
    #nextcloud-client
    #ccls #c language server
    #ctags #for neovim
    #htop
    #usbutils
    #firefox
    #xclip
    #libusb
    lxc
    ntfs3g
    pciutils
    #wl-clipboard

  ];


}
