":wincmd v<bar> :Ex <bar> :vertical resize 30<CR>General Settings 
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

"gdb
let g:termdebug_wide=1
"let g:termdebugger="gdb"
packadd termdebug

"colorscheme tokyonight
"colorscheme gruvbox
colorscheme gruvbox-material
                                                                                                        
let g:netrw_banner = 0                                                                              
let g:netrw_liststyle = 3                                                                           
let g:netrw_browse_split = 4                                                                        
let g:netrw_altv = 1                                                                                
let g:netrw_winsize = 25
		
set secure

"lightline


" let g:lightline = {
"         \ 'colorscheme': 'gruvbox',
"         \ }



" We don't need to see things like -- INSERT -- anymore
set noshowmode
"end lightline


" " LSP config (the mappings used in the default file don't quite work right)
" nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

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
"bufferline
"nnoremap <silent> gb :BufferLinePick<CR>
"nnoremap <leader>g :BufferLinePick<CR>
nnoremap <C-o> :BufferLinePick<CR>
nnoremap <silent> gq :BufferLinePickClose<CR>
"nnoremap <leader>c :BufferLinePickClose<CR>
"formating
"nnoremap <silent> ff    <cmd>lua vim.lsp.buf.format { async = true } <CR>
"nnoremap <leader>f    <cmd>lua vim.lsp.buf.format { async = true } <CR>




"fzf keybindings
" nnoremap <C-o> :Buffers<CR> 
" nnoremap <C-p> :Files<CR>
" nnoremap <C-g> :Rg<CR>
"nnoremap <C-g> :GFiles<CR>

"set transparency"
"hi Normal guibg=NONE ctermbg=NONE

"lsp-cmp
set completeopt=menu,menuone,noselect

"snippy mappings
"imap <expr> <Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-advance)' : '<Tab>'
"#imap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
"#smap <expr> <Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>'
"#smap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
"#xmap <Tab> <Plug>(snippy-cut-text)

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
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
--local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
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
--vim.comment
--require('Comment').setup()
require('nvim_comment').setup()

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
require('lspconfig')['ccls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

vim.opt.termguicolors = true
require("bufferline").setup{
  -- numbers = function(opts)
  --   return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
  -- end,


}



require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

EOF

" nnoremap <C-o> :Buffers<CR> 
" nnoremap <C-p> :Files<CR>
" nnoremap <C-g> :Rg<CR>
"nnoremap <C-g> :GFiles<CR>

"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()
"set foldmethod=indent
"highlight Folded guifg=PeachPuff4
"highlight FoldColumn guibg=darkgrey guifg=white
"


" function! NvimGdbNoTKeymaps()
"   tnoremap <silent> <buffer> <esc> <c-\><c-n>
" endfunction
"
" let g:nvimgdb_config_override = {
"   \ 'key_next': 'n',
"   \ 'key_step': 's',
"   \ 'key_finish': 'f',
"   \ 'key_continue': 'c',
"   \ 'key_until': 'u',
"   \ 'key_breakpoint': 'b',
"   \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
"   \ }
