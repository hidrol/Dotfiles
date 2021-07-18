"General Settings
set relativenumber                                                                                  
let mapleader = " "                                                                                 

if exists('g:vscode')
    nnoremap <leader>h :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    xnoremap <leader>h :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    nnoremap <leader>l :call VSCodeNotify('workbench.action.navigateRight')<CR>
    xnoremap <leader>l :call VSCodeNotify('workbench.action.navigateRight')<CR>
    nnoremap <leader>k :call VSCodeNotify('workbench.action.navigateUp')<CR>
    xnoremap <leader>k :call VSCodeNotify('workbench.action.navigateUp')<CR>
    nnoremap <leader>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
    xnoremap <leader>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
    "inoremap <leader>n :call VSCodeNotify('selectNextSuggestion')<CR>
    "go to definition
    "nnoremap <silent> <Leader>gd :call VSCodeNotify('editor.action.revealDefinition')<CR>
    " Simulate same TAB behavior in VSCode
    "nmap <Tab> :Tabnext<CR>
    "nmap <S-Tab> :Tabprev<CR>

else

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
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
let g:ycm_autoclose_preview_window_after_insertion = 1  "schliesst scratch preview
let g:ycm_autoclose_preview_window_after_completion = 1 "schliesst scratch preview
"fzf keybindings
nnoremap <C-o> :Buffers<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :GFiles<CR>
set exrc    "die beiden zeilen sind fuer projekt settings, dafuer .exrc in project root kopieren
set secure

endif
