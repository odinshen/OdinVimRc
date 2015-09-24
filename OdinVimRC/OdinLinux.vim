
" Version 2.0

set guifont=Monaco:h8:cANSI


" Version 2.0 "
" OdinWin.rc"
"   Function: include all Windows-based VIM function"

let g:EXT_TOOLS            = g:OdinVimDir . 'tools/'
let g:ODIN_VIMRCPATH       = g:OdinVimDir . 'OdinVimRc/'
let g:SOURCECODE           ='~/SourceCode/'


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" CHECK ENVIRONMENT                                               "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "

" --------------------------------------------------------------- "
" CHECK ENVIRONMENT                                               "
" --------------------------------------------------------------- "


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" BACKUP                                                          "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
set backup
"set       backupdir           =D:\Tools\Vim\temp\
" --------------------------------------------------------------- "
" BACKUP                                                          "
" --------------------------------------------------------------- "


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" TOOLS                                                           "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
set csprg           =/usr/bin/cscope
let Tlist_Ctags_Cmd =/usr/bin/ctags

fu! SaveCurPos() 
    execute "normal msHmtgg" 
endf

" Remove the Windows ^M - when the encodings gets messed up "
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
noremap <Leader>v :%s/^V^M//g
noremap <Leader>u :%s/^M//g

" convert to HEX view "
map <F4>A <ESC>:%!xxd<CR>
map <F4>a <ESC>:%!xxd<CR>
" convert back ASCII mode from HEX"
map <F4>H <ESC>:%!xxd -r<CR>
map <F4>h <ESC>:%!xxd -r<CR>

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" TOOLS                                                           "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Load/Store Project 
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"fu! PRJ_LoadFromNB()
"endf

"fu! PRJ_StoreBackToNB()
"endf

" ---------------------------------------------------------------
" Load/Store Project 
" ---------------------------------------------------------------



