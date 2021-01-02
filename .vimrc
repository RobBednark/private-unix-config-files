" ================================================================================
" #Start General settings
" ================================================================================
set ai   " autoindent
set cc=80 " colorcolumn -- show a column of red at character position 80
" set cursorline  " underline (highlight) the line that the cursor is on
" set cursorcolumn  " highlight the current column that the cursor is on 
set expandtab " expand tabs to spaces instead of tab characters
" exrc => read from .vimrc in current directory after reading primary .vimrc
set exrc
set fileformat=unix
set foldopen-=search  " when searching, don't open folds; constrain search to unfolded text
set hls  " highlightsearch
set ic   " ignorecase
set incsearch " incremental search
set modeline  " look for /* vim: */ modeline settings at the beginning of a file
set modelines=5  " Look for /* vim: ...: */ settings in the first/last this many lines of the file; if 0, modelines is disabled
set ws " nowrapscan - don't wrap around to beginning after search hits end-of-file
" set nows " nowrapscan - don't wrap around to beginning after search hits end-of-file
set scrolloff=5  " when searching, keep the next match 5 lines from the bottom
" secure => disallow risky commands from local .vimrc/.exrc files  (:help secure)
set secure
set shell=/bin/bash   " I can't get zsh -i so use the .zshrc file and use my PATH (:!which python /usr/bin/python instead of /usr/local/bin/python), but bash does use them.
set sw=4 " shiftwidth
set textwidth=0
set ts=4 " tabstop

syntax on " syntax highlighting
filetype plugin indent on

"set shell=/bin/bash
"set shell=/bin/bash\ -i   " Someone recommended this to get my .bashrc, but it wasn't necessary, and introduced it's own problems.  [see vvim]
" set shell=/bin/bash\ --login   " Cause bash to read .bashrc so I have my aliases and functions available.  This worked briefly for me, but now it doesn't anymore.  10.5.20
"set shell=/usr/local/bin/zsh
"set shell=~/.zsh.from.vim.with.zshrc.zsh\ -i
"set shellcmdflag=-i  " need -i (interactive) option to bash so that it reads in the .bashrc file and sets my PATH to use the right Python; however, not that this creates a new shell, with vim in the background, so you need to 'fg' to go back into vim


" ================================================================================
" #Start autocmd's
" ================================================================================
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

" ================================================================================
" #Start #abbreviations
" ================================================================================
iab _bo □
iab _bu •
iab _ch ✅
iab _he ❤️
iab _la 😂
iab _la2 🤣
iab _sep ------------------------------
iab _sm 😀
iab _sm2 😁
iab _st ⭐️
iab _up ☝️
iab _wi 😉
" ================================================================================
" #Start mappings
" ================================================================================
" create a macros for inserting traces for pdb and for nose.
" To use, in command mode, type <backslash> followed by "b" or "n"
" \a ==> :ALEfix  (fix javascript prettier/eslint errors using the ALE plugin)
" \b ==> :browse old  (browse old files opened)  (equivalent to :ol[dfiles])
" \c ==> :w :!git commit -am'incremental commit'; git push
" \C ==> :!python -m py_compile %
" \d ==> (diff)  :r!git diff --cached
" \D ==> (Down) -- fold DOWN from the current cursor position to G (end of file)
" \e ==> open the file in Chrome
" \f ==> (f)iles -- open MRU for most-recently opened files
" \F ==> (F)old -- fold everything up from the current line (#start) and down from the next #end, then put the cursor on top 2 lines down
" \g ==> :GitGutterDisable
" \h ==> highlight the text inside the matching brace/parenthesis for 3 seconds
" \I ==> ("lIne") add a equals line: ======================
" \l ==> "subLime Text": open current file in Sublime
" \L ==> ("Line") add a dashed line: -----------------------------
" \m ==> open Sublime Merge on the directory of the current file
" \M ==> open Sublime Text on the current file
" \n ==> add python nose set_trace()
" \p ==> add python import pdb; pdb.set_trace()
" \r ==> :TabooRename  (rename the current tab)
" \s ==> :tab split  (create a new tab)
" \u ==> add pudb set_trace()
" \U ==> ("Up") -- fold UP from the current cursor position to line 1 (top of file)
map <silent> <leader>a :ALEFix<CR>
map <silent> <leader>b :browse old<CR>
map <silent> <leader>c :w<CR>:!(set -x; cd $(dirname %); git commit -am'incremental commit'; git push; git status %) & <CR>
map <silent> <leader>C :w<esc>:!python3 -m py_compile %<esc>
map <silent> <leader>d :r!git diff --cached<esc>
map <silent> <leader>D zfG
map <silent> <leader>e :!open -a google\ chrome % <esc>
map <silent> <leader>f :MRU<CR>
map <silent> <leader>F kkzf1G/^#end<CR>jjzfG1Gjjj
map <silent> <leader>g :GitGutterDisable <esc>
map <leader>h  m[%v%:sleep 3000m<CR>`[  
map <silent> <leader>l :call AddSeparatorLineEquals()<esc>
map <silent> <leader>L :call AddSeparatorLineDashed()<esc>
map <silent> <leader>m :!(set -x; open -a Sublime\ Merge\ 2 $(dirname %)) <esc>
map <silent> <leader>M :!open -a sublime\ text % <esc>
map <silent> <leader>n oimport nose; nose.tools.set_trace()<esc>
map <silent> <leader>p oimport pdb; pdb.set_trace()<esc>
map <silent> <leader>r :TabooRename 
map <silent> <leader>s :tab split<esc>
map <silent> <leader>S :call AddSection()<esc>
map <silent> <leader>u oimport pudb; pudb.set_trace()<esc>
map <silent> <leader>U zf1G
" from John de la Garza 10/26/15.  I think what this does is allow a different leader, e.g., "," instead of "\"
" let mapleader="," noremap <Leader>n :bn<Enter> noremap <Leader>d oimport pdb;pdb.set_trace() 

" Disable automatically-adding comment prefix on the next line:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" ofu is the "omnicomplete function".  Set it to 
set ofu=syntaxcomplete#Complete

" ================================================================================
" #Start #Functions
" ================================================================================
function! AddSeparatorLineDashed()
  " Add this lines:
  " ------------------------------
  normal! o30a-
endfunction

function! AddSeparatorLineEquals()
  " Add this lines:
  " ------------------------------
  normal! o80a=
endfunction

function! AddSection()
  " Add these lines:
  " ================================================================================
  " #Start
  " ================================================================================
  " ================================================================================
  " ================================================================================
  normal! o80a=
  normal! o#Start 
  normal! o80a=
  normal! o80a=
  normal! o80a=
endfunction

" SearchMultiLine()
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

" ListHelpSubjects()
" To run it:
"   :call ListHelpSubjects()
" https://vi.stackexchange.com/questions/27439/how-to-list-all-help-subjects-and-help-files/27447#27447
function! ListHelpSubjects()
    new
    for f in globpath(&runtimepath, '**/doc/tags', 0, 1)
        call append('$', readfile(f))
    endfor
endfunction

" LoadHelpFiles (called by ListHelpFiles())
" https://vi.stackexchange.com/questions/27439/how-to-list-all-help-subjects-and-help-files/27447#27447
function! LoadHelpFileNames(filename)
    let docpath = substitute(a:filename, '\\', '/', 'g')
    let docpath = substitute(docpath, '/tags$', '/', '')

    let tags = readfile(a:filename)

    return uniq(sort(map(tags, { idx, val -> substitute(val, '.*\t\(.*\)\t.*', docpath . '\1', '') })))
endfunction

" ListHelpFileNames()
" To run it:
"   :call ListHelpFiles()
" https://vi.stackexchange.com/questions/27439/how-to-list-all-help-subjects-and-help-files/27447#27447
function! ListHelpFileNames()
    new
    for f in globpath(&runtimepath, '**/doc/tags', 0, 1)
        call append('$', LoadHelpFileNames(f))
    endfor
endfunction

" Set the title of the iTerm2 terminal to the currently-open file
function! SetTerminalTitle()
    let titleString = expand('%:t')
    if len(titleString) > 0
        let &titlestring = expand('%:t')
        " this is the format iTerm2 expects when setting the window title
        let args = "\033];".&titlestring."\007"
        let cmd = 'silent !echo -e "'.args.'"'
        execute cmd
        redraw!
    endif
endfunction

" Set the iTerm2 terminal title to the filename being opened
autocmd BufEnter * call SetTerminalTitle()

syntax on
filetype plugin indent on

" wildignore is a setting for the Command-T plugin.  It indicates which files to ignore.
:set wildignore+=*.pyc,.git,node_modules

" ================================================================================
" #Start Vundle setup section
" ================================================================================
" 7.31.20, 8/5/12 
" https://github.com/VundleVim/Vundle.vim
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" :PluginUpdate     - update plugins to latest versions
" see :h vundle for more details or wiki for FAQ

" I installed the vundle package manager to easily manage vim packages/plugins.  -Rob Bednark, 8/5/12
set nocompatible               " be iMproved, required by Vundle
filetype off                   " required by Vundle!  

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim  " required by Vundle
call vundle#begin()

" let Vundle manage Vundle; required by Vundle
Plugin 'VundleVim/Vundle.vim'

" ================================================================================
" #Start Bundles
" ================================================================================
" vim-rainbow-parenthesis -- give different colors to each pair of parentheses/brackets/html-tags/...
" https://github.com/luochen1990/rainbow
Bundle 'luochen1990/rainbow'
" Note that setting rainbow_active to something is required, otherwise the Rainbow* commands aren't present
let g:rainbow_active = 0 "set to 0 if you want to enable it later via :RainbowToggle


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
" https://github.com/dhruvasagar/vim-table-mode
"   disabled by default;
"   :help table-mode
"   :%Tableize/<tab>  -- convert all tables in the entire file (%) using tab as the delimiter
"   :TableModeEnable -- enable table mode
"   :TableModeDisable -- disable table mode
"   :TableModeToggle -- toggle table mode
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
" 8.20.20 -- I've been seeing issues with ctrlp, so I tried a specific <commit>, but doing the "@<commit>" didn't work.
" I also tried 'kien/ctrlp.vim' but that didn't fix the issue.
" Issue: ctrlp the first time works, but then when I do it again, it searches a different directory
Bundle 'ctrlpvim/ctrlp.vim'
" Bundle 'kien/ctrlp.vim'
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
" [c ]c ==> prev/next hunk (gitgutter)
" <leader>hp ==> preview the changes for the hunk the cursor is on (gitgutter)
" <leader>hs ==> stage the hunk that the cursor is on (gitgutter)
" <leader>hu ==> undo the hunk that the cursor is on (gitgutter)
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

" ale: Async Line Engine - code linting/prettifying
" Need to install/configure individual linters.  I've configured:
"  Tidy -- html linter  (brew install tidy-html5)
" :AleInfo  -- show configuration info
" Bundle 'w0rp/ale'  (this is equivalent and points to the following:)
Bundle 'dense-analysis/ale'

" apiblueprint => syntax highlighting for API Blueprint files
Bundle 'kylef/apiblueprint.vim'

" csv.vim: for viewing/editing CSV files (installed 6/12/18)
" https://github.com/chrisbra/csv.vim
Bundle 'chrisbra/csv.vim'

" vim-dirdiff (DirDiff): for doing recursive vimdiff's 
"  :DirDiff dir1 dir2
"  :help dirdiff
Bundle 'will133/vim-dirdiff'

" vim-emoji -- emoji picker to choose emoji
" Bundle 'junegunn/vim-emoji'

" vim-emoji-complete -- emoji picker
" Bundle 'kyuhi/vim-emoji-complete'

" YouCompleteMe -- used for code completions; used with emoji-snippets
" https://github.com/ycm-core/YouCompleteMe
" Commented-out because there is more configuration I need to do, and I'm not sure if I really want it.
" Bundle 'ycm-core/YouCompleteMe'

" emoji picker / completions
Bundle 'FuDesign2008/emoji-snippets.vim'

" MRU - "Most-recently used" -- recently opened files in Vim
" https://github.com/yegappan/mru/wiki/User-Manual
Bundle 'https://github.com/yegappan/mru'

" vim-oldfiles -- quickly go to a recently-opened file:
"  :Oldfiles
"  :Oldfiles /pattern/
" Bundle 'https://github.com/gpanders/vim-oldfiles'
" ================================================================================
" #End   Bundles
" ================================================================================

" ================================================================================
" #Start Bundle post-commands
" ================================================================================
" All Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ================================================================================
" #Start ALE configuration
" ================================================================================

" :ALEDisable -  disable for the current file
" ale settings from Matt McLaughlin's .vimrc:  https://github.com/mattmcla/vim-config/blob/ec5e8f99112631849b31a3b8f83e0a3b11767cdb/.vimrc
let g:ale_linters = {
\   'html': ['/usr/local/bin/tidy'],
\ }
" commented-out eslint because I'm not using it now:
" \   'javascript': ['eslint'],
" note: need to specify the full path to tidy, because on macOS, need to use the /usr/local/bin brew-installed tidy, not the old default /usr/bin/tidy
let g:ale_html_tidy_executable = '/usr/local/bin/tidy'
" let g:ale_javascript_eslint_executable = 'eslint'
" use_global = 0 is required so that it uses the local eslint instead of a globally-installed eslint
" let g:ale_javascript_eslint_use_global = 0
" ale_fixers -- for :ALEFix command to fix eslint/prettier errors/warnings
" To fix warnings: :ALEFix
" let g:ale_fixers = ['/usr/local/bin/tidy', 'eslint', 'prettier']
let g:ale_fixers = ['/usr/local/bin/tidy']

filetype plugin indent on     " required!
" nnoremap <leader>y :execute '!PYTHONWARNINGS="d" TRAPIT_ENV=test nosetests -s %'<cr>

" ================================================================================
" #Start ctrlp configuration
" ================================================================================
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
" ================================================================================
" #reference for grep'ing
" ================================================================================
" :ab  ==> list all abbreviations
" :bro ol  (:browse old) ==> browse/view/list recently-opened buffers
" :call myFunc  ==> call the myFunc() function
" :help function ==> list all built-in functions
" :redir @a    :map     :redir END     ==> redirect output of ":map" to the @a buffer
" :source myfile  ==> source/execute/run a file of vim commands/settings
" :tabnew myfile  ==> open file in a new tab
" :verbose map \m   => show mapping and where it was set (e.g., what line in .vimrc file)
" "*y$  => yank/copy everything from the cursor to the end-of-the-line to the * clipboard register
" zD  => recursively delete all folds on the line under the cursor
" ================================================================================
" The End.
" ================================================================================
