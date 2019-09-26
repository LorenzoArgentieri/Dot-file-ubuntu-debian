call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/indentpython.vim' , { 'for' : ['python','python2','python3']}
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'davidhalter/jedi-vim', {'for' : ['python','python2','python3']}
call plug#end()


" set pyhton path
let g:python3_host_prog = "/usr/bin/python3"
let g:python_host_prog = "/usr/bin/python2"


" python config

au BufNewFile,BufRead *.py,*.pyw 
	\ highlight ExtraWhitespace ctermbg=red
	\|match ExtraWhitespace /\s\+$/ 

au BufNewFile,BufRead *.py,*.pyw
	\ setlocal foldmethod=indent
	\| setlocal foldlevel=99
	\| setlocal tabstop=4
	\| setlocal softtabstop=4
	\| setlocal shiftwidth=4
	\| setlocal textwidth=79
	\| setlocal expandtab
	\| setlocal autoindent
	\| setlocal fileformat=unix
	\| setlocal encoding=utf-8

au BufNewFile,BufRead *.py,*.pyw
	\ py3 << EOF
	\|import os
	\|import sys
	\|if 'VIRTUAL_ENV' in os.environ:
	\|	project_base_dir= os.eviron['VIRTUAL_ENV']
	\|	activate_this = os.path.join(project_base_dir, 'bin/active_this.py')
	\|	execfile(activate_this, dict(__file__=activate_this))
	\|EOF

set nu
set nocompatible
syntax on

" ycm config"
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_binary_path='python3'
