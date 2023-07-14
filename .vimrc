if $VIM_PATH != ""
        let $PATH = $VIM_PATH
endif

" VimPlug
" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"vim-plug:
Plug 'neovim/nvim-lspconfig'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()
set nu
set tw=78
set colorcolumn=78

filetype plugin on
let g:go_fmt_command = "goimports"
inoremap jh <Esc>
nnoremap jh <Esc>
nnoremap <silent> <C-Right> $
nnoremap <silent> <C-Left> 0
set hidden
nnoremap <C-N> :bn <CR>
nnoremap <C-P> :bp <CR>
"Uncomment to override defaults:
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_mermaid = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1
" let g:go_fmt_command = 'goimports'             " or
" let g:go_imports_mode = 'goimports'            " or

lua << EOF
 
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
 
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
 
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
 
  -- You can delete this if you enable format-on-save.
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
end
 
require('lspconfig').gopls.setup {
  cmd = {'gopls', '-remote=auto'},
  on_attach = on_attach,
  flags = {
      -- Don't spam LSP with changes. Wait a second between each.
      debounce_text_changes = 1000,
  },
}

EOF

