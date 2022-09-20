syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set expandtab
set relativenumber
set nu
set nowrap
set noswapfile
set incsearch
set signcolumn=yes
set colorcolumn=100
set hidden  "zu anderem buffer wechseln ohne zu speichern
set background=dark

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
" Initialize plugin system
Plug 'git@github.com:ycm-core/YouCompleteMe.git'
"Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                                                
Plug 'junegunn/fzf.vim'    
call plug#end()
colorscheme gruvbox

let mapleader = " "
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>k :wincmd k<CR>
"ycm keys
nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
"fzf keybindings
nnoremap <C-o> :Buffers<CR>

" Let clangd fully control code completion
"let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
"let g:ycm_clangd_binary_path = exepath("clangd")
