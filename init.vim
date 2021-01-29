" plugin conf {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/indentpython.vim' , { 'for' : ['python','python2','python3']}
Plug 'lervag/vimtex' , {'for':['tex','plaintex']}
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'liuchengxu/vista.vim'
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector'
Plug  'szw/vim-maximizer'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'stsewd/fzf-checkout.vim'
call plug#end()
" }}}

" general conf {{{
filetype plugin on
syntax on
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
let g:airline_theme='gruvbox'
set textwidth=80
set number
set diffopt=internal,filler,vertical
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set inccommand=split
set noexpandtab
let mapleader=" "
inoremap jk <Esc>
" status conf {{{
	set laststatus=2
	set statusline=%.20F
	set statusline+=%=
	set statusline+=%l,%c
" }}}
" search conf {{{
set incsearch
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
" }}}

" nerdtree like netrw conf {{{
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
	" autocmd!
	" autocmd VimEnter * :Vexplore
" augroup END
" }}}

" }}}

" global variables {{{
" set pyhton path
let g:python3_host_prog = "/usr/bin/python3"
let g:python_host_prog = "/usr/bin/python2"

" latex filetype
let g:tex_flavor = 'latex'
let g:vimtex_syntax_enabled = 0
let g:vimtex_fold_enabled= 0
let g:vimtex_indent_enabled= 0


" }}}

" python conf {{{
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
		\| setlocal expandtab
		\| setlocal textwidth=79
		\| setlocal autoindent
		\| setlocal fileformat=unix
		\| let b:ale_linters = ['autopep8',"yapf"]
		\| let b:ale_fixers = ['autopep8',"yapf","remove_trailing_lines","trim_whitespace"]
		\| let b:ale_warn_about_trailing_whitespace = 1
" add virtualenv support
"	au BufNewFile,BufRead *.py,*.pyw
"		\ python3 << EOF
"		\ import os
"		\ import sys
"		\ if 'VIRTUAL_ENV' in os.environ:
"		\	 project_base_dir= os.eviron['VIRTUAL_ENV']
"		\ 	 activate_this = os.path.join(project_base_dir, 'bin/active_this.py')
"		\ 	 execfile(activate_this, dict(__file__=activate_this))
"		\EOF
augroup END
" }}}

"  ale config {{{
let b:ale_linters = {
\	'javascript' : ['eslint'],
\	'python' : ['autopep8','yapf']
\}

let g:ale_fixers = {
\	'javascript' : ['eslint','prettier'],
\	'python' : ['autopep8','yapf'],
\	'*':['remove_trailing_lines','trim_whitespace']
\}
" }}}

" frontend conf {{{
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
		\| let b:ale_linters = ["eslint","prettier"]
		\| let b:ale_fixers = ["eslint","prettier","remove_trailing_lines","trim_whitespace"]
	"let g:prettier#quickfix_enabled = 0
	"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html PrettierAsync
augroup END
" }}}

" vimlatex conf {{{
augroup latex_files
	au!
	au Filetype plaintex,tex
		\ filetype plugin indent on
		\| syntax on
		\| let g:vimtex_view_general_viewer= 'zathura'
		\| let g:vimtex_view_method= 'zathura'
		
augroup END
" }}}

" viscript conf {{{
augroup vim_files
	au!
	au Filetype vim
		\ setlocal foldmethod=marker
		\| vnoremap <leader>mk <Esc>`<O"<Esc>A<space><space><Esc>3A{<Esc>`>o"<Esc>A<space><Esc>3A}<Esc>
		\| vnoremap <leader>ex :<c-u>@*<cr> 
		\| onoremap inmk :<c-u>exe "norm! ?^\\\"\\s.*\\s\{\\{3}\r2lvt{hi"<cr>
augroup END
" }}}

" tmux conf {{{
let g:tmux_navigator_no_mappings=1
nnoremap <silent> <C-W>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-W>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-W>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-W>l :TmuxNavigateRight<cr>
" }}}

" coc conf {{{
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n> ":
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-refernces)
" }}}

" vimspector conf {{{
 "let g:vimspector_enable_mappings = 'HUMAN'
fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

 " Debugger remaps
nnoremap <leader>mx :MaximizerToggle!<CR>
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
nmap <leader>dr <Plug>VimspectorRestart
nmap <leader>dp <Plug>VimspectorPause
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

 " <Plug>VimspectorStop
 " <Plug>VimspectorPause
 " <Plug>VimspectorAddFunctionBreakpoint
" }}}

" FZF conf {{{
nnoremap <C-p> :GFiles<CR>
let g:fzf_layout = { 'window':{ 'width':0.8 , 'height':0.8 }}
let $FZF_DEFAULT_OPTS='--reverse'
" }}}

" Git conf {{{
let g:signify_sing_add ='+'
let g:signify_sing_delete_first_line ='-'
let g:signify_sing_delete ='_'
let g:signify_sing_change ='~'

let g:signify_sing_show_count = 0
let g:signify_sing_show_text = 1

nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gs :G<CR>
nnoremap <leader>gc :GBranches<CR>
" }}}
