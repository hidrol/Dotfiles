{ pkgs, ...}:
{
	home.packages = with pkgs; [
    zoxide
    tmux
    neofetch
    fzf # used for formarks
    # glfw
    #kitty
    # zsh-autosuggestions
    # zsh-syntax-highlighting
    # zsh-vi-mode
    #chromium
    gnumake
    lldb # c debugger
    direnv # for nix shell
    #gnome.nautilus # gui finder
    gdb # c debugger
    ripgrep # used for telescope
    fd # needed for telescop or recommended
    man-pages
    #firefox
    ccls #c language server
    ctags
    nil # nix language server
    nodePackages.pyright # python language server
    #vscode
    screen
    dtc # for decompiling dtb files
    ubootTools # for extracting fitimage files
    #nmap
    nix-index
    xclip # not sure if this is needed in lxc
    python3
  ];
}
