{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hidrol";
  home.homeDirectory = "/home/hidrol";

	home.packages = [
	    # pkgs is the set of all packages in the default home.nix implementation
  ];
	
	home.file.".config/nvim/init.vim".source = ./init.vim;
	home.file.".tmux.conf".source = ./tmux.conf;


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      gruvbox 
      tokyonight-nvim
      gruvbox-material
      vim-nix 
      nerdtree 
#            fzf-vim
      vim-devicons
      nvim-treesitter.withAllGrammars
      #pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ p.c p.java ])
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
#            lightline-vim
      indent-blankline-nvim
      tagbar
      nvim-ts-rainbow
      nvim-comment
#            nvim-gdb
#            vim-bufferline
      bufferline-nvim
      telescope-nvim

    ];
    # Use the Nix package search engine to find
    # even more plugins : https://search.nixos.org/packages
  };
	

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
