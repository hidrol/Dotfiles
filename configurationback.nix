{ config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

#  boot.loader.grub.device = "/dev/sda";   # (for BIOS systems only)
  boot.loader.systemd-boot.enable = true; # (for UEFI systems only)



  # Enable the OpenSSH server.
  services.sshd.enable = true;

  networking.networkmanager.enable = true;
   networking.hostName = "nixos";

 sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

users.users.hidrol = {
  isNormalUser = true;
  home = "/home/hidrol";
  extraGroups = [ "wheel" "networkmanager" ];
	shell = pkgs.zsh;
};

nixpkgs.config.allowUnfree = true;

environment.systemPackages = with pkgs; [
  #feh
#  compton
  picom
  kitty
  kitty-themes
  neofetch
  zsh
  git
  wget 
  vim
  neovim
  tmux 
  joplin-desktop
  nextcloud-client
  ccls
  ctags
  htop
  usbutils
  firefox
  xclip
    #(neovim.override {
      #vimAlias = true;
  #viAlias = true;
      #configure = {
        #packages.myPlugins = with pkgs.vimPlugins; {
          #start = [ gruvbox vim-nix nerdtree vim-plug ]; 
          #opt = [];
        #};
        #customRC = ''
          #set relativenumber
#set tabstop=4 softtabstop=4
#let mapleader = " "
#syntax on
#set tabstop=2 softtabstop=2
#set shiftwidth=2
##set smartindent
#set expandtab
#set nu
#set nowrap
#set noswapfile
#set incsearch
#set signcolumn=yes
#set colorcolumn=100
#set hidden  "zu anderem buffer wechseln ohne zu speichern
#set background=dark
#set completeopt-=preview "schliesst scratch preview
#set scrolloff=5
#
        #'';
      #};
    #}
  #)
];

environment.variables = { EDITOR = "nvim"; };


programs.zsh = {
	enable = true;
	#enableAutosuggestions = true;
	autosuggestions.enable = true;
	syntaxHighlighting.enable = true;
#	ohMyZsh = {
#	    enable = true;
#};
};

#users.defaultUserShell = pkgs.zsh;

users.defaultUserShell = pkgs.zsh;

environment.shells = with pkgs; [ zsh ];



#programs.alacritty.enable = true;

# Set console.
  console = {
    #font = "Lat2-Terminus16";
    font = "FiraCode";
    #keyMap = "us";
	useXkbConfig = true;
  };


fonts.fonts = with pkgs; [
  fira-code
  fira-code-symbols
  (nerdfonts.override { fonts = [ "FiraCode" ]; })
];

services.openssh.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

   # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;

services.xserver.enable  = true;
 services.xserver.windowManager.i3.enable = true;
 services.xserver.desktopManager.xterm.enable = false;
 services.xserver.displayManager.defaultSession  = "none+i3";
 services.xserver.layout  = "us";
 services.xserver.displayManager.lightdm.enable  = true;
 services.xserver.displayManager.autoLogin.enable  = true;
services.xserver.displayManager.autoLogin.user  = "hidrol";
services.xserver.xkbOptions = "ctrl:swapcaps";

#services.xserver.videoDrivers  = [ "nvidia" ];

#services = {
#  fstrim.enable = true;
#  openssh.enable = true;
#  xserver.enable = true;
  #compton.enable = true;
  #compton.shadow = true;
#  compton.inactiveOpacity = "0.8";
#  printing.enable = true;
#};


  system.stateVersion = "22.05";

  home-manager.users.hidrol = { pkgs, ... }:  {
    home.packages = with pkgs;
    [ 
      cmatrix
    (neovim.override {
      vimAlias = true;
	viAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [ 
            gruvbox 
            vim-nix 
            nerdtree 
            #fzf
            fzf-vim
#Plug 'junegunn/fzf.vim'
#"Plug 'bling/vim-bufferline'
#            vim-bufferline
#Plug 'ryanoasis/vim-devicons'
            vim-devicons
            nvim-treesitter
#lsp and cmp 
#Plug 'neovim/nvim-lspconfig'
#Plug 'hrsh7th/cmp-nvim-lsp'
#Plug 'hrsh7th/cmp-buffer'
#Plug 'hrsh7th/cmp-path'
#Plug 'hrsh7th/cmp-cmdline'
#Plug 'hrsh7th/nvim-cmp'
            nvim-lspconfig
            cmp-nvim-lsp
            cmp-buffer
            cmp-path
            cmp-cmdline
            nvim-cmp
#Plug 'honza/vim-snippets'
#            vim-snippepts
#" For vsnip users.
#"Plug 'hrsh7th/cmp-vsnip'
#            cmp-vsnip
#"Plug 'hrsh7th/vim-vsnip'
#            vim-vsnip
#            nvim-snippy
#            cmp-snippy
#Plug 'dcampos/nvim-snippy'
#Plug 'dcampos/cmp-snippy'
#"
#Plug 'itchyny/lightline.vim'
             lightline-vim
#Plug 'lukas-reineke/indent-blankline.nvim'
            indent-blankline-nvim
#Plug 'tpope/vim-obsession'
#            vim-obsession
#Plug 'majutsushi/tagbar'
            tagbar
            nvim-ts-rainbow
            ]; 
          opt = [];
        };
        customRC = ''
          set relativenumber                                                                                  
      set tabstop=4 softtabstop=4
      let mapleader = " "
      syntax on                                                                                           
      set tabstop=2 softtabstop=2                                                                         
      set shiftwidth=2                                                                                    
      set smartindent                                                                                     
      set expandtab                                                                                       
      set nu                                                                                              
      set nowrap                                                                                          
      set noswapfile                                                                                     
      set incsearch                                                                                       
      set signcolumn=yes                                                                                  
      set colorcolumn=100                                                                                 
      set hidden  "zu anderem buffer wechseln ohne zu speichern                                           
      set background=dark                                                                                 
      set completeopt-=preview "schliesst scratch preview
      set scrolloff=5

      set clipboard=unnamedplus
      set clipboard=unnamed

      set mouse=a
      nnoremap <C-t> :NERDTreeToggle<CR>
          colorscheme gruvbox                                                                                 

          let g:netrw_banner = 0                                                                              
let g:netrw_liststyle = 3                                                                           
let g:netrw_browse_split = 4                                                                        
let g:netrw_altv = 1                                                                                
let g:netrw_winsize = 25
		
set secure

"lightline

set noshowmode

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }


" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
"NerdTree Bindings
"open tree
"nnoremap <leader>pv :NERDTree<CR>
"toggle tree
nnoremap <C-t> :NERDTreeToggle<CR>
"tag bar toogle
nmap <C-b> :TagbarToggle<CR>
"open vim file explorer
"nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
"move to left split
nnoremap <leader>h :wincmd h<CR>
"move to down split
nnoremap <leader>j :wincmd j<CR>
"move to right split
nnoremap <leader>l :wincmd l<CR>
"move to up split
nnoremap <leader>k :wincmd k<CR>

"fzf keybindings
nnoremap <C-o> :Buffers<CR> 
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>
"nnoremap <C-g> :GFiles<CR>

"set transparency"
"hi Normal guibg=NONE ctermbg=NONE

"lsp-cmp
set completeopt=menu,menuone,noselect

"snippy mappings
"imap <expr> <Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-advance)' : '<Tab>'
"imap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
"smap <expr> <Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>'
"smap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
"xmap <Tab> <Plug>(snippy-cut-text)


lua <<EOF

--tree sitter config
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    },
  }
--code completion
-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
  -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
  -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
  -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end,
  },
window = {
  completion = cmp.config.window.bordered(),
  documentation = cmp.config.window.bordered(),
  },
mapping = cmp.mapping.preset.insert({
["<C-k>"] = cmp.mapping.select_prev_item(),
["<C-j>"] = cmp.mapping.select_next_item(),
['<C-b>'] = cmp.mapping.scroll_docs(-4),
['<C-f>'] = cmp.mapping.scroll_docs(4),
['<C-Space>'] = cmp.mapping.complete(),
['<C-e>'] = cmp.mapping.abort(),
['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
    sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    }, {
    { name = 'buffer' },
    })
  })

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
  { name = 'buffer' },
  })
})

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
      }
    })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
    { name = 'path' }
    }, {
    { name = 'cmdline' }
    })
  })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--require'lspconfig'.clangd.setup{}
--this is for ccls instead of clangd
local lspconfig = require('lspconfig')
lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
      };
    }
  }

require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
"set foldmethod=indent
"highlight Folded guifg=PeachPuff4
"highlight FoldColumn guibg=darkgrey guifg=white
"
"formating
"nnoremap <silent> ff    <cmd>lua vim.lsp.buf.format { async = true } <CR>
nnoremap <leader>f    <cmd>lua vim.lsp.buf.format { async = true } <CR>


        '';
      };
    }
  )];

  programs.git = {
    enable = true;
    userName  = "hidrol";
    userEmail = "stefan.grambach@googlemail.com";
  };

  };


}
