set exrc
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set mouse=a
set numberwidth=1
set clipboard=unnamedplus
syntax enable
set showmatch
set laststatus=2
set magic
set encoding=UTF-8

let g:coc_disable_startup_warning = 1

" Give more display for displaying messages
set cmdheight=1

" Having longer updatetime (default is 4000ms = 4s) leads to noticeable delays
" and poor user experience
set updatetime=50

"Don't pass messages to |ins-completition-menu|.
set shortmess+=c

"PLUGINS START
call plug#begin('~/.vim/plugged')

"Theme
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

"Highlight
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', { 'branch' : 'main' }
Plug 'jparise/vim-graphql'
Plug 'hail2u/vim-css3-syntax'

"Autocomplete
Plug 'neoclide/coc.nvim', { 'branch' : 'release'}
Plug 'alvan/vim-closetag'

"File manager/search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'

"Git
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

"Snippets
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'

"IDE funtions
Plug 'tpope/vim-fugitive'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

"PLUGINS END

let g:coc_global_extensions = [
            \ 'coc-tsserver',
            \ 'coc-prettier',
            \ 'coc-eslint',
            \ 'coc-css',
            \ 'coc-pairs',
            \ 'coc-stylelint',
            \ 'coc-scssmodules',
            \ 'coc-docker',
            \ 'coc-json',
            \ 'coc-html',
            \ 'coc-yaml',
            \ 'coc-vimlsp',
            \]

colorscheme gruvbox
highlight Normal guibg=none
let g:gruvbox_contrast_dark = "hard"

let mapleader = " "
nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup PACO
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

"Coc word diagnostic
nnoremap <silent> K :call CocAction('doHover')<CR>

"UltiSnips
let g:UltiSnipsExpandTrigger='<c-space>'

"easymotion
nmap <Leader>s <Plug>(easymotion-s2)

"nerdtree
nmap <Leader>nt :NERDTreeFind<CR>
"let NERDTreeQuitOnOpen=1

"Quit and Save shortcuts
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>


" vim-closetag
let g:closetag_filenames='*.html,*.js,*.jsx,*.tsx'
let g:closetag_regions = {
    \ 'typescript': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

"Imports
nnoremap <Leader>if <Plug>(JsFileImport)
nnoremap <Leader>iF <Plug>(JsFileImportList)
nnoremap <Leader>ig <Plug>(JsGotoDefinition)
nnoremap <Leader>iG <Plug>(JsGotoDefinition)
nnoremap <Leader>ip <Plug>(PromptJsFileImport)
nnoremap <Leader>is <Plug>(SortJsFileImport)
nnoremap <Leader>ic <Plug>(JsFixImport)
let g:js_file_import_sort_after_insert = 1

"NerdTreeGit
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"GitGutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'

"Vim Airline
let g:airline_powerline_fonts = 1

"Syntax Highlight
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:typescript_indent_disable = 1
let g:vim_jsx_pretty_colorful_config = 1

"Files Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"FZF
noremap <leader>fs :Files<cr>

" Move lines up and down
nnoremap <C-Down> :m .+1<CR>==
nnoremap <C-Up> :m .-2<CR>==
inoremap <C-Down> <Esc>:m .+1<CR>==gi
inoremap <C-Up> <Esc>:m .-2<CR>==gi
vnoremap <C-Down> :m '>+1<CR>gv=gv
vnoremap <C-Up> :m '<-2<CR>gv=gv
