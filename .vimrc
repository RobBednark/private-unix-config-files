set nu   " line numbers
set ic   " ignorecase
set cc=80 " colorcolumn -- show a column of red at character position 80
set ai   " autoindent
set nows " nowrapscan - don't wrap around to beginning after search hits end-of-file
set hls  " highlightsearch
set ts=4 " tabstop
set sw=4 " shiftwidth
set incsearch " incremental search
set shell=/bin/bash   " I can't get zsh -i so use the .zshrc file and use my PATH (:!which python /usr/bin/python instead of /usr/local/bin/python), but bash does use them.
syntax on " syntax highlighting
set expandtab " expand tabs to spaces instead of tab characters
"set nu   " number -- line numbers
"set shell=/bin/bash
"set shell=/bin/bash\ -i   " Someone recommended this to get my .bashrc, but it wasn't necessary, and introduced it's own problems.  [see vvim]
"set shell=/usr/local/bin/zsh
"set shell=~/.zsh.from.vim.with.zshrc.zsh\ -i
"set shellcmdflag=-i  " need -i (interactive) option to zsh so that it reads in the .zshrc file and sets my PATH to use the right Python
"set shellcmdflag=-i  " need -i (interactive) option to bash so that it reads in the .bashrc file and sets my PATH to use the right Python
set textwidth=0
set fileformat=unix
set modelines=5  " Look for /* vim: ...: */ settings in the first/last this many lines of the file; if 0, modelines is disabled
set modeline  " look for /* vim: */ modeline settings at the beginning of a file
" I created this file manually using the ctags command.  -Rob Bednark 4/9/12
" Commented-out the following line 3/5/14 after installing Mavericks, and getting the following error when doing a :w
"    Taglist: Failed to generate tags for /Users/rob/.vimrc
" It did not help.
" set tags+=$HOME/.vim/tags/python.ctags
filetype plugin indent on
" Turn on omni autocompletion:
autocmd FileType python set omnifunc=pythoncomplete#Complete

" create a macros for inserting traces for pdb and for nose.
" To use, in command mode, type <backslash> followed by "b" or "n"
map <silent> <leader>p oimport pdb; pdb.set_trace()<esc>
map <silent> <leader>n oimport nose; nose.tools.set_trace()<esc>
map <silent> <leader>c :w<esc>:!python -m py_compile %<esc>

" Disable automatically-adding comment prefix on the next line:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" ofu is the "omnicomplete function".  Set it to 
set ofu=syntaxcomplete#Complete


" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
" e.g., 
" :S hello world 
"    search for "hello" followed by "world", including newlines
" :S! hello world
"     Searches for "hello" followed by "world", separated by any non-word characters (whitespace, newlines, punctuation).
"     Finds, for example, "hello, world" and "hello+world" and "hello ... world". The words can be on different lines.

function! SearchMultiLine(bang, ...)
    if a:0 > 0
        let sep = (a:bang) ? '\_W\+' : '\_s\+'
        let @/ = join(a:000, sep)
    endif
endfunction
" command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args



" The following are for pathogen.vim
" Description:  
"   Manage your 'runtimepath' with ease. In practical terms, pathogen.vim makes it super easy to install plugins and runtime files in their own private directories.
"   https://github.com/tpope/vim-pathogen
" I added pathogen#helptags() to automatically build the help for plugins like python-mode.  -Rob Bednark, 8/5/12

" Disable the python-mode plugin, because it's not finding os.urandom
" To disable a plugin, add it's bundle name to the following list.
"  -Rob Bednark, 8/5/12
"let g:pathogen_disabled = []
"call add(g:pathogen_disabled, 'python-mode')

"call pathogen#infect()
"call pathogen#helptags()
syntax on
filetype plugin indent on

" A shortcut for NERDTree
" map :nt :NERDTreeToggle

" wildignore is a setting for the Command-T plugin.  It indicates which files to ignore.
:set wildignore+=*.pyc,.git

" 8/5/12 Vundle section.
" I installed vundle so that I could easily install the headlights plugin.  -Rob Bednark, 8/5/12
set nocompatible               " be iMproved
filetype off                   " required!

" Disable Pydiction
set runtimepath-=~/.vim/bundle/Pydiction
" Disable python_mode
set runtimepath-=~/.vim/bundle/python_mode

" python-mode-klen
set runtimepath-=~/.vim/bundle/Python-mode-klen
set runtimepath-=~/.vim/bundle/Python-mode-klen/after
" Disable SuperTab
set runtimepath-=~/.vim/bundle/SuperTab
" Disable python_fold
set runtimepath-=~/.vim/bundle/python_fold
set runtimepath-=~/.vim/bundle/python_fold/after
" Disable syntastic
set runtimepath-=~/.vim/bundle/syntastic

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Python auto-completion
" Bundle 'pythoncomplete' -- commented-out because I'm getting poor autocompletion in python; I'm not sure if it's due to pythoncomplete or not

" My Bundles here:
" Bundle 'Python-mode-klen'  -- commented-out because getting urandom errors
" python tab completion:
" Bundle 'Pydiction'  -- commented-out because I'm getting poor autocompletion; I'm not sure if it's coming from Pydiction or something else

" ctrlp -- control-p -- file browser plugin, like Command-T; does not require Ruby like Command-T does
Bundle 'ctrlpvim/ctrlp.vim'

" command-t ==> file/dir explorer
" Commented-out command-t Wed 3/5/14 5:10pm after upgrade to Mavericks, because I'm getting a SEGV when running it with vim.
" Command-T ==> a plugin I love; for easily finding files to edit
Bundle 'wincent/Command-T'

" py-coverage ==> for highlighting lines that coverage indicates are not covered by the tests
Bundle 'py-coverage'

" vim-abolish ==> for doing smart replacements of words (e.g., foo=>bar Foo=>Bar FOO=>BAR fooies=>bars
Bundle 'tpope/vim-abolish'

" vim-fugitive ==> interact with git to see git diffs with vim-diff, and more
Bundle 'tpope/vim-fugitive'

" headlights ==> show plugins in Bundle menu in vim GUI's, e.g., mvim:
Bundle 'mbadran/headlights'
" required by headlights:
Bundle 'genutils'
" for doing multiple different selections:
Bundle 'multiselect'
" for automatically folding classes and functions:
" Bundle 'python_fold'
" tab-completion:
" Bundle 'SuperTab'

" ropevim -- Python refactoring
" Commented-out 3/5/14 after Mavericks upgrade when I started seeing this error on :w
"   Taglist: Failed to generate tags for /Users/rob/.vimrc
" Bundle 'ropevim'

" PreserveNoEOL - this modifies vim so that it doesn't automatically add newline characters at the end of a file.  This is useful for modifying files that other people created in other editors that do not have a newline at the end of a file, and git shows it as a diff when I save it in vim and it adds a newline on.
Bundle 'PreserveNoEOL'
" The following setting is needed to enable PreserveNoEOL
let g:PreserveNoEOL = 1 

filetype plugin indent on     " required!
nnoremap <leader>y :execute '!PYTHONWARNINGS="d" TRAPIT_ENV=test nosetests -s %'<cr>

" The following setting tells ctrlp to just use the current working directory as the ancestor
" see http://kien.github.io/ctrlp.vim/
let g:ctrlp_working_path_mode = ''
