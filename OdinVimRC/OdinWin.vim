
" Version 2.0 "
" OdinWin.rc"
"   Function: include all Windows-based VIM function"

let g:EXT_TOOLS            = g:OdinVimDir . 'tools\'
let g:ODIN_VIMRCPATH       = g:OdinVimDir . 'OdinVimRc\'

let g:CYG_ROOT             ='C:\cygwin\root\'
let g:SOURCECODE           ='D:\SourceCode\'
let g:RAMDISK              ='E:\'
let g:SERVER_SAMBA         ='O:\'
let g:RAMDISK_TEMP         =g:RAMDISK . 'TEMP\'

let g:GIT_DIR              ='C:\Git\'

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" CHECK ENVIRONMENT                                               "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
"if !isdirectory(g:RAMDISK)
"  echo "Please Setup The RamDisk for GVIM"
"endif

"if !isdirectory(g:SERVER_SAMBA)
"  echo "Please Check the Linux DT"
"endif

if !isdirectory(g:GIT_DIR)
  echo "Please Setup The GIT folder for GVIM"
endif

" --------------------------------------------------------------- "
" CHECK ENVIRONMENT                                               "
" --------------------------------------------------------------- "


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" BACKUP                                                          "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
set backup
set       backupdir           =D:\Tools\Vim\temp\
" --------------------------------------------------------------- "
" BACKUP                                                          "
" --------------------------------------------------------------- "


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" TOOLS                                                           "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
"set csprg           =D:\Tools\Vim\tools\cscope\cscope.exe
set csprg           =C:\Toosl\Vim\tools\cscope\cscope.exe
"let Tlist_Ctags_Cmd =g:EXT_TOOLS . 'ctags58\ctags.exe'

fu! SaveCurPos() 
    execute "normal msHmtgg" 
endf

" Remove trailing line feed characters "
fu! Dos2Unix() 
    call SaveCurPos() 
    execute ":%s/\r$//g" 
    call RestoreCurPos() 
endf 
com! Dos2Unix  :call Dos2Unix() 

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
" DIFF 
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" ---------------------------------------------------------------
" DIFF 
" ---------------------------------------------------------------





" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Load/Store Project 
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

fu! PRJ_GetBuild()
  silent exe '!copy ' . g:PRJ_BuildHEX . '\*.ii ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\build\gcc\' . g:PRJ_CfgFileName
  silent exe '!copy ' . g:PRJ_BuildHEX . '\*.h ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\build\gcc\' . g:PRJ_CfgFileName
  silent exe '!copy ' . g:PRJ_BuildHEX . '\hex\ ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\build\gcc\' . g:PRJ_CfgFileName . '\hex'
endf

fu! PRJ_LoadToRam()
  let loadconfirm = input("Are you sure to Load To Ram: (Press Any Key To Confirm)  :")
  if(strlen(loadconfirm) == 0)
    echo "Do Not Load To Ram"
    return 0;
  endif
  if isdirectory(g:PRJ_RamPrjLoc)
    if !isdirectory(g:PRJ_RamPrjPath)
      echo "Create Fold"
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\bin'
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\config'
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\src'
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\src\imaging'
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\build'
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\build\gcc'
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\build\gcc\' . g:PRJ_CfgFileName
      silent exe '!mkdir ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\build\gcc\' . g:PRJ_CfgFileName . '\hex'
    endif

    exe 'cd ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName
    exe 'cd bin\'
    echo "Copy build_cfg.pl"
    silent exe '!copy ' . g:PRJ_SrcCodePath . '..\bin\build_cfg.pl'

    exe 'cd ..\config\'
    echo "Copy Current Config File"
    silent exe '!xcopy ' . g:PRJ_SrcCodePath . '..\config\' . g:PRJ_CfgFileName . '.cfg'
    
    exe 'cd ..\src\'
    echo "Copy Source Code"
    silent exe '!xcopy ' . g:PRJ_SrcCodePath . '. /S /Y'

    echo "Copy Build Dir"
    call PRJ_GetBuild()
    echo "Re-define SRC/Build path"
    let g:PRJ_RamPrjPath  = g:PRJ_RamPrjLoc . g:PRJ_ProjectName
    let g:PRJ_BuildHEX    = g:PRJ_RamPrjPath . '\' . g:PRJ_CodeName . '\build\gcc\' . g:PRJ_CfgFileName . '\'
    let g:PRJ_BuildLstPath= g:PRJ_BuildHEX . '\hex\' . g:PRJ_CfgFileName . '.lst'
    let g:PRJ_SrcCodePath = g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\src\'
    call DeleteHiddenBuffers()
    exe 'cd ' . g:PRJ_SrcCodePath
    exe 'e ' . g:PRJ_CfgFilePath
    if filereadable(g:PRJ_SrcCodePath . 'cscope.out')
      exe 'cs reset'
      echo "Load CSCOPE"
    endif
  elseif
    echo "!!!NO RamDisk Source Path!!!"
  endif
endf

fu! PRJ_StoreBackD()
  let restoreconfirm = input("Are you sure to restore back D: (Press Any Key To Confirm)  :")
  if(strlen(restoreconfirm) != 0)
    echo "Define the SRC/Build Path"
    let g:PRJ_BuildHEX    = g:PRJ_ProjectPath . '/' . g:PRJ_CodeName . '/build/gcc/' . g:PRJ_CfgFileName . '/'
    let g:PRJ_BuildLstPath= g:PRJ_BuildHEX . '/hex/' . g:PRJ_CfgFileName . '.lst'
    let g:PRJ_SrcCodePath = g:PRJ_ProjectLoc . g:PRJ_ProjectName . '/' . g:PRJ_CodeName . '/src/'
    call DeleteHiddenBuffers()

    exe 'cd ' . g:PRJ_SrcCodePath

    echo "restore back build_cfg.pl"
    exe 'cd ../bin/'
    silent exe '!xcopy ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\bin' . '. /S /Y'

    echo "restore back Config File"
    exe 'cd ..\config\'
    silent exe '!xcopy ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\config' . '. /S /Y'

    echo "restore back source code"    
    exe 'cd ..\src\'
    silent exe '!xcopy ' . g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\src' . '. /S /Y'
  endif
endf

fu! PRJ_CopyToTemp()
  " if temp folde not existed, create that
  "   ex: TEMP
  " checck if the same file inside the folder
  "   a. open the diff windows with current file
  "   b. Just replace that
  if !isdirectory(g:PRJ_SrcCodePath . 'TEMP')
    silent exe '!mkdir ' . g:PRJ_SrcCodePath . 'TEMP'
  endif

  if filereadable(g:PRJ_SrcCodePath . 'TEMP\' . expand('%:b'))
    let a:input_key = input( "File existed in TEMP folder, Press C to Compate, otherwise just Replace: " )
    if a:input_key == 'c' || a:input_key == 'C'
      exe 'vert diffsplit ' . g:PRJ_SrcCodePath . 'TEMP\' . expand('%:b')
"      let a:input_key = input( "Press R to Replace: " )
"      if a:input_key == 'r' || a:input_key == 'R'
"        silent exe '!copy ' . expand('%:b') . ' ' .  g:PRJ_SrcCodePath . 'TEMP\' . expand('%:b')
"      endif
    else
      silent exe '!copy ' . expand('%:b') . ' ' .  g:PRJ_SrcCodePath . 'TEMP\' . expand('%:b')
    endif
  else 
    silent exe '!copy ' . expand('%:b') . ' ' .  g:PRJ_SrcCodePath . 'TEMP\' . expand('%:b')
  endif
endf

" ---------------------------------------------------------------
" Load/Store Project 
" ---------------------------------------------------------------


