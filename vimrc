" Disable compatibility with vi.
set nocompatible


" =============================================================
" Pathogen plugin management
" =============================================================
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()


" Keep some stuff in the history
set history=500

" Automatically re-read files that have changed as long as there
" are no outstanding edits in the buffer.
set autoread


" Configure mapping timeout in milliseconds (default 1000).
" Controls how long Vim waits for partially complete mapping
" before timing out and using prefix directly.
set timeoutlen=3000


" Configure keycode timeout in milliseconds (default -1).
" Controls how long Vim waits for partially complete
" keycodes (such as <ESC>OH which is the <Home> key).
" If negative, uses 'timeoutlen'.
" Note that in insert mode, there is a special-case hack in the Vim
" source that checks for <Esc> and if there are no additional characters
" immediately waiting, Vim pretends to leave insert mode immediately.
" But Vim is still waiting for 'ttimeoutlen' milliseconds for keycodes,
" so if in insert mode you press <Esc>OH in console Vim (on Linux) within
" 'ttimeoutlen' milliseconds, you'll get <Home> instead of opening a new
" line above and inserting "H".
" Note: 120 words per minute ==> 10 character per second ==> 100 ms between,
" and 50 ms ==> 240 words per minute.
" Also, Tim Pope's vim-sensible plugin uses 50 ms as a reasonable value.
set ttimeoutlen=50


" Configure special terminal keys.
runtime termsupport.vim


" Disallow octal numbers for increment/decrement (CTRL-A/CTRL-X).
set nrformats-=octal


" =============================================================
" File settings
" =============================================================

" Where file browser's directory should begin:
"   last    - same directory as last file browser
"   buffer  - directory of the related buffer
"   current - current directory (pwd)
"   {path}  - specified directory
set browsedir=buffer

" Use utf-8 encoding for all content.
set encoding=utf-8

" 'fileencodings' contains a list of possible encodings to try when reading
" a file.  When 'encoding' is a unicode value (such as utf-8), the
" value of fileencodings defaults to ucs-bom,utf-8,default,latin1.
"   ucs-bom  Treat as unicode-encoded file if and only if BOM is present
"   utf-8    Use utf-8 encoding
"   default  Value from environment LANG
"   latin1   8-bit encoding typical of DOS
" Setting this value explicitly, though to the default value.
set fileencodings=ucs-bom,utf-8,default,latin1

" Set filetype stuff to on
filetype plugin indent on


" =============================================================
" Display settings
" =============================================================

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Display line number in front of each line in the left margin.
set number

" set visual bell -- i hate that damned beeping
set visualbell

" Make command line two lines high
set cmdheight=2

" Display commands in the bottom right corner as they are typed.
set showcmd

" Enable syntax highlighting
set t_Co=256
colorscheme molokai
syntax on


" -------------------------------------------------------------
" Setup wrapping for long lines
" -------------------------------------------------------------

" Enable wrapping of long lines.
set wrap

" set the search scan to wrap lines
set wrapscan

" Use the prompt ">   " for wrapped lines.
let &showbreak="    "

" Break lines at reasonable places instead of mid-word.
set linebreak

" The 'breakat' variable determines good places to break.
" Defaults to line below:
" set breakat=\ \^I!@*-+;:,./?

" How far to scroll sideways when wrapping is off (:set nowrap).
" When zero (the default), will scroll to the middle of the screen.
" May use a small non-zero number for fast terminals.
set sidescroll=0

" Enable 'list' mode (:set list) to see non-visibles a la "reveal codes"
" in the old Word Perfect.  In list mode, 'listchars' indicates
" what to show.  Defaults to "eol:$", but has lots of features
" (see :help 'listchars).
" The "trail" setting means trailing whitespace.
" The feature is too disconcerting to leave on, but pre-configure
" listchars so :set list will do the right thing.
"set list
set listchars=trail:·,nbsp:·,extends:>,precedes:<,tab:▸\ ,eol:¬



" =============================================================
" Behavior setup
" =============================================================

" Allow backspacing over indent, eol, and the start of an insert
set backspace=eol,start,indent


" Use Visual mode and avoid "Select" mode.
set selectmode=

" Don't move to start-of-line on page up/down, H, M, L, gg, G, etc.
set nostartofline


" 'inclusive' indicates to include the last character in a selection.
" 'exclusive' excludes the final character in a selection.
set selection=inclusive

" Allow left/right movement keys to "wrap" to the previous/next line.
" b - backspace key
" s - space key
" h - "h" (not recommended)
" l - "l" (not recommended)
" ~ - "~"
" < - left arrow  (normal and visual modes)
" > - right arrow (normal and visual modes)
" [ - left arrow  (insert and replace modes)
" ] - right arrow (insert and replace modes)
set whichwrap=b,s,<,>,[,]

" Setup command-line completion (inside of Vim's ':' command line).
" Controlled by two options, 'wildmode' and 'wildmenu'.
" `wildmode=full` completes the full word
" `wildmode=longest` completes the longest unambiguous substring
" `wildmode=list` lists all matches when ambiguous
" When more than one mode is given, tries first mode on first keypress,
" and subsequent modes thereafter.
" `wildmode=longest,list` matches longest unambiguous, then shows list
"   of matches on next keypress if match didn't grow longer.
" If wildmenu is set, it will be used only when wildmode=full.

set wildmode=longest,list

" List of extensions to ignore when using wildcard matching.
set wildignore=*.o,*.obj,*.a,*.lib,*.so,*~,*.bak,*.swp,tags,*.opt,*.ncb
            \,*.plg,*.elf,cscope.out,*.ecc,*.exe,*.ilk
            \,export,build,_build

" Ignore some Python artifacts.
set wildignore+=*.pyc,*.egg-info

" Ignore some Linux-kernel artifacts.
set wildignore+=*.ko,*.mod.c,*.order,modules.builtin

" Ignore some java-related files.
set wildignore+=*.class,classes/**,*.jar

" -------------------------------------------------------------
" Completion
" -------------------------------------------------------------

" Complete longest unambigous match, show menu even if only one match.
" Include extra "preview" information in menu.
" menu - use a popup menu to show completions.
" menuone - use menu even when only one match.
" longest - only insert longest common text of matches.
" preview - use preview window to show extra information.
set completeopt=longest,menuone

" 'complete' controls which types of completion may be initiated by
" pressing CTRL-n and CTRL-p.
" . - Scans current buffer.
" w - Scans buffers from other windows.
" b - Scans loaded buffers in the buffer list.
" u - Scans unloaded buffers in the buffer list.
" U - Scans buffers not in the buffer list.
" k - Scans the files given with the 'dictionary' option.
" kspell - Use the active spell checking.
" k{dict} - Scan the file {dict}.
" s - Scan the files given with the 'thesaurus' option.
" s{tsr} - Scan the file {tsr}.
" i - Scan current and included files.
" d - Scan current and included files for a defined name or macro.
" ] - Tag completion.
" t - Same as "]".
" Default: .,w,b,u,t,i

set complete=.,w,b,u,t,i



" =============================================================

" Search related setup
" =============================================================

" Enable incremental searching (searching as you type).
set incsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Do not wrap around buffer when searching.
set wrapscan

" set searching highlighting
set hlsearch

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

" Setup n and N for browsing to next or previous search match with automatic
" scrolling to the center of the window.
nnoremap n      nzz
nnoremap N      Nzz



" ==============================================================
" Buffer manipulation
" =============================================================

" Allow buffers to be hidden even if they have changes.
set hidden



" =============================================================
" Paste setup
" =============================================================

" Setup a key to toggle "paste" mode (toggles between :set paste
" and :set nopaste by executing :set invpaste).
nmap <silent> <F8> :set invpaste<CR>:set paste?<CR>   

" Change default from unnamed register ('"') to the primary selection
" register ("*") for general yank and put operations. Avoid autoselect mode.
" Inspired by Tip #21.  Notice also you can append to a register and then
" assign it to the primary selection (@*) or the clipboard (@+).  E.g.:
"   :let @*=@a
set clipboard=unnamed



" =============================================================
" status line setup
" =============================================================

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



" =============================================================
" not yet grouped 
" =============================================================


" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"---------------------------------------------------------------------------

" Set 7 lines to the curors - when moving vertical..
set so=7

" Make the 'cw' and like commands put a $ at the end instead of just
" deleting the text and replacing it
set cpoptions=cesB$

" set ctrlp path
set runtimepath^=~/.vim/bundle/ctrlp.vim


" Show the current mode
set showmode

" Show briefly matching bracket when closing it.
set showmatch

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





"use ack.vim
let g:ackprg="ack-grep -H --nocolor --nogroup --column"


" if in diff mode (vimdiff) use the peaksea color scheme
if &diff
  set t_Co=256
  set background=dark
  colorscheme peaksea
endif

" set matching bracket to different color
hi MatchParen cterm=bold ctermbg=10 ctermfg=none

" =============================================================
" not yet grouped End 
" =============================================================



"""""""""""""""""""""""""""""
" mapping stuff
"""""""""""""""""""""""""""""

" Move vertically by screen lines instead of physical lines.
" Exchange meanings for physical and screen motion keys.

" When the popup menu is visible (pumvisible() is true), the up and
" down arrows should not be mapped in order to preserve the expected
" behavior when navigating the popup menu.  See :help ins-completion-menu
" for details.

" Down
nnoremap j           gj
xnoremap j           gj
nnoremap <Down>      gj
xnoremap <Down>      gj
inoremap <silent> <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-o>gj"<CR>
nnoremap gj          j
xnoremap gj          j

" Up
nnoremap k           gk
xnoremap k           gk
nnoremap <Up>        gk
xnoremap <Up>        gk
inoremap <silent> <Up>   <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-o>gk"<CR>
nnoremap gk          k
xnoremap gk          k

" Start of line
nnoremap 0           g0
xnoremap 0           g0
nnoremap g0          0
xnoremap g0          0
nnoremap ^           g^
xnoremap ^           g^
nnoremap g^          ^
xnoremap g^          ^

" End of line
nnoremap $           g$
xnoremap $           g$
nnoremap g$          $
xnoremap g$          $


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

" =============================================================
" Tags
" =============================================================

" The semicolon gives permission to search up toward the root
" directory.  When followed by a path, the upward search terminates
" at this "stop directory"; otherwise, the search terminates at the root.
" Relative paths starting with "./" begin at Vim's current
" working directory or the directory of the currently open file.
" See :help file-searching for more details.
"
" Additional directories may be added, e.g.:
" set tags+=/usr/local/share/ctags/qt4
"
" Start at working directory or directory of currently open file
" and search upward, stopping at $HOME.  Secondly, search for a
" tags file upward from the current working directory, but stop
" at $HOME.
set tags=./tags;$HOME,tags;$HOME

" Use the following settings in a .ctags file.  With the
" --extra=+f, filenames are tags, too, so the following
" mappings will work when a file isn't in the path.
nnoremap <expr> gf empty(taglist(expand('<cfile>'))) ?
            \ "gf" : ":ta <C-r><C-f><CR>"
nnoremap <expr> <C-w>f empty(taglist(expand('<cfile>'))) ?
            \ "\<C-w>f" : ":stj <C-r><C-f><CR>"



" =============================================================
" Cscope setting
" =============================================================
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


" =============================================================
" Plugins
" =============================================================

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
"" RainbowParentheses Plugin Settings
"-----------------------------------------------------------------------------
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16

let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces



"-----------------------------------------------------------------------------
"" ctrlP Plugin Settings
"-----------------------------------------------------------------------------
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

