
" Version 2.0 "
" OdinOneBase.rc"
"   Function: include all onebase VIM function"

let g:PRJ_SrcCodeList = '*.h *.cpp imaging/*.h imaging/*.cpp imaging/ifp/*.h imaging/ifp/*.c imaging/ifp/*.cpp proc/' . g:PRJ_Processor . '/*'

"Search at all source cpp/h"
"map <F9>a :execute 'vimgrep /' . expand("<cword>") . '/j *.h *.cpp imaging/*.h imaging/*.cpp proc/' . g:PRJ_Processor . '/*' <Bar> cw<CR>
"map <F9>A :execute 'vimgrep /' . expand("<cword>") . '/j *.h *.cpp imaging/*.h imaging/*.cpp proc/' . g:PRJ_Processor . '/*' <Bar> cw<CR>
map <F9>a :execute 'vimgrep /' . expand("<cword>") . '/j ' . g:PRJ_SrcCodeList <Bar> cw<CR>
map <F9>A :execute 'vimgrep /' . expand("<cword>") . '/j ' . g:PRJ_SrcCodeList <Bar> cw<CR>

"Search at current ii file and cpp/h"
"map <F9>c :execute 'vimgrep /' . expand("<cword>") . '/j ' expand('%:b') . ' ' . expand('%:p:.:r') . '.h ' . g:PRJ_BuildHEX . expand('%:t:r') . '.ii' <Bar> cw<CR>
"map <F9>C :execute 'vimgrep /' . expand("<cword>") . '/j ' expand('%:b') . ' ' . expand('%:p:.:r') . '.h ' . g:PRJ_BuildHEX . expand('%:t:r') . '.ii' <Bar> cw<CR>
map <F9>c :execute 'vimgrep /' . expand("<cword>") . '/j ' expand('%:p:.:r') . '.cpp ' . expand('%:p:.:r') . '.h ' . g:PRJ_BuildHEX . expand('%:t:r') . '.ii' <Bar> cw<CR>
map <F9>C :execute 'vimgrep /' . expand("<cword>") . '/j ' expand('%:p:.:r') . '.cpp ' . expand('%:p:.:r') . '.h ' . g:PRJ_BuildHEX . expand('%:t:r') . '.ii' <Bar> cw<CR>


"Search at config.h"
map <F9>h :execute 'vimgrep /' . expand("<cword>") . '/j ' . g:PRJ_BuildHEX . '/config.h'<Bar> cw<CR>
map <F9>H :execute 'vimgrep /' . expand("<cword>") . '/j ' . g:PRJ_BuildHEX . '/config.h'<Bar> cw<CR>

"Search at .LST file"
map <F9>l :execute 'vimgrep /' . expand("<cword>") . '/j ' . g:PRJ_BuildLstPath <Bar> cw <CR>
map <F9>L :execute 'vimgrep /' . expand("<cword>") . '/j ' . g:PRJ_BuildLstPath <Bar> cw <CR>

"Search addr at .HEX file"
map <F9>r :execute 'vimgrep /' . expand("<cword>") . '/j ' . g:PRJ_BuildHEX . 'hex/' . g:PRJ_CfgFileName . '.hex' <Bar> cw <CR>
map <F9>R :execute 'vimgrep /' . expand("<cword>") . '/j ' . g:PRJ_BuildHEX . 'hex/' . g:PRJ_CfgFileName . '.hex' <Bar> cw <CR>

"Search at config/*"
map <F9>g :execute 'vimgrep /' . expand("<cword>") . '/j ' . '../config/* ' <Bar> cw<CR>
map <F9>G :execute 'vimgrep /' . expand("<cword>") . '/j ' . '../config/* ' <Bar> cw<CR>

"Search at regs/*"
map <F9>re :execute 'vimgrep /' . expand("<cword>") . '/j ' . '../regs/* ' <Bar> cw<CR>
map <F9>RE :execute 'vimgrep /' . expand("<cword>") . '/j ' . '../regs/* ' <Bar> cw<CR>

"Search at config/*"
map <F9>f :execute 'vimgrep /' . expand("<cword>") . '/j ' . 'imaging/ifp/* ' <Bar> cw<CR>
map <F9>F :execute 'vimgrep /' . expand("<cword>") . '/j ' . 'imaging/ifp/* ' <Bar> cw<CR>

"Source Code View"
map <F11>H <ESC>:vsplit %:p:.:r.h<CR>
map <F11>h <ESC>:vsplit %:p:.:r.h<CR>
map <F12>H <ESC>:tab sview %:p:.:r.h<CR>
map <F12>h <ESC>:tab sview %:p:.:r.h<CR>
map <F11>C <ESC>:vsplit %:p:.:r.cpp<CR>
map <F11>c <ESC>:vsplit %:p:.:r.cpp<CR>
map <F12>C <ESC>:tab sview %:p:.:r.cpp<CR>
map <F12>c <ESC>:tab sview %:p:.:r.cpp<CR>

cnoreabbrev vh      vsplit %:p:.:r.h
cnoreabbrev vc      vsplit %:p:.:r.cpp
cnoreabbrev VH      vsplit %:p:.:r.h
cnoreabbrev VC      vsplit %:p:.:r.cpp
cnoreabbrev th      tab sview %:p:.:r.h
cnoreabbrev tc      tab sview %:p:.:r.cpp
cnoreabbrev TH      tab sview %:p:.:r.h
cnoreabbrev TC      tab sview %:p:.:r.cpp

cnoreabbrev vcfg    exe 'vsplit ' . g:PRJ_BuildHEX . '/config.h'
cnoreabbrev VCFG    exe 'vsplit ' . g:PRJ_BuildHEX . '/config.h'

cnoreabbrev tcfg    exe 'tab sview ' . g:PRJ_BuildHEX . '/config.h'
cnoreabbrev TCFG    exe 'tab sview ' . g:PRJ_BuildHEX . '/config.h'


"II File"
map <F11>i <ESC>:exe 'vsplit ' . g:PRJ_BuildHEX . '/' . expand('%:t:r') . '.ii'<CR>
map <F12>i <ESC>:exe 'tab sview ' . g:PRJ_BuildHEX . '/' . expand('%:t:r') . '.ii'<CR>

map <F11>I <ESC>:exe 'vsplit ' . g:PRJ_BuildHEX . '/' . expand('%:t:r') . '.ii'<CR>
map <F12>I <ESC>:exe 'tab sview ' . g:PRJ_BuildHEX . '/' . expand('%:t:r') . '.ii'<CR>

"VSPLIT II File"
cnoreabbrev iisp    exe 'vsplit ' . g:PRJ_BuildHEX . '/' . expand('%:t:r') . '.ii'
cnoreabbrev IISP    exe 'vsplit ' . g:PRJ_BuildHEX . '/' . expand('%:t:r') . '.ii'

"Search II File"
cnoreabbrev iif    execute 'vimgrep /' . expand("<cword>") . '/j ' expand('%:b') . ' ' . expand('%:p:.:r') . '.h ' . g:PRJ_BuildHEX . expand('%:t:r') . '.ii' <Bar> cw<CR>
cnoreabbrev IIF    execute 'vimgrep /' . expand("<cword>") . '/j ' expand('%:b') . ' ' . expand('%:p:.:r') . '.h ' . g:PRJ_BuildHEX . expand('%:t:r') . '.ii' <Bar> cw<CR>

"New Tab for II File"
cnoreabbrev iitv    exe 'tab sview ' . g:PRJ_BuildHEX . '/' . expand('%:t:r') . '.ii'
cnoreabbrev IITV    exe 'tab sview ' . g:PRJ_BuildHEX . '/' . expand('%:t:r') . '.ii'

"lst file"
cnoreabbrev lst    exe 'tab sview ' . g:PRJ_BuildLstPath 
cnoreabbrev LST    exe 'tab sview ' . g:PRJ_BuildLstPath 
"Search Keyword/reg in lst
cnoreabbrev lstr    exe 'vimgrep /' . expand("<cword>") . '/j ' . g:PRJ_BuildHEX . 'hex/' . g:PRJ_CfgFileName . '.hex' <Bar> cw <CR>

"register map file"
cnoreabbrev regmap    exe 'tab sview ' . g:PRJ_BuildHEX . '../reports/' . g:PRJ_CfgFileName . '/inhouse/registerMap_inhouse.h' 
cnoreabbrev regmap    exe 'tab sview ' . g:PRJ_BuildHEX . '../reports/' . g:PRJ_CfgFileName . '/inhouse/registerMap_inhouse.h' 

"Copy to server"
if has('win32') || has('win64')
  cnoreabbrev us    exe '!copy ' . expand('%:b') . ' ' . g:PRJ_SrvCodeWinPath . expand('%:b')
else
  cnoreabbrev us    exe '!copy ' . expand('%:b') . ' ' . g:PRJ_SrvCodePath . expand('%:b')
endif

let g:winManagerWindowLayout = 'FileExplorer|TagList'
let g:winManagerWidth = 30
let g:defaultExplorer = 0
let Tlist_Exit_OnlyWindow = 1     "exit if taglist is last window open
let Tlist_Show_One_File = 0
let Tlist_File_Fold_Auto_Clos = 1
let Tlist_Use_SingleClick = 1
"let Tlist_Show_One_File = 1       " Only show tags for current buffer


nmap <C-/>s :cs find o <C-R>=expand("<cword>")<Bar> cw<CR>

map <F8>c <ESC>:call PRJ_CopyToTemp()<CR>



cnoreabbrev prj2e      call PRJ_LoadToRam()
cnoreabbrev prj2d      call PRJ_StoreBackD()

map <F7>R <ESC>:call PRJ_LoadToRam()<CR>
map <F7>B <ESC>:call PRJ_StoreBackD()<CR>

set guifont=Consolas:h13:cANSI
com! -nargs=1 FontMonaco   :set gfn=Consolas:h<args>:cANSI 
cabbr fm FontMonaco 

