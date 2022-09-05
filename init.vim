":wincmd v<bar> :Ex <bar> :vertical resize 30<CR>General Settings 
set relativenumber                                                                                  
let mapleader = ","                                                                                 
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
"set foldmethod=syntax
"set foldlevel=0
"set foldclose=all  "closes fold automatically
set scrolloff=5




call plug#begin('~/.vim/plugged')                                                                   
Plug 'gruvbox-community/gruvbox'                                                                    
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"show tabs
Plug 'bling/vim-bufferline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()                                                                                     

colorscheme gruvbox                                                                                 
                                                                                                        
let g:netrw_banner = 0                                                                              
let g:netrw_liststyle = 3                                                                           
let g:netrw_browse_split = 4                                                                        
let g:netrw_altv = 1                                                                                
let g:netrw_winsize = 25

"NerdTree Bindings
"open tree
"nnoremap <leader>pv :NERDTree<CR>
"toggle tree
nnoremap <C-t> :NERDTreeToggle<CR>
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
"nnoremap <C-g> :GFiles<CR>
"set exrc    "die beiden zeilen sind fuer projekt settings, dafuer .exrc in project root kopieren
"set secure
source $HOME/.config/nvim/plug-config/coc.vim
"set transparency"
hi Normal guibg=NONE ctermbg=NONE

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
  },
  indent = {
    enable = true
  },
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

