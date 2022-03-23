"General Settings
set relativenumber                                                                                  
let mapleader = ","                                                                                 
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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bling/vim-bufferline'
call plug#end()                                                                                     

colorscheme gruvbox                                                                                 
                                                                                                        
let g:netrw_banner = 0                                                                              
let g:netrw_liststyle = 3                                                                           
let g:netrw_browse_split = 4                                                                        
let g:netrw_altv = 1                                                                                
let g:netrw_winsize = 25

"open vim file explorer
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
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
nnoremap <C-g> :GFiles<CR>
set exrc    "die beiden zeilen sind fuer projekt settings, dafuer .exrc in project root kopieren
set secure
source $HOME/.config/nvim/plug-config/coc.vim
