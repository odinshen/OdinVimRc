
" Version 2.0 "
" OdinProj.rc "
"   Function: include all project related setting "

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" Project                                                         "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
let g:PRJ_RCLoc       = g:SOURCECODE . '_project_rc_/'
let g:PRJ_ProjectLoc  = ''
let g:PRJ_ProjSubLoc  = ''
let g:PRJ_SrvPrjLoc   = ''
let g:PRJ_RamPrjLoc   = ''

if filereadable(g:PRJ_RCLoc . 'last_rc.rc')
  let g:PRJ_RCName = 'last'
else
  let g:PRJ_RCName = ''
endif
let g:PRJ_RCPath = ''

let g:PRJ_ProjectType = ''
let g:PRJ_ProjectName = ''
let g:PRJ_CfgFileName = ''
let g:PRJ_CodeName    = ''
let g:PRJ_Processor   = ''

let g:PRJ_ProjectPath = ''
let g:PRJ_CfgFilePath = ''
let g:PRJ_SrcCodePath = ''
let g:PRJ_SrvCodePath = ''
let g:PRJ_SrvCodeWinPath = ''
let g:PRJ_RamPrjPath  = ''

let g:PRJ_BuildHEX    = ''
let g:PRJ_BuildLstPath= ''

let g:PRJ_SrcCodeList = ''

fu! PRJ_Select()
  let g:PRJ_RCName = input( "Input Project File Name(w/o ext name): ")
  echo "RC File: " g:PRJ_RCLoc . g:PRJ_RCName . '.rc'
  if filereadable(g:PRJ_RCLoc . g:PRJ_RCName . '.rc')
    call PRJ_Load()
    silent exe '!copy ' . g:PRJ_RCPath . ' ' . g:PRJ_RCLoc . 'last_rc.rc' 
  elseif filereadable(g:PRJ_RCLoc . 'last_rc.rc')
    echo "Use Last RC"
    let g:PRJ_RCName = 'last_rc'
    call PRJ_Load()
  else 
    echo "NO RC File"
    let g:PRJ_RCName = ''
    let g:PRJ_RCPath = ''
  endif
endf

"fu! PRJ_Get()
"  let g:PRJ_RCName = expand("<cword>")
"  echo "RC File: " g:PRJ_RCLoc . g:PRJ_RCName . '.rc'
"endf

fu! PRJ_Load()

  let g:PRJ_RCPath = g:PRJ_RCLoc . g:PRJ_RCName . '.rc'  
  exe 'source ' . g:PRJ_RCPath
  let g:PRJ_ProjectPath = g:PRJ_ProjectLoc . '/' . g:PRJ_ProjSubLoc . '/' . g:PRJ_ProjectName . '/'

"  if g:PRJ_ProjectType == 'onebase'

    let g:PRJ_CfgFilePath = g:PRJ_ProjectPath . g:PRJ_CodeName . '/config/' . g:PRJ_CfgFileName . '.cfg'

    " Can be change to RamDisk Path "
    let g:PRJ_BuildHEX    = g:PRJ_ProjectPath . g:PRJ_CodeName . '/build/gcc/' . g:PRJ_CfgFileName . '/'
    let g:PRJ_BuildLstPath= g:PRJ_BuildHEX . 'hex/' . g:PRJ_CfgFileName . '.lst'
    let g:PRJ_SrcCodePath = g:PRJ_ProjectLoc . '/' . g:PRJ_ProjSubLoc . '/' . g:PRJ_ProjectName . '/' . g:PRJ_CodeName . '/src/'

    if isdirectory(g:PRJ_SrvPrjLoc . g:PRJ_ProjectName)
      let g:PRJ_SrvCodePath = g:PRJ_SrvPrjLoc . g:PRJ_ProjectName . '/' . g:PRJ_CodeName . '/src/'
      if has('win32') || has('win64')
        let g:PRJ_SrvCodeWinPath = g:PRJ_SrvPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\src\'
      endif
    else
      echo "NO Server Path"
    endif
    if isdirectory(g:PRJ_RamPrjLoc . g:PRJ_ProjectName)
      let g:PRJ_RamPrjPath = g:PRJ_RamPrjLoc . g:PRJ_ProjectName . '/' . g:PRJ_CodeName . '/src/'
    endif
    call PRJ_Print()
  
    echo "OneBase Type"
    echo g:ODIN_VIMRCPATH
    exe 'source ' . g:OdinVimDir . g:ODIN_VIMRCPATH . 'OdinCPP.vim'
    exe 'source ' . g:OdinVimDir . g:ODIN_VIMRCPATH . 'OdinOnebase.vim'

    call DeleteHiddenBuffers()
    exe 'cd ' . g:PRJ_SrcCodePath

    exe 'e ../config/' . g:PRJ_CfgFileName . '.cfg'
    if filereadable(g:PRJ_SrcCodePath . 'cscope.out')
      exe 'cs reset'
      echo "Load CSCOPE"
      exe 'cs add cscope.out'
    endif

"  elseif g:PRJ_ProjectType == 'usbstack'
"    let g:PRJ_SrcCodePath = g:PRJ_ProjectLoc . g:PRJ_ProjectName . '/' . g:PRJ_CodeName . '/usbdev/'
"    if isdirectory(g:PRJ_SrvPrjLoc . g:PRJ_ProjectName)
"      let g:PRJ_SrvCodePath = g:PRJ_SrvPrjLoc . g:PRJ_ProjectName . '/' . g:PRJ_CodeName . '/usbdev/'
"      if has('win32') || has('win64')
"        let g:PRJ_SrvCodeWinPath = g:PRJ_SrvPrjLoc . g:PRJ_ProjectName . '\' . g:PRJ_CodeName . '\usbdev\'
"      endif
"    else
"      echo "NO Server Path"
"    endif
"    call PRJ_Print()

"    echo "Usb-Stack Type"
"    echo g:ODIN_VIMRCPATH
"    exe 'source ' . g:OdinVimDir . g:ODIN_VIMRCPATH . 'OdinCPP.vim'

"    exe 'cd ' . g:PRJ_SrcCodePath
"    call DeleteHiddenBuffers()    
"  endif

endfunction

fu! PRJ_ShowCFG()
  exe 'tab sview ../config/' . g:PRJ_CfgFileName . '.cfg'
endf

fu! PRJ_Print()
  echo "RC            : " . g:PRJ_RCName
  echo "Project Type  : " . g:PRJ_ProjectType
  echo "Project       : " . g:PRJ_ProjectName
  echo "CFG File      : " . g:PRJ_CfgFileName
  echo "RC Path       : " . g:PRJ_RCPath
  echo "Project Path  : " . g:PRJ_ProjectPath
  echo "CFG Path      : " . g:PRJ_CfgFilePath
  echo "Source List   : " . g:PRJ_SrcCodeList
  echo "Build Hex     : " . g:PRJ_BuildHEX
  echo "List Path     : " . g:PRJ_BuildLstPath
  if isdirectory(g:PRJ_RamPrjLoc . g:PRJ_ProjectName)  
    echo "RamDisk Path  : " . g:PRJ_RamPrjPath
  else
    echo "RamDisk Path  : No RamDisk Path"
  endif
  if isdirectory(g:PRJ_SrvPrjLoc . g:PRJ_ProjectName)  
    echo "Server Path   : " . g:PRJ_SrvPrjLoc
  else
    echo "Servrt Path   : No Server Path"
  endif
endf

fu! PRJ_Erase()
  let g:PRJ_ProjectLoc    = ''
  let g:PRJ_ProjSubLoc    = '' 
  let g:PRJ_SrvPrjLoc     = ''
  let g:PRJ_RamPrjLoc     = ''
  let g:PRJ_RCName        = 'last'
  let g:PRJ_RCPath        = ''
  let g:PRJ_ProjectType   = ''
  let g:PRJ_ProjectName   = ''
  let g:PRJ_CfgFileName   = ''
  let g:PRJ_ProjectPath   = ''
  let g:PRJ_CfgFilePath   = ''
  let g:PRJ_SrcCodeList   = ''
  let g:PRJ_SrcCodePath   = ''
  let g:PRJ_SrvCodePath   = ''
  let g:PRJ_RamPrjPath    = ''
  let g:PRJ_BuildHEX      = ''
  let g:PRJ_BuildLstPath  = ''
endf

fu! PRJ_List()
  exe "vsplit " . g:PRJ_RCLoc
"  if has('win32') || has('win64')
"    exe "w! " . g:RAMDISK_TEMP . "rc.list"
"  endif
endf

fu! PRJ_ShowRC()
  call OpenTab(g:PRJ_RCPath)
endf

cnoreabbrev prjs      call PRJ_Select()
cnoreabbrev prjp      call PRJ_Print()
cnoreabbrev prje      call PRJ_Erase()
cnoreabbrev prjl      call PRJ_List()
cnoreabbrev prjcfg    call PRJ_ShowCFG()
"cnoreabbrev prjg      call PRJ_Get()
cnoreabbrev prjscf    call PRJ_SymbolConstruct(1)
cnoreabbrev prjsc     call PRJ_SymbolConstruct(0)

map <F7>S <ESC>:call PRJ_Select()<CR>
map <F7>P <ESC>:call PRJ_Print()<CR>
map <F7>E <ESC>:call PRJ_Erase()<CR>
map <F7>L <ESC>:call PRJ_List()<CR>
"map <F7>G <ESC>:call PRJ_Get()<CR>
map <F7>Y <ESC>:call PRJ_SymbolConstruct()<LEFT>
map <F7>O <ESC>:execute "tab sview " . g:PRJ_RCLoc . 'last_rc.rc'<CR>
map <F7>C <ESC>:call PRJ_ShowCFG()<CR>

map <F7>s <ESC>:call PRJ_Select()<CR>
map <F7>p <ESC>:call PRJ_Print()<CR>
map <F7>e <ESC>:call PRJ_Erase()<CR>
map <F7>l <ESC>:call PRJ_List()<CR>
"map <F7>g <ESC>:call PRJ_Get()<CR>
map <F7>y <ESC>:call PRJ_SymbolConstruct()<LEFT>
map <F7>o <ESC>:execute "tab sview " . g:PRJ_RCLoc . 'last_rc.rc'<CR>
map <F7>c <ESC>:call PRJ_ShowCFG()<CR>


" --------------------------------------------------------------- "
" Project                                                         "
" --------------------------------------------------------------- "

