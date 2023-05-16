{ pkgs, ... }:
{
  environment.variables = { EDITOR = "nvim"; };

  environment.systemPackages = with pkgs; [
    (neovim.override {
      vimAlias = true;
      viAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [ 
          	gruvbox 
            vim-nix 
            nerdtree 
#            fzf-vim
            vim-devicons
            nvim-treesitter
            nvim-lspconfig
            cmp-nvim-lsp
            cmp-buffer
            cmp-path
            cmp-cmdline
            nvim-cmp
#            lightline-vim
            indent-blankline-nvim
            tagbar
            #nvim-ts-rainbow
            rainbow
            nvim-comment
#            nvim-gdb
#            vim-bufferline
            bufferline-nvim
            telescope-nvim
            tokyonight-nvim
            gruvbox-material
          ]; 
          opt = [];
        };
        customRC = ''
          " your custom vimrc
          source /home/hidrol/Dotfiles/init.vim
        '';
      };
    }
  )];
}
