" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" ENVIRONMENT
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"let $LANG="zh_TW.UTF-8"
""set langmenu=en_US.UTF-8

let $LANG="en_US.UTF-8"
set langmenu=en_US.UTF-8
set encoding=utf8

"reload menu with UTF-8 encoding
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

let g:OdinVimDir    = ''

let mapleader = "/"

try
  if has('win32') || has('win64') || 1
    behave mswin
"    let g:OdinRCFolder  =$VIMRUNTIME . '\..\OdinVimRC\'
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    source $VIMRUNTIME/../OdinVimRC/OdinWin.vim
    let g:OdinVimDir    = $VIMRUNTIME . '/../'
    set undodir=C:\Windows\Temp
  elseif has('unix')
    let g:OdinVimDir    = '~/OdinVim/'
    set undodir=~/.vim_runtime/undodir
    exe 'source ' . g:OdinVimDir . 'OdinVimRC/OdinLinux.vim'
  else
    set undodir=~/.vim_runtime/undodir
  endif
  set undofile
catch
endtry


" _vimrc file must be served for Windows
behave mswin
"    let g:OdinRCFolder  =$VIMRUNTIME . '\..\OdinVimRC\'
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
source $VIMRUNTIME/../OdinVimRC/OdinWin.vim
let g:OdinVimDir    = $VIMRUNTIME . '/../'
set undodir=C:\Windows\Temp

"source $VIMRUNTIME/../OdinVimRC/OdinPrj.vim
exe 'source ' . g:OdinVimDir . 'OdinVimRC/OdinPrj.vim'
"exe 'source ' . $VIMRUNTIME . '/../OdinVimRC/OdinPrj.vim'

" ---------------------------------------------------------------
" ENVIRONMENT
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" BASIC SETTING 
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set       encoding      =utf-8
setglobal fileencoding  =big5
set       fileencoding  =big-5
set       termencoding  =big-5
setglobal fileencodings =utf-8,big5,cp950,gbk.latin1
syntax    on
set       nocompatible
" Enable the mouse for all modes 
set       mouse         =a 
" Hide mouse while typing text 
"set       mousehide 
set       ai
set       shiftwidth=2
set       tabstop=2
set       softtabstop=2
set       expandtab
set       ruler
set       backspace=2
set       ic
set       ru
set       nu
set       nowrap
set       cmdheight=2
set       hlsearch
set       incsearch
set       smartindent
set       confirm
set       history=400
set       cursorline
set       showmatch		" Cursor shows matching ) and }
set       showmode		" Show current mode
set       clipboard=unnamed	" yank to the system register (*) by default
"set cscopequickfix=c-,d-,e-,g-,i-,s-,t-
"set cscopequickfix=s-,c-,d-,i-,t-,e-
"set csverb
"set cscopetag
"set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-
hi      cursorLine term=none cterm=none ctermbg=7
autocmd VimEnter *    hi cursorLine term=none cterm=none ctermbg=Blue
"autocmd InsertEnter * hi cursorLine term=none cterm=none ctermbg=Red
"autocmd InsertEnter * hi cursorLine term=none cterm=none ctermbg=Yellow
"autocmd InsertLeave * hi cursorLine term=none cterm=none ctermbg=Blue

"au InsertEnter * set nocul
"au InsertLeave * set cul

function! InsertEnterFun()
  set nocul
  hi cursorLine term=none cterm=none ctermbg=yellow
endfunction

function! InsertLeaveFun()
  set cul
  hi cursorLine term=none cterm=none ctermbg=blue
endfunction

au InsertEnter * call InsertEnterFun()
au InsertLeave * call InsertLeaveFun()

set       laststatus    =2
set       statusline    =%4*%<\%m%<[%f\%r%h%w]\ [%{&ff},%{&fileencoding},%Y]%=\[Position=%l,%v,%p%%]
set       helplang      =en
set       columns       =200
"set       lines         =80
set       lines         =120

set       splitright

"let MRU_Max_Entries = 400

"set       guifont       =mingliu:h12
"set       guifont       =Monospace\ 10,文鼎PL新宋\ 10
"set       guifont       =Monospace\ 8,文鼎PL新宋\ 8
"set       guifont       =Monospace\ 6,文鼎PL新宋\ 6
set guifont=Consolas:h10:cANSI

filetype on
filetype plugin on
" ---------------------------------------------------------------
" SETTING 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" COLORSCHEME
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"colorscheme torte
"colorscheme desertEx   ""
colorscheme desert
"colorscheme google
"colorscheme graywh
"colorscheme grayorange
"colorscheme evening
"colorscheme ir_black
"colorscheme elflord
" ---------------------------------------------------------------
" COLORSCHEME 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" FAST KEY
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
nmap <F2> <ESC>:WMToggle<CR>
"nmap <F3> <ESC>:FirstExplorerWindow<CR>
"nmap <F4> <ESC>:BottomExplorerWindow<CR>
"map <F5> <ESC>zn<CR>
"map <F6> <ESC>za<CR>
map <F3> <ESC>:tabprev<CR>
map <F4> <ESC>:tabnext<CR>
"map <F12>9 <ESC>:tabprev<CR>
"map <F12>0 <ESC>:tabnext<CR>
"map <F12>n <ESC>:tabnew<CR>


fu! ListFastKey()
  echo  "<F1>+k          List Functions Of KEY#"
  echo  "<F2>            WMToggle"
  echo  "<F3>            Prev Tab"
  echo  "<F4>            Next Tab"
  echo  "<F5>            View / Folding"
  echo  "<F6>            Fuzzy"
  echo  "<F7>            Project"
  echo  "<F8>            Buffer/TempFolder"
  echo  "<F9>            Search"
  echo  "<F10>           ctag/cscope"
  echo  "<F11>           Split"
  echo  "<F12>           Tab"
  echo  "Enjoy~~"
endf 

map <F1>l <ESC>:call ListFastKey()<CR>
map <F1>k <ESC>:noremap 
" ---------------------------------------------------------------
" FAST KEY 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" DIFF 
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cnoreabbrev dff vert diffsplit 
cnoreabbrev DFF vert diffsplit

hi DiffAdd term=bold ctermbg=DarkBlue guibg=DarkBlue
hi DiffChange term=bold ctermbg=DarkMagenta guibg=DarkMagenta
hi DiffDelete term=bold ctermfg=Blue ctermbg=DarkCyan gui=bold guifg=Blue guibg=DarkCyan
" ---------------------------------------------------------------
" DIFF 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" WINDOWS
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Automatically fitting a quickfix window height
" http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$")+1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

set switchbuf+=usetab,newtab

" ---------------------------------------------------------------
" WINDOWS 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" VIEW
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
map <F5>T <ESC>zt<CR>       " Put in top
map <F5>Z <ESC>zz<CR>       " Put in immediate 
map <F5>t <ESC>zt<CR>       " Put in top
map <F5>z <ESC>zz<CR>       " Put in immediate 
" ---------------------------------------------------------------
" VIEW 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" FOLDING
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set fdm=indent
"set fdm=syntax

map <F5>O <ESC>zn<CR>
map <F5>C <ESC>za<CR>
map <F5>o <ESC>zn<CR>
map <F5>c <ESC>za<CR>

" ---------------------------------------------------------------
" FOLDING 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" TAB/SPLIT
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
map <F12>9 <ESC>:tabprev<CR>
map <F12>0 <ESC>:tabnext<CR>
map <F12>N <ESC>:tabnew<CR>
map <F12>S <ESC>:tabedit %:p<CR>
map <F11>S <ESC>:vsplit %:p<CR>
map <F12>R <ESC>:call ShiftTab(1)<CR>
map <F12>L <ESC>:call ShiftTab(0)<CR>
map <F12>n <ESC>:tabnew<CR>
map <F12>s <ESC>:tabedit %:p<CR>
map <F11>s <ESC>:vsplit %:p<CR>
map <F12>r <ESC>:call ShiftTab(1)<CR>
map <F12>l <ESC>:call ShiftTab(0)<CR>

cnoreabbrev TE tabedit
cnoreabbrev TES tabedit +/
cnoreabbrev TR tab sview
cnoreabbrev EL g/^$/d
cnoreabbrev te tabedit
cnoreabbrev tes tabedit +/
cnoreabbrev tr tab sview
cnoreabbrev el g/^$/d

cnoreabbrev VINOTE exe 'tab sview ' . g:OdinVimDir . 'vim_note.txt'
cnoreabbrev VIRC   exe 'tab sview ' . g:OdinVimDir . '_vimrc'
cnoreabbrev VICPP  exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinCPP.vim'
cnoreabbrev VILNX  exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinLinux.vim'
cnoreabbrev VIOB   exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinOnebase.vim'
cnoreabbrev VIPRJ  exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinPrj.vim'
cnoreabbrev VIWIN  exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinWin.vim'
cnoreabbrev VIV    exe 'tab sview ' . g:OdinVimDir . 'version.txt'
cnoreabbrev vinote exe 'tab sview ' . g:OdinVimDir . 'vim_note.txt'
cnoreabbrev virc   exe 'tab sview ' . g:OdinVimDir . '_vimrc'
cnoreabbrev vicpp  exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinCPP.vim'
cnoreabbrev vilnx  exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinLinux.vim'
cnoreabbrev viob   exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinOnebase.vim'
cnoreabbrev viprj  exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinPrj.vim'
cnoreabbrev viwin  exe 'tab sview ' . g:OdinVimDir . 'OdinVimRC/OdinWin.vim'
cnoreabbrev viv    exe 'tab sview ' . g:OdinVimDir . 'version.txt' 


cnoreabbrev VV     vsplit %:p
cnoreabbrev TV     tab sview %:p
cnoreabbrev vv     vsplit %:p
cnoreabbrev tv     tab sview %:p

"Shift the current tab to the left (direction == 0) or to the right (direction != 0) 
map <leader>TR :call ShiftTab(1)<CR>
map <leader>TL :call ShiftTab(0)<CR>
map <leader>TN :tabnew<CR>
map <leader>tr :call ShiftTab(1)<CR>
map <leader>tl :call ShiftTab(0)<CR>
map <leader>tn :tabnew<CR>

fu! ShiftTab(direction)
  let tabpos = tabpagenr() 
  if a:direction == 0 
    if tabpos == 1 
      execute ":tabm" . tabpagenr('$')
    else 
      execute ":tabm" . (tabpos - 2)
    endif 
  else 
    if tabpos ==tabpagenr('$') 
      execute ":tabm" . 0
    else 
      execute ":tabm" . tabpos
    endif 
  endif
  return '' 
endf 

fu! OpenTab(str)
  execute "tab sview . a:str
endf
" ---------------------------------------------------------------
" TAB/SPLIT 
" ---------------------------------------------------------------



" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" TOOLS
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
" TBD
" sync to Server
" make on server
" TBD

" ---------------------------------------------------------------
" TOOLS 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" FILE EXPLORER
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
let g:winManagerWindowLayout = 'FileExplorer|TagList'
let g:winManagerWidth = 30
let g:defaultExplorer = 0
let Tlist_Exit_OnlyWindow = 1     "exit if taglist is last window open
let Tlist_Show_One_File = 0
let Tlist_File_Fold_Auto_Clos = 1
let Tlist_Use_SingleClick = 1
let Tlist_Show_One_File = 1       " Only show tags for current buffer
" ---------------------------------------------------------------
" FILE EXPLORER 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" FILE/DIR/PATH
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cnoreabbrev cdv    exe 'cd ' . g:OdinVimDir
"cnoreabbrev cds    exe 'cd ' . g:SOURCECODE 
cnoreabbrev cds    exe 'cd ' . g:GIT_DIR 
if has('win32') || has('win64')
  cnoreabbrev cdcyg  exe 'cd ' . g:CYG_ROOT
  cnoreabbrev cdcygh exe 'cd ' . g:CYG_ROOT . '\home\oshen\'
endif
cnoreabbrev cdp   exe 'cd ' . g:PRJ_SrcCodePath

cmap cd. lcd %:p:h      " Change to current file location

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! CurrentFileDir(cmd)                       " ?
  return a:cmd . " " . expand("%:p:h") . "/"    " ?
endfunc                                         " ?

" PUT SOMETHING FROM THE COMMAND LINE TO THE BUFFER
" :PutImmediate <x> writes <x> to the buffer at the current cursor position.
" :pi <a> is an abbreviation for this.
" Sets register '"' as a side-effect.
" Examples:
"   :pi ^R^W<CR>  will insert the current file name.
"   :pi @%<CR>    will do the same
function! PutImmediate(x)
  let result = setreg('"', a:x)
  let i = col('.')
  let this_line = getline('.')
  let result = setline('.', strpart(this_line, 0, i).a:x.strftime(%m-%d).strpart(this_line, i))
endfunction
command! -nargs=1 PutImmediate call PutImmediate(<args>)
cabbr pi PutImmediate()<LEFT>

cnoreabbrev SIGT     PutImmediate("// Temp:")<LEFT><LEFT>
cnoreabbrev SIGC     PutImmediate("// Comment:")<LEFT><LEFT>
cnoreabbrev sigt     PutImmediate("// Temp:")<LEFT><LEFT>
cnoreabbrev sigc     PutImmediate("// Comment:")<LEFT><LEFT>

  " append the [TYPE] [MM]_[DD] [INPUT_SIG] such like:  
  "   case 1: // comment 05_12 enable SDM4 function
  "   case 2: // Odin_Tmp. 0512 temp F$25 report initRxOffset 
  "     get time: strftime("%y-%m-%d")
  "
" ---------------------------------------------------------------
" FILE/DIR/PATH 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Sub Name
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function! CurrSubName()                                             
    let g:subname = ""
    let g:subrecurssion = 0

    let l:firstline = getline(1)                                    " get fisrt line in current file

    if ( l:firstline =~ '#!.*perl' || l:firstline =~ '^package ' )
        call GetSubName(line("."))
    endif

    return g:subname
endfunction

function! GetSubName(line)                                          " ?
    let l:str = getline(a:line)

    if l:str =~ '^sub'
        let l:str = substitute( l:str, " *{.*", "", "" )
        let l:str = substitute( l:str, "sub *", ": ", "" )
        let g:subname = l:str
        return 1
    elseif ( l:str =~ '^}' || l:str =~ '^} *#' ) && g:subrecurssion == 1
        return -1
    elseif a:line > 2
        let g:subrecurssion = g:subrecurssion + 1
        if g:subrecurssion < 190
            call GetSubName(a:line - 1)
        else
            let g:subname = ': <too deep>'
            return -1
        endif
    else
        return -1
    endif
endfunction

"  FIND CURRENT SUB NAME
function! FindCurrentSub()
  call search('^\s*sub\>','sbe')
  let line = getline(".")
  let i = stridx(line, '{')
  if i > 0
    let line = strpart(line, 0, i)
  endif
  call setpos("'s", getpos("."))
  call setpos('.', getpos("''"))
  echo line
endfunction
" ---------------------------------------------------------------
" Sub Name 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Search 
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
nmap <c-n> :cn
nmap <c-p> :cp

" ---------------------------------------------------------------
" Search 
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Visual mode related
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>

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
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" ---------------------------------------------------------------
" Visual mode related
" ---------------------------------------------------------------



" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Buffer
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" SEARCH ACROSS BUFFERS
" Looks for a pattern in all the open buffers.
" :Bvimgrep 'pattern' puts results into the quickfix list
" :Blvimgrep 'pattern' puts results into the location list
function! BuffersVimgrep(pattern,cl)
  let str = ''
  if (a:cl == 'l')
    let str = 'l'
  endif
  let str = str.'vimgrep /'.a:pattern.'/j'
  echo str 
  for i in range(1, bufnr('$'))
    let str = str.' '.bufname(i)
  endfor
  execute str
  execute a:cl.'w'
endfunction
command! -nargs=1 Bvimgrep  call BuffersVimgrep(<args>,'c')
command! -nargs=1 Blvimgrep call BuffersVimgrep(<args>,'l')



" SHOW BUFFERS ON LAUNCH
" List all the buffers when launching Vim, but only if there is more than one.

function! ListMultipleBuffers()
  if bufexists(2)
    ls
  endif
endfunction
autocmd! VimEnter * call ListMultipleBuffers()

fun! BufInfo()
  echo "[bufnr ] ".bufnr("%")
  echo "[bufname ] ". expand("%:p")
  echo "[cwd ] " . getcwd()
  if filereadable(expand("%"))
    echo "[mtime ] " . strftime("%Y-%m-%d %H:%M %a",getftime(expand("%")))
  endif
"  echo "[size ] " . Bufsize() . " bytes"
  echo "[comment ] " . (exists('b:commentSymbol') ? b:commentSymbol : "undefined")
  echo "[filetype ] " . &ft
  echo "[tab ] " . &ts . " (" . (&et ? "" : "no") . "expandtab)"
  echo "[keywordprg] " . &keywordprg
  echo "[makeprg ] " . &makeprg
  echo "[Buffer local mappings]"
  nmap <buffer>
endf
"com! BufInfo :cal BufInfo()<CR>

function! DeleteHiddenBuffers()
  let bufidx = 1
  while bufidx <= bufnr("$")
    if bufloaded(bufidx)
      execute 'bd' bufidx
    endif
    let bufidx = bufidx + 1
  endw
endfunction

com! Bi :cal BufInfo()<CR>
com! Bd :cal DeleteHiddenBuffers()<CR>

map <F8>d <ESC>:call DeleteHiddenBuffers()<CR>
map <F8>i <ESC>:call BufInfo()<CR>
map <F8>s <ESC>:call BuffersVimgrep(expand("<cword>"),'c')<CR>
map <F8>l <ESC>:call BuffersVimgrep(expand("<cword>"),'l')<CR>
map <F8>f <ESC>:call BuffersVimgrep(expand(""),'c')<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

map <F8>D <ESC>:call DeleteHiddenBuffers()<CR>
map <F8>I <ESC>:call BufInfo()<CR>
map <F8>S <ESC>:call BuffersVimgrep(expand("<cword>"),'c')<CR>
map <F8>L <ESC>:call BuffersVimgrep(expand("<cword>"),'l')<CR>
map <F8>F <ESC>:call BuffersVimgrep(expand(""),'c')<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
" ---------------------------------------------------------------
" Buffer
" ---------------------------------------------------------------


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" SCROLL
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cnoreabbrev sb      set scrollbind
cnoreabbrev sbn     set noscrollbind

" ---------------------------------------------------------------
" SCROLL
" ---------------------------------------------------------------




" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" SPACE CHECK
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"====================================
"  Removing trivial white space
"  ***** START *****
"====================================
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
 onebase=onebase {
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <S-F11>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>
vnoremap <S-F12>   :TrimSpaces<CR>
" ---------------------------------------------------------------
" SPACE CHECK
" ---------------------------------------------------------------






" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" LILICOCO
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

let g:inpfile = ""
fu! InputFILE()
  let g:inpfile = input( "Open file: " )
  echo g:inpfile
  call OpenTab(g:inpfile)
endf


nmap <leader>inf      :call InputFILE()<CR>

map <leader>g :vimgrep //j * <BAR> cw<left><left><left><left><left><left><left><left><left>
map <leader>G :vimgrep //j **/* <BAR> cw<left><left><left><left><left><left><left><left><left><left><left><left>

map <F9>g :execute 'vimgrep /' . expand("<cword>") . '/j * ' <Bar> cw<CR>
map <F9>G :execute 'vimgrep /' . expand("<cword>") . '/j **/* ' <Bar> cw<CR>




" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vundle
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'scrooloose/nerdtree'

Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'

" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" neobundle
" https://github.com/Shougo/neobundle.vim
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/neocomplete.vim' 
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 't9md/vim-textmanip'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tomasr/molokai'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" Unite
" http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction



cd c:\Git\
e c:\Tools\vim\vim_note.txt
