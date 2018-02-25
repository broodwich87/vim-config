" Automatic Reloading of .vimrc 
autocmd! bufwritepost .vimrc source %

" Better Copy & Paste:
set pastetoggle=<F2>
set clipboard=unnamed

"stop trying to act like vi
set nocompatible 

"search down into subfolders
"provides tab-completion for all file-related tasks
set path+=**

"Display all matching files when we tab complete
set wildmenu

"filetype off
set rtp+=~/.vim/bundle/Vundle.vim

"switch buffers without losing info
set hidden

"Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

"fold with spacebar
nnoremap <space> za

"Disable swap files etc
"set nobackup
"set nowritebackup
"set noswapfile

"NETRW Directory Browser*****

" let g:netrw_liststyle = 3 " Set liststyle to 3 (out of 4 choices)
let g:netrw_banner = 0 "remove the banner
" let g:netrw_browse_split = 4 "open in prior window
let g:netrw_winsize = 40 "sets directory explorer width to 20% of the page
" let g:netrw_altv = 1 "open files on the
" augroup ProjectDrawer
	" autocmd!
	" autocmd VimEnter * :Vexplore
" augroup END

fun! VexToggle(dir)
	if exists("t:vex_buf_nr")
		call VexClose()
	else
		call VexOpen(a:dir)
	endif
endf

fun! VexOpen(dir)
	let g:netrw_browse_split=4
	let vex_width = 45

	execute "Vexplore " . a:dir
	let t:vex_buf_nr = bufnr("%")
	wincmd H

	call VexSize(vex_width)
endf

fun! VexClose()
	let cur_win_nr = winnr()
	let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

	1wincmd w
	close
	unlet t:vex_buf_nr

	execute (target_nr - 1) . "wincmd w"
	call NormalizeWidths()
endf

fun! VexSize(vex_width)
	execute "vertical resize" . a:vex_width
	set winfixwidth
	call NormalizeWidths()
endf

fun! NormalizeWidths()
	let eadir_pref = &eadirection
	set eadirection=hor
	set equalalways! equalalways!
	let &eadirection = eadir_pref
endf

augroup NetrwGroup
	autocmd! BufEnter * call NormalizeWidths()
augroup END


"end NETRW*****

"Rebind <Leader> Key:
:let mapleader = ","

" SNIPPETS:
"read an empty HTML template and move cursor to title
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>jwf>a

"easy navigation through buffers.  Type 'gb' without quotes, then utilize tab
"completion to select buffer
nnoremap gb :ls<CR>:b<Space>

"toggles NETRW tree
nnoremap ,tree :Vexplore<CR>

"Bind noho (nohighlights)
"Effectively removes highlight from last search
nnoremap <C-n> :nohl<CR>

" Quicksave Command:
nnoremap <C-Z> :update<CR>

"map sort function
vnoremap <Leader>s :sort<CR>

"netrw stuff
" noremap <Leader><Tab> :call VexToggle(getcwd())<CR>
noremap gt :call VexToggle(getcwd())<CR>
noremap <Leader>` :call VexToggle("")<CR>





" End SNIPPETS:

"make things pretty
syntax on

"turns on filetype, plugin, and indent
filetype indent plugin on

"Create the 'tags' file(may need to install ctags first)
command! MakeTags !ctags -R .
"now we can:
" - use ^] to jump to tag under cursor
" - use g^] for ambiguous tags: gives a list of all instances of tag, even
	"   from different files
" - use ^t to jump back up the tag stack

" Autocomplete:
inoremap <C-e> <C-n>
"^x^n for JUST this file
" ^x^f for filenames (works with path trick)
"^x^] for tags only
"^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/indentpython.vim'
"Plugin 'scrooloose/syntastic'
"Plugin 'scrooloose/nerdtree'
Plugin 'whatyouhide/vim-gotham'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'dracula/vim'
Plugin 'nanotech/jellybeans.vim'

call vundle#end()

set textwidth=79

au BufNewFile,BufRead *.py
  \ set tabstop=4 |
  \ set fileformat=unix |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set textwidth=79 |
  \ set expandtab |
  \ set autoindent |

au BufNewFile,BufRead *.c
  \ set tabstop=4 |
  \ set fileformat=unix |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set textwidth=79 |
  \ set expandtab |
  \ set autoindent |

au BufNewFile,BufRead *.cpp
  \ set tabstop=4 |
  \ set fileformat=unix |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set textwidth=79 |
  \ set expandtab |
  \ set autoindent |

au BufNewFile,BufRead *.cs
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set expandtab |
  \ set autoindent |

au BufNewFile,BufRead *.js, *.html
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |


set foldmethod=indent
set foldlevel=99
set modeline
set encoding=utf-8
set clipboard=unnamed
set nu
set relativenumber
let g:syntastic_cpp_checkers = ['gcc']
"let python_highlight_all=1

"easy paragraph formating
vmap Q gq
nmap Q gqap

"Spell-check set to F6"
map <F6> :setlocal spell! spelllang=en_us<CR>

"Must be inserted BEFORE colorscheme
"Set 256 Color:
set t_Co=256
"Show Whitespace:
au BufRead, BufNewFile *.py, *.pyw, *.c, *.h match BadWhitespace /\s\s+$/
" set background=dark

" COLOR SCHEMES********
" " colorscheme gotham
" colorscheme lucius
" LuciusDark
colorscheme dracula
" colorscheme jellybeans
