set encoding=UTF-8
" make vim xdg base dirs compliance ---------- {{{
set nocompatible
set undodir=$XDG_CACHE_HOME/vim
set directory=$XDG_CACHE_HOME/vim,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
set viminfo+=n/home/lorenzo/.cache/vim/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
" }}}

" plugin conf---------- {{{
call plug#begin('~/.config/vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vim-scripts/indentpython.vim' , { 'for' : ['python','python2','python3']}
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py' }
Plug 'davidhalter/jedi-vim', {'for' : ['python','python2','python3']}
Plug 'lervag/vimtex' , {'for':['tex','plaintex']}
Plug 'christoomey/vim-tmux-navigator'
call plug#end()
" }}}

" general setting ---------- {{{
filetype plugin on
syntax on
set textwidth=80
set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
let mapleader=","
inoremap jk <Esc>
	" status line conf ---------- {{{
		set laststatus=2
		set statusline=%.20F
		set statusline+=%=
		set statusline+=%l,%c
	" }}}
	" search conf ---------- {{{
	set incsearch
	augroup vimrc-incsearch-highlight
	  autocmd!
	  autocmd CmdlineEnter /,\? :set hlsearch
	  autocmd CmdlineLeave /,\? :set nohlsearch
	augroup END
	" }}}

" }}}

" global variable settings---------- {{{
" set pyhton path
let g:python3_host_prog = "/usr/bin/python3"
let g:python_host_prog = "/usr/bin/python2"

" ycm config
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_binary_path='python3'

" latex filetype
let g:tex_flavor = 'latex'
let g:vimtex_syntax_enabled = 0
let g:vimtex_fold_enabled= 0
let g:vimtex_indent_enabled= 0
if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
endif
" }}}

" python config files ---------- {{{
augroup python_files
	au!
	" python config
	au BufNewFile,BufRead *.py,*.pyw
		\ highlight ExtraWhitespace ctermbg=red
		\| match ExtraWhitespace /\s\+$/
		\| setlocal foldmethod=indent
		\| setlocal foldlevel=99
		\| setlocal tabstop=4
		\| setlocal softtabstop=4
		\| setlocal shiftwidth=4
		\| setlocal noexpandtab
		\| setlocal textwidth=79
		\| setlocal autoindent
		\| setlocal fileformat=unix

	" add virtualenv support
	au BufNewFile,BufRead *.py,*.pyw
		\ python3 << EOF 
		\ import os
		\ import sys
		\ if 'VIRTUAL_ENV' in os.environ:
		\ 	project_base_dir= os.eviron['VIRTUAL_ENV']
		\ 	activate_this = os.path.join(project_base_dir, 'bin/active_this.py')
		\ 	execfile(activate_this, dict(__file__=activate_this))
		\ EOF
augroup END
" }}}

" front end web dev ----------- {{{
augroup front_end_files
	au!
	au BufNewFile,BufRead *.html,*.css,*.js
		\ setlocal nowrap
		\| setlocal tabstop=4
		\| setlocal softtabstop=4
		\| setlocal shiftwidth=4
		\| setlocal foldmethod=indent
		\| setlocal foldlevelstart=2
		\| setlocal noexpandtab

	"let g:prettier#quickfix_enabled = 0
	"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html PrettierAsync
augroup END
" }}}

" latex files config ---------- {{{
augroup latex_files
	au!
	au Filetype plaintex,tex
		\ filetype plugin indent on
		\| syntax on
		\| let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
		\| let g:vimtex_view_general_viewer= 'zathura'
		\| let g:vimtex_view_method= 'zathura'
		
augroup END
" }}}

" vimfile  config ---------- {{{
augroup vim_files
	au!
	au Filetype vim
		\ setlocal foldmethod=marker
		\| vnoremap <leader>mk <Esc>`<O"<Esc>A<space><Esc>10A-<Esc>A<space><Esc>3A{<Esc>`>o"<Esc>A<space><Esc>3A}<Esc>
		\| vnoremap <leader>ex :<c-u>@*<cr> 
		\| onoremap inmk :<c-u>exe "norm! ?\\\"\\s.*-\\{10}\r/\\([:alnum:]\\\|\\s\\)\\{1}\ri\s\ev/-\\{10}\rh"<cr>
augroup END
" }}}

" tmux conf ---------- {{{
let g:tmux_navigator_no_mappings=1
nnoremap <silent> <C-W>h  :TmuxNavigateLeft<cr>
nnoremap <silent> <C-W>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-W>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-W>l :TmuxNavigateRight<cr>
" }}}
