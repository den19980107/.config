
" vim:foldmethod=marker:foldlevel=0

" ignore files {{{
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
"}}}

" vim-plug {{{
call plug#begin()

" color scheme
Plug 'morhetz/gruvbox'

" 可以在打開vim 的時候顯示最近開啟的檔案
Plug 'mhinz/vim-startify'

" syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mtdl9/vim-log-highlighting'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

" auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" navigation/search file
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'preservim/nerdtree'

" 自動切換輸入法
Plug 'rlue/vim-barbaric'

" 選取一段程式碼後註解
Plug 'tpope/vim-commentary'

" 讓 neovim 可以跑在 browser 的輸入匡中
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(69) } }

" Debugger Plugins
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" c#
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'

" js
Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}

" react
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'epilande/vim-react-snippets'
Plug 'SirVer/ultisnips'

" vim-prisma 一個 js orm 的 syntax height
Plug 'pantharshit00/vim-prisma'

" better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git management plugin
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" pretty
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()
" }}} vim-plug

" Colors {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable                " enable syntax processing
colorscheme gruvbox
set background=dark
" }}} Colors

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set shiftwidth=4    " number of spaces to use for autoindent
set noexpandtab
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs

" Clipboard {{{
set clipboard+=unnamedplus
" }}} Clipboard

" UI Config {{{
set hidden
set number                   " show line number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace
set laststatus=2             " window will always have a status line
set nobackup
set noswapfile
set wrap!
set colorcolumn=120
set relativenumber
set mouse=a                  " enable mouse scroll
" }}} UI Config

" Search {{{
set incsearch       " search as characters are entered
set hlsearch        " highlight matche
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
" case-sensitive otherwise

" set Ag as the grep command
if executable('ag')
	" Note we extract the column as well as the file and line number
	set grepprg=ag\ --nogroup\ --nocolor\ --column
	set grepformat=%f:%l:%c%m
endif

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" }}} Search

" Folding {{{
set foldenable
set foldlevelstart=10  " default folding level when buffer is opened
set foldnestmax=10     " maximum nested fold
set foldmethod=syntax  " fold based on indentation
" }}} Folding

" Leader & Mappings {{{
let mapleader=" "   " leader is space

" reload vimrc
nmap <leader>sv :so $MYVIMRC<CR>

" resize window
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

" 搜尋某個東西之後按 n 可以讓游標保持在正中間
nnoremap n nzzzv
nnoremap N Nzzzv

" better ESC
inoremap jj <esc>

" fast save and close
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>q :q<CR>

" ignore default shif-h shift-l behavior
nnoremap <S-h> <NOP>
nnoremap <S-l> <NOP>

" move up/down consider wrapped lines
nnoremap j gj
nnoremap k gk

" fix indentation
nnoremap <leader>i mzgg=G`z<CR>

" turn off search highlights
nnoremap <leader><space> :nohlsearch<CR>

" move through grep results
nmap <silent> <right> :cnext<CR>
nmap <silent> <left> :cprev<CR>

" buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

" split navigation
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

" fast header source switch
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" fzf
nnoremap <c-p> :FZF<CR>

" YCM mappings {{{
nnoremap <leader>g :YcmCompleter GoTo<CR>
" }}}

" }}}

" NERDTree {{{
map <leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeWinSize = 50
" }}}

" Telescope {{{
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua << EOF
require('telescope').setup({
defaults = {
	prompt_prefix = " > ",
	file_ignore_patterns = {"node_modules"},
	color_devicons = true,
	},
extensions = {
	fzy_native = {
		override_generic_sorter = false,
		override_file_sorter = true,
		},
	}
})
require("telescope").load_extension("fzy_native")
EOF

" }}}

" Coc {{{
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-omnisharp', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed

" use tab and shift-tab to select auto complete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" auto import
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" 查看有哪些 code action
nnoremap <leader>a :CocAction <CR>

" rename varaible
nmap <leader>rn <Plug>(coc-rename)

" go to definition
nmap <silent> gd <Plug>(coc-definition)
" go to type definition
nmap <silent> gy <Plug>(coc-type-definition)
" go to implementation
nmap <silent> gi <Plug>(coc-implementation)
" go to references
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" 按下 CTR + T 來 toggle terminal
nmap <silent> <C-t> <Plug>(coc-terminal-toggle)
tmap <silent> <C-t> <C-\><C-n> <Plug>(coc-terminal-toggle)


" hover 到 code 上會顯示這個 function 或變數的 documentation
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction
" }}}

" Vim-Commentary {{{
nmap <leader>/ gcc
" }}}

" Airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" }}}

" YCM {{{
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
let g:ycm_filetype_specific_completion_to_disable = {
			\ 'gitcommit': 1,
			\ 'python': 1
			\}
let g:ycm_rust_src_path='/home/synasius/workspace/rust/src/'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's

" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file
let g:UltiSnipsUsePythonVersion = 2
" }}}

" Flake8 {{{
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
" }}}

" Vim-Startify {{{
let g:startify_custom_header = [
	\'                      (_)',
	\'  _ __   ___  _____   ___ _ __ ___',
	\' |  _ \ / _ \/ _ \ \ / / |  _ ` _ \',
	\' | | | |  __/ (_) \ V /| | | | | | |',
	\' |_| |_|\___|\___/ \_/ |_|_| |_| |_|',
	\ ]
" }}}

" Vim-JsDoc {{{
nmap <silent> <C-/> <Plug>(jsdoc)
" }}}

" Vim-Spectors {{{
fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" Debugger remaps
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

" }}}

" OmniSharp-Vim {{{
let g:OmniSharp_server_use_mono = 1
" }}}

" Functions {{{
" trailing whitespace
match ErrorMsg '\s\+$'
function! TrimWhiteSpace()
	%s/\s\+$//e
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()
" }}}

" firenvim {{{
" 再進入 github or gitlab 時自動把 file type 改成 markdown
au BufEnter git.gss.com.tw_*.txt set filetype=markdown
au BufEnter github.com_*.txt set filetype=markdown

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }
let fc = g:firenvim_config['localSettings']
let fc['https?://www.notion.so/'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://gremlify.com/'] = { 'takeover': 'never', 'priority': 1 }
" }}}

" gitgutter {{{
set updatetime=100 "讓 gitgutter 檢查 div 的時間間隔變快一點
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
"}}}

" OmniSharp {{{
let g:OmniSharp_server_stdio = 1
 " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
  " autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  " autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  " autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <S-k> <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  autocmd FileType cs nmap <silent> <buffer> <Leader>a <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>a <Plug>(omnisharp_code_actions)

  autocmd FileType cs nmap <silent> <buffer> <Leader>w <Plug>(omnisharp_code_format)
  autocmd FileType cs nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)

" }}}
