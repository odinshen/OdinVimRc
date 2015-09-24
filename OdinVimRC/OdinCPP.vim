
" Version 2.0 "
" OdinCPP.rc"
"   Function: include all CPP function, cscope, ctag, fuzzy"


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" FuzzyFinder                                                     "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
map FF <ESC> :FuzzyFinderFile<CR> 
map FD <ESC> :FuzzyFinderDir<CR> 
map FBA <ESC> :FuzzyFinderAddBookmark<CR>
map FBL <ESC> :FuzzyFinderBookmark<CR>
map FU <ESC> :FuzzyFinderBuffer<CR> 
map FT <ESC> :FuzzyFinderTag<CR> 
map FTF <ESC> :FuzzyFinderTaggedFile<CR>
map FMC <ESC> :FuzzyFinderMruCmd<CR> 
map FMF <ESC> :FuzzyFinderMruFile<CR>
map ff <ESC> :FuzzyFinderFile<CR> 
map fd <ESC> :FuzzyFinderDir<CR> 
map fba <ESC> :FuzzyFinderAddBookmark<CR>
map fbl <ESC> :FuzzyFinderBookmark<CR>
map fu <ESC> :FuzzyFinderBuffer<CR> 
map ft <ESC> :FuzzyFinderTag<CR> 
map ftf <ESC> :FuzzyFinderTaggedFile<CR>
map fmc <ESC> :FuzzyFinderMruCmd<CR> 
map fmf <ESC> :FuzzyFinderMruFile<CR>

nmap <F6>A <ESC> :FuzzyFinderAddBookmark<CR>
nmap <F6>B <ESC> :FuzzyFinderBookmark<CR> 
nmap <F6>F <ESC> :FuzzyFinderFile<CR>
nmap <F6>D <ESC> :FuzzyFinderDir<CR>
nmap <F6>T <ESC> :FuzzyFinderTag<CR>
nmap <F6>TF <ESC> :FuzzyFinderTaggedFile<CR>
nmap <F6>MC <ESC> :FuzzyFinderMruCmd<CR>
nmap <F6>MF <ESC> :FuzzyFinderMruFile<CR>
nmap <F6>a <ESC> :FuzzyFinderAddBookmark<CR>
nmap <F6>b <ESC> :FuzzyFinderBookmark<CR> 
nmap <F6>f <ESC> :FuzzyFinderFile<CR>
nmap <F6>d <ESC> :FuzzyFinderDir<CR>
nmap <F6>t <ESC> :FuzzyFinderTag<CR>
nmap <F6>tf <ESC> :FuzzyFinderTaggedFile<CR>
nmap <F6>mc <ESC> :FuzzyFinderMruCmd<CR>
nmap <F6>mf <ESC> :FuzzyFinderMruFile<CR>

" --------------------------------------------------------------- "
" FuzzyFinder                                                     "
" --------------------------------------------------------------- "


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" cTags                                                           "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
fu! SaveCurPos() 
    execute "normal msHmtgg" 
endf

cnoreabbrev tagu    TlistOpen<CR>
cnoreabbrev tagd    TlistClose<CR>

cnoreabbrev tagc    exe '!' .  Tlist_Ctags_Cmd . ' -R -L ' . g:PRJ_CfgFileName . '.files' "create ctags"

map <F10>U <ESC>:TlistOpen<CR>
map <F10>D <ESC>:TlistClose<CR>
map <F10>C <ESC>:tagc<CR>
map <F10>u <ESC>:TlistOpen<CR>
map <F10>d <ESC>:TlistClose<CR>
map <F10>c <ESC>:tagc<CR>

" --------------------------------------------------------------- "
" cTags                                                           "
" --------------------------------------------------------------- "


" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
" cScope                                                          "
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "

cnoreabbrev csa cs add cscope.out
cnoreabbrev csf cs find
cnoreabbrev csk cs kill
cnoreabbrev csr cs reset
cnoreabbrev css cs show
cnoreabbrev csh cs help

cnoreabbrev CSFC cs find c
cnoreabbrev CSFD cs find d
cnoreabbrev CSFE cs find e
cnoreabbrev CSFF cs find f
cnoreabbrev CSFG cs find g
cnoreabbrev CSFI cs find i
cnoreabbrev CSFS cs find s
cnoreabbrev CSFT cs find t

cnoreabbrev csfc cs find c
cnoreabbrev csfd cs find d
cnoreabbrev csfe cs find e
cnoreabbrev csff cs find f
cnoreabbrev csfg cs find g
cnoreabbrev csfi cs find i
cnoreabbrev csfs cs find s
cnoreabbrev csft cs find t


fu! PRJ_SymbolConstruct(force)
  if filereadable(g:PRJ_SrcCodePath . g:PRJ_CfgFileName . '.files')
    if a:force == 1
      exe 'cs kill 0'
      silent exe '! del tags'
      silent exe '! del cscope.out'
    endif
    if !filereadable(g:PRJ_SrcCodePath . 'cscope.out')
      echo "Create cscope.out"
      silent exe '! ' . g:EXT_TOOLS . 'cscope\cscope.exe -b -q -i ' . g:PRJ_CfgFileName . '.files'
    endif
    if filereadable(g:PRJ_SrcCodePath . 'cscope.out')
      echo "Load CSCOPE"
        exe 'cs add cscope.out'
    endif
    if !filereadable(g:PRJ_SrcCodePath . 'tags')
      echo "Create ctags"
      silent exe '!' . g:EXT_TOOLS . 'ctags58\ctags.exe -L ' . g:PRJ_CfgFileName . '.files'
    endif
  else
    echo "No Source List"
  endif
endfunction
" --------------------------------------------------------------- "
" cScope                                                          "
" --------------------------------------------------------------- "


map addincguard :call IncludeGuard()<CR>
map <leader>aig :call IncludeGuard()<CR>
"use :addincguard or \aig"
"add #ifndef _IMAGING\ACQUISITION_THREAD_NOISE_SCANNER_CPP"
"#define _IMAGING\ACQUISITION_THREAD_NOISE_SCANNER_CPP"
"#endif // for #ifndef _\TOOLS\VIM\_VIMRC
fun! IncludeGuard()
   let basename = substitute(bufname(""), '.*/', '', '')
   let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
   call append(0, "#ifndef " . guard)
   call append(1, "#define " . guard)
   call append( line("$"), "#endif // for #ifndef " . guard)
endfun



