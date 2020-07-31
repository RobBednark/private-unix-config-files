" set nu   " line numbers
" set cursorline  " underline the line that the cursor is on
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
set scrolloff=5  " when searching, keep the next match 5 lines from the bottom

set foldopen-=search  " when searching, don't open folds; constrain search to unfolded text

" exrc => read from .vimrc in current directory after reading primary .vimrc
" secure => disallow risky commands from local .vimrc/.exrc files
set secure exrc

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
filetype plugin indent on

" The following two autocmd's will save folds when exiting, and load them again when re-opening the file.
" http://vim.wikia.com/wiki/Make_views_automatic
" Note: use * so it matches all files (not *.*) per https://stackoverflow.com/questions/2142402/code-folding-is-not-saved-in-my-vimrc  5/24/20
" Note: "silent!" is used to prevent showing error messages like the following when starting vim without a filename:
"    Error detected while processing BufWinEnter Autocommands for "*":
"    E32: No file name
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

" Turn on omni autocompletion:
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab

" create a macros for inserting traces for pdb and for nose.
" To use, in command mode, type <backslash> followed by "b" or "n"
" \a ==> :ALEfix  (fix javascript prettier/eslint errors using the ALE plugin)
" \c ==> :!python -m py_compile %
" \d ==> (diff)  :r!git diff --cached
" \e ==> open the file in Chrome
" \m ==> highlight the text inside the matching brace/parenthesis for 3 seconds
" \n ==> add python nose set_trace()
" \p ==> add python set_trace()
" \r ==> :TabooRename  (rename the current tab)
" \s ==> :tab split  (create a new tab)
" \u ==> add pudb set_trace()
map <silent> <leader>a :ALEFix<CR>
map <silent> <leader>c :w<esc>:!python -m py_compile %<esc>
map <silent> <leader>d :r!git diff --cached<esc>
map <silent> <leader>e :!open -a google\ chrome % <esc>
map <leader>m  m[%v%:sleep 3000m<CR>`[  
map <silent> <leader>n oimport nose; nose.tools.set_trace()<esc>
map <silent> <leader>p oimport pdb; pdb.set_trace()<esc>
map <silent> <leader>r :TabooRename 
map <silent> <leader>s :tab split<esc>
map <silent> <leader>u oimport pudb; pudb.set_trace()<esc>
" from John de la Garza 10/26/15.  I think what this does is allow a different leader, e.g., "," instead of "\"
" let mapleader="," noremap <Leader>n :bn<Enter> noremap <Leader>d oimport pdb;pdb.set_trace() 

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

syntax on
filetype plugin indent on

" wildignore is a setting for the Command-T plugin.  It indicates which files to ignore.
:set wildignore+=*.pyc,.git,node_modules

" 7.31.20, 8/5/12 Vundle section.  https://github.com/VundleVim/Vundle.vim
" I installed the vundle package manager to easily manage vim packages/plugins.  -Rob Bednark, 8/5/12
set nocompatible               " be iMproved, required by Vundle
filetype off                   " required by Vundle!  

" Disable SuperTab
set runtimepath-=~/.vim/bundle/SuperTab
" Disable python_fold
set runtimepath-=~/.vim/bundle/python_fold
set runtimepath-=~/.vim/bundle/python_fold/after
" Disable syntastic
set runtimepath-=~/.vim/bundle/syntastic

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim  " required by Vundle
" call vundle#rc()  " Apparently no longer required by Vundle  7.31.20
call vundle#begin()

" let Vundle manage Vundle; required by Vundle
Plugin 'VundleVim/Vundle.vim'

" ================================================================================
" My Bundles here:
" ================================================================================

" vim-rainbow-parenthesis -- give different colors to each pair of parentheses/brackets/html-tags/...
" Bundle 'dbarsam/vim-rainbow-parentheses'
Bundle 'luochen1990/rainbow'

" vim-surround - Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.
" https://github.com/tpope/vim-surround
" e.g.,
"  cs"' => when inside "foo", change to become 'foo'
Bundle 'tpope/vim-surround'

" AsyncCommand - AsyncCommand allows you to execute shell commands without waiting for them to complete. When the application terminates, its output can be loaded into a vim buffer. 
" AsyncCommand requires vim to be compiled with +clientserver:
"   AsyncCommand requires vim compiled with +clientserver (see :help +clientserver)
" Added then disabled 6/14/18 -Rob Bednark
" Bundle 'idbrii/AsyncCommand'

" vim-table-mode - automatically align tables as you type
"   disabled by default;
"   :TableModeEnable -- enable table mode
"   :TableModeDisable -- disable table mode
"   (I tried it but it didn't work for me 10/18/19; it didn't add spacing)
"   Other features:
"      - remove column
"      - align data in column
Bundle 'dhruvasagar/vim-table-mode'

" taboo: for renaming tabs (installed 6/4/18):
"  :TabooRename my tab name
Bundle 'gcmt/taboo.vim'

" vim-airline: show a nice status/tablin on the bottom  (mode, git branch, git lines added/changed/changed), e.g.,
"    NORMAL  +0 ~1 -0 ᚠ master  .vimrc                                                                                        vim  utf-8[unix]   51% ☰  142/276 ㏑ :107  ☲ [167]trailing
" https://github.com/vim-airline/vim-airline
" (installed 6/4/18)
Bundle 'vim-airline/vim-airline'

" ctrlp -- control-p -- file browser plugin, like Command-T; does not require Ruby like Command-T does
Bundle 'ctrlpvim/ctrlp.vim'
let g:ctrlp_match_window = 'min:4,max:999'  " allow the ctrlp results window to be up to 999 lines high instead of just 10



" command-t ==> file/dir explorer
" Commented-out command-t Wed 3/5/14 5:10pm after upgrade to Mavericks, because I'm getting a SEGV when running it with vim.
" Command-T ==> a plugin I love; for easily finding files to edit
" Bundle 'wincent/Command-T'

" coveragepy -- for highlighting lines in python code that don't have code coverage
" https://github.com/alfredodeza/coveragepy.vim
" I installed this 10/27/15, but it doesn't seem to have the Coveragepy command like the help indicates.
Bundle 'alfredodeza/coveragepy.vim'

" py-coverage ==> for highlighting lines that coverage indicates are not covered by the tests
" 10/27/15 :PyCoverageHighlight -- this is the command that works; note that it calls the "coverage" script, 
"          so you need to be in a virtualenv with "pip install coverage"
Bundle 'py-coverage'

" vim-abolish ==> for doing smart replacements of words (e.g., foo=>bar Foo=>Bar FOO=>BAR fooies=>bars
Bundle 'tpope/vim-abolish'

" vim-fugitive ==> interact with git to see git diffs with vim-diff, and more
" :Gvsplit -- vertical split, showing prev version and modified version
" :Gdiff -- if git conflicts, will open 3 panes with different versions
Bundle 'tpope/vim-fugitive'

" headlights ==> show plugins in Bundle menu in vim GUI's, e.g., mvim:
" Commented-out 3/15/18 when upgraded to Vim 8
" Bundle 'mbadran/headlights'
" required by headlights:
" Bundle 'genutils'

" Commented-out 3/5/14 after Mavericks upgrade when I started seeing this error on :w
"   Taglist: Failed to generate tags for /Users/rob/.vimrc
" Bundle 'ropevim'

" PreserveNoEOL - this modifies vim so that it doesn't automatically add newline characters at the end of a file.  This is useful for modifying files that other people created in other editors that do not have a newline at the end of a file, and git shows it as a diff when I save it in vim and it adds a newline on.
Bundle 'PreserveNoEOL'
" The following setting is needed to enable PreserveNoEOL
" let g:PreserveNoEOL = 1 

" conflict-marker: this highlights git conflicts, and allows you to go to next/prev conflict with [x ]x 
" This plugin defines mappings as default, ct for themselves, co for ourselves, cn for none and cb for both.
" See: https://github.com/rhysd/conflict-marker.vim
Bundle 'rhysd/conflict-marker.vim'

" flake8-vim: flake8/pep8/.. checker for python code
" Commented-out 1/16/20 while working on Validated code
" Bundle 'andviro/flake8-vim'

" vim-gitgutter: shows git diff in the gutter (what lines have been changed); stages/undoes hunks
" [c ]c ==> prev/next hunk
" <leader>hp ==> preview the changes for the hunk the cursor is on
" <leader>hs ==> stage the hunk that the cursor is on
" <leader>hu ==> undo the hunk that the cursor is on
" :GitGutterDisable ==> disable vim-gitgutter
Bundle 'airblade/vim-gitgutter'
" Enable highlighting of lines that are modified by git:
let g:gitgutter_highlight_lines = 1

" vim-auto-save: autosave file every n seconds; see https://github.com/vim-scripts/vim-auto-save
Bundle 'vim-scripts/vim-auto-save'
" let g:autosave_time=20  " autosave file every this many seconds (vim-auto-save plugin)
" let g:auto_save = 1    " enable AutoSave on Vim startup (vim-auto-save plugin)

" vim-unimpaired -- helpful mappings, like [l ]l for going to next/prev location for syntastic flake8 errors
" Note that vim-unimpaired remaps >> (that I use for indentation)
Bundle 'tpope/vim-unimpaired'

" vim-AnsiEsc -- show ANSI terminal escape color codes in color (e.g., redirected terminal output that has color codes)
" To use it, toggle it on with:
" :AnsiEsc
" (do it again to toggle it off)
Bundle 'jbnicolai/vim-AnsiEsc'

" vim-jsx -- React jsx syntax and highlighting
Bundle 'mxw/vim-jsx'

" ale: async code linting/prettifying (recommended by Bradley Bossard)
Bundle 'w0rp/ale'

" apiblueprint => syntax highlighting for API Blueprint files
Bundle 'kylef/apiblueprint.vim'

" csv.vim: for viewing/editing CSV files (installed 6/12/18)
" https://github.com/chrisbra/csv.vim
Bundle 'chrisbra/csv.vim'

" vim-dirdiff (DirDiff): for doing recursive vimdiff's 
"  :DirDiff dir1 dir2
"  :help dirdiff
Bundle 'will133/vim-dirdiff'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ================================================================================

" :ALEDisable -  disable for the current file
" ale settings from Matt McLaughlin's .vimrc:  https://github.com/mattmcla/vim-config/blob/ec5e8f99112631849b31a3b8f83e0a3b11767cdb/.vimrc
let g:ale_linters = {
\   'javascript': ['eslint'],
\ }
let g:ale_javascript_eslint_executable = 'eslint'
" use_global = 0 is required so that it uses the local eslint instead of a globally-installed eslint
let g:ale_javascript_eslint_use_global = 0
" ale_fixers -- for :ALEFix command to fix eslint/prettier errors/warnings
" To fix warnings: :ALEFix
let g:ale_fixers = ['eslint', 'prettier']

filetype plugin indent on     " required!
" nnoremap <leader>y :execute '!PYTHONWARNINGS="d" TRAPIT_ENV=test nosetests -s %'<cr>

" The following setting tells ctrlp to just use the current working directory as the ancestor
" see http://kien.github.io/ctrlp.vim/
let g:ctrlp_working_path_mode = ''
let g:ctrlp_follow_symlinks = 1  " 1 - follow but ignore looped internal symlinks to avoid duplicates.
" This from John, to only search idealist directory:
" let g:ctrlp_cmd = 'CtrlP idealist'

" Note: I installed shellcheck (for sh/bash linting) via "brew install shellcheck" but I don't know how it's getting used by vim
" https://github.com/koalaman/shellcheck says to use it via ALE or Syntastic so maybe ALE automatically sees it and uses it

" unmap some commands that plugin's mapped
" > -- from unimpaired
" The following doesn't work.  I haven't yet figured out how to do this.  It gives:
" Error detected while processing /Users/robb/.vimrc:
"    line  230:
"    E31: No such mapping
" But it doesn't seem to be affecting me now.  Can do ":unmap >" at the vim command-line.
" unmap >
