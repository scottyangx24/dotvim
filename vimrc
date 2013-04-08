
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" Disable compatibility with vi.
set nocompatible


" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on


" Enable syntax highlighting
set t_Co=256
colorscheme molokai
syntax on


" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"---------------------------------------------------------------------------

" Set 7 lines to the curors - when moving vertical..
set so=7


" Display line number in front of each line in the left margin.
set number


" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler


" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
set wildmenu


" Make command line two lines high
set ch=2


" set visual bell -- i hate that damned beeping
set vb

" show tailing
"set listchars=trail:·
"set list
set listchars=trail:·,tab:▸\ ,eol:¬

" Allow backspacing over indent, eol, and the start of an insert
"set backspace=2
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden


" Make the 'cw' and like commands put a $ at the end instead of just
" deleting the text and replacing it
set cpoptions=cesB$

" set ctrlp path
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Always display the status line, even if only one window is displayed
" Custom status line display
set laststatus=2
" Format the statusline
"set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]
hi statusline term=NONE cterm=NONE ctermfg=white ctermbg=black


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction



" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Display commands in the bottom right corner as they are typed.
set showcmd

" Show the current mode
set showmode

" Show briefly matching bracket when closing it.
set showmatch

" Keep some stuff in the history
set history=100

" Number of spaces used for indenting.
" Number of spaces to insert for a tab.
" Insert spaces when press a tab.
" Use "ctrl-v, tab" in insert mode to insert a real tab.
set shiftwidth=4
set tabstop=4
set expandtab


" Enable specific indenting
set autoindent
set smartindent


" Enable use of the mouse for all modes
set mouse=a


" Look in the current directory for tags, if not found, go up the tree.
set tags=./tags;/


" set searching highlighting
set hlsearch


" set the search scan to wrap lines
set wrapscan

" set the clipboard
set clipboard=unnamed

" option for clang complete
let g:clang_user_options='|| exit 0'

"use ack.vim
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" options for CtrlP
let g:ctrlp_regexp = 1
let g:ctrlp_max_height = 10
let g:ctrlp_working_path_mode = ''
let g:ctrlp_user_command = 'find %s -type f 
            \  -iname "*.php" 
            \  -o -iname "*.phtml"     
            \  -o -iname "*.html"     
            \  -o -iname "*.css"     
            \  -o -iname "*.js"     
            \  -o -iname "*.rb"     
            \  -o -iname "*.sql"     
            \  -o -iname "*.py"     
            \  -o -iname "*.h"     
            \  -o -iname "*.c"     
            \  -o -iname "*.hpp"     
            \  -o -iname "*.java"     
            \  -o -iname "*.cpp"'     

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
" In visual mode when you press <leader>F to search for the current selection in many files.
vnoremap <silent> <leader>F :call VisualSearch('gv')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack! -iw -nobinary \"" . l:pattern . "\" <CR>")
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" if in diff mode (vimdiff) use the peaksea color scheme
if &diff
  set t_Co=256
  set background=dark
  colorscheme peaksea
endif

" set matching bracket to different color
hi MatchParen cterm=bold ctermbg=22 ctermfg=none

"""""""""""""""""""""""""""""
" mapping stuff
"""""""""""""""""""""""""""""
" disable arrow key in Normal/Insert Mode
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"nnoremap j gj
"nnoremap k gk

" often times I hit Q instead of q when quit vim
" this should fix the issue.
command! -bang Q q<bang>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>
autocmd! bufwritepost .vimrc source ~/.vimrc

" Yank from vim to clipboard.
map <leader>y "+y
map <leader>Y "+yy

" Paste from clipboard.
map <leader>p "+p
map <leader>P "+P

" show the registers from things cut/yanked
nmap <leader>r :registers<CR>

" map the various registers to a leader shortcut for pasting from them
nmap <leader>0 "0p
nmap <leader>1 "1p
nmap <leader>2 "2p
nmap <leader>3 "3p
nmap <leader>4 "4p
nmap <leader>5 "5p
nmap <leader>6 "6p
nmap <leader>7 "7p
nmap <leader>8 "8p
nmap <leader>9 "9p

" shortcut to toggle spelling
nmap <leader>s :setlocal spell! spelllang=en_us<CR>

" shortcuts to open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

map <leader>f :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>
map <leader>m :CtrlPMRU<cr>

" switch between current buffer and the previous one.
nnoremap <leader><leader> <c-^>

" maping Ctrl-S to Fast saving
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Windows related mapping
" Move the cursor to the window left of the current one
noremap <silent> <c-h> :wincmd h<cr>

" Move the cursor to the window below the current one
noremap <silent> <c-j> :wincmd j<cr>

" Move the cursor to the window above the current one
noremap <silent> <c-k> :wincmd k<cr>

" Move the cursor to the window right of the current one
noremap <silent> <c-l> :wincmd l<cr>

"-----------------------------------------------------------------------------
" tabs related mapping
"-----------------------------------------------------------------------------
map <silent> <F1> :tabprevious<CR>
imap <silent> <F1> <Esc>:tabprevious<CR>

map <silent> <F2> :tabnext<CR>
imap <silent> <F2> <Esc> :tabnext<CR>

map <silent> <F3> :tabclose<CR>

map <silent> <F4> :tabrewind<CR>
imap <silent> <F4> <Esc> :tabrewind<CR>


"-----------------------------------------------------------------------------
"" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
"" Toggle the NERD Tree on an off with F5
nmap <F5> :NERDTreeFind<CR>

" Close the NERD Tree with Shift-F5
nmap <S-F5> :NERDTreeClose<CR>

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                     \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                     \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                     \ '\.intermediate\.manifest$', '^mt.dep$' ]


"-----------------------------------------------------------------------------
"" Taglist Plugin Settings
"-----------------------------------------------------------------------------
nnoremap <silent> <F6> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1

"-----------------------------------------------------------------------------
" Pressing F8 to toggle paste mode
"-----------------------------------------------------------------------------
nmap <silent> <F8> :set invpaste<CR>:set paste?<CR>


"-----------------------------------------------------------------------------
" Press F9 to toggle highlighting on/off, and show current value.
"-----------------------------------------------------------------------------
noremap <F9> :set hlsearch! hlsearch?<CR>


"-----------------------------------------------------------------------------
" mapping for ack-grep, searching for word under cursor
"-----------------------------------------------------------------------------
nnoremap <leader>F :Ack! -iw --nobinary <C-R><C-W><CR>

"-----------------------------------------------------------------------------
"Enable and disable mouse use
"-----------------------------------------------------------------------------
noremap <F12> :call ToggleMouse() <CR>
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
        set nonumber
        echo "Mouse usage disabled"
    else
        set mouse=a
        set number
        echo "Mouse usage enabled"
    endif
endfunction

"-----------------------------------------------------------------------------
"cscope setting
"-----------------------------------------------------------------------------
if has("cscope")

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    "set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    "set csto=0

    " show msg when any other cscope db added
    set cscopeverbose  

    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    "nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
    "nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>  
    "nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
    "nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
    "nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
    "nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  

endif


function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

"-----------------------------------------------------------------------------
" Fix constant spelling mistakes
"-----------------------------------------------------------------------------
iab teh       the
iab Teh       The
iab taht      that
iab Taht      That
iab alos      also
iab Alos      Also
iab aslo      also
iab Aslo      Also
iab becuase   because
iab Becuase   Because
iab bianry    binary
iab Bianry    Binary
iab bianries  binaries
iab Bianries  Binaries
iab charcter  character
iab Charcter  Character
iab charcters characters
iab Charcters Characters
iab exmaple   example
iab Exmaple   Example
iab exmaples  examples
iab Exmaples  Examples
iab shoudl    should
iab Shoudl    Should
iab seperate  separate
iab Seperate  Separate
iab fone      phone
iab Fone      Phone
