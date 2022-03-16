"General Settings
set relativenumber                                                                                  
let mapleader = ","                                                                                 
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bling/vim-bufferline'
"Plug 'neovim/nvim-lspconfig'
"Plug 'hrsh7th/nvim-compe'
call plug#end()                                                                                     
colorscheme gruvbox                                                                                 
                                                                                                        
let g:netrw_banner = 0                                                                              
let g:netrw_liststyle = 3                                                                           
let g:netrw_browse_split = 4                                                                        
let g:netrw_altv = 1                                                                                
let g:netrw_winsize = 25
		
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>k :wincmd k<CR>
"ycm settings
"nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
"nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
"let g:ycm_autoclose_preview_window_after_insertion = 1  "schliesst scratch preview
"let g:ycm_autoclose_preview_window_after_completion = 1 "schliesst scratch preview
"fzf keybindings
nnoremap <C-o> :Buffers<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :GFiles<CR>
set exrc    "die beiden zeilen sind fuer projekt settings, dafuer .exrc in project root kopieren
set secure
" Let clangd fully control code completion
"let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
"let g:ycm_clangd_binary_path = exepath("clangd")
source $HOME/.config/nvim/plug-config/coc.vim
