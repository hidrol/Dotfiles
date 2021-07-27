"General Settings
set relativenumber                                                                                  
"let mapleader = " "                                                                                 

set tabstop=4 softtabstop=4
syntax on                                                                                           
set tabstop=4 softtabstop=4                                                                         
set shiftwidth=4                                                                                    
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

call plug#begin('~/.vim/plugged')                                                                   
Plug 'gruvbox-community/gruvbox'                                                                    
" Initialize plugin system                                                                          
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Stable version of coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()                                                                                     
colorscheme gruvbox                                                                                 
                                                                                                        
let g:netrw_banner = 0                                                                              
let g:netrw_liststyle = 3                                                                           
let g:netrw_browse_split = 4                                                                        
let g:netrw_altv = 1                                                                                
let g:netrw_winsize = 25
		
set exrc    "die beiden zeilen sind fuer projekt settings, dafuer .exrc in project root kopieren
set secure
source $HOME/.config/nvim/plug-config/coc.vim
