":wincmd v<bar> :Ex <bar> :vertical resize 30<CR>General Settings 
set relativenumber                                                                                  
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



call plug#begin('~/.vim/plugged')                                                                   
Plug 'gruvbox-community/gruvbox'                                                                    
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"show tabs
"Plug 'bling/vim-bufferline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'honza/vim-snippets'
" For vsnip users.
"Plug 'hrsh7th/cmp-vsnip'
"Plug 'hrsh7th/vim-vsnip'
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()                                                                                     

colorscheme gruvbox                                                                                 

"lightline

set noshowmode

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }



" We don't need to see things like -- INSERT -- anymore
set noshowmode
"end lightline


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

"set transparency"
hi Normal guibg=NONE ctermbg=NONE

"lsp-cmp
set completeopt=menu,menuone,noselect

"snippy mappings
imap <expr> <Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-advance)' : '<Tab>'
imap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
smap <expr> <Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>'
smap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
xmap <Tab> <Plug>(snippy-cut-text)


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
  require('snippy').expand_snippet(args.body) -- For `snippy` users.
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
    { name = 'snippy' }, -- For snippy users.
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

EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
"set foldmethod=indent
"highlight Folded guifg=PeachPuff4
"highlight FoldColumn guibg=darkgrey guifg=white
"
"formating
nnoremap <silent> ff    <cmd>lua vim.lsp.buf.format { async = true } <CR>
