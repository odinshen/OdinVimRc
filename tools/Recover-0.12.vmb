" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
plugin/recover.vim	[[[1
34
" Vim plugin for diffing when swap file was found
" Last Change: Sun, 25 Mar 2012 20:52:25 +0200
" Version: 0.12
" Author: Christian Brabandt <cb@256bit.org>
" Script:  http://www.vim.org/scripts/script.php?script_id=3068 
" License: VIM License
" GetLatestVimScripts: 3068 10 :AutoInstall: recover.vim
" Documentation: see :h recoverPlugin.txt

" ---------------------------------------------------------------------
" Load Once: {{{1
if exists("g:loaded_recover") || &cp
  finish
endif
let g:loaded_recover = 1"}}}
let s:keepcpo          = &cpo
set cpo&vim

" ---------------------------------------------------------------------
" Public Interface {{{1
" Define User-Commands and Autocommand "{{{
call recover#Recover(1)

com! RecoverPluginEnable :call recover#Recover(1)
com! RecoverPluginDisable :call recover#Recover(0)
com! RecoverPluginHelp   :call recover#Help()

" =====================================================================
" Restoration And Modelines: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo

" Modeline {{{1
" vim: fdm=marker sw=2 sts=2 ts=8 fdl=0
autoload/recover.vim	[[[1
258
" FOOBAR TEST
" Vim plugin for diffing when swap file was found
" ---------------------------------------------------------------
" Author: Christian Brabandt <cb@256bit.org>
" Version: 0.13
" Last Change: Sun, 25 Mar 2012 20:52:25 +0200
" Script:  http://www.vim.org/scripts/script.php?script_id=3068
" License: VIM License
" GetLatestVimScripts: 3068 11 :AutoInstall: recover.vim
"
fu! recover#Recover(on) "{{{1
    if a:on
	call s:ModifySTL(1)
	if !exists("s:old_vsc")
	    let s:old_vsc = v:swapchoice
	endif
	augroup Swap
	    au!
	    au SwapExists * call recover#ConfirmSwapDiff()
	    au BufWinEnter,InsertEnter,InsertLeave,FocusGained * 
			\ call <sid>CheckSwapFileExists()
	augroup END
    else
	augroup Swap
	    au!
	augroup end
	if exists("s:old_vsc")
	    let v:swapchoice=s:old_vsc
	endif
    endif
endfu

fu! s:Swapname() "{{{¹
    redir => a |sil swapname|redir end
    return a[1:]
endfu

fu! s:CheckSwapFileExists() "{{{1
    if !&swapfile 
	return
    endif

    if !filereadable(s:Swapname())
	" previous SwapExists autocommand deleted our swapfile,
	" recreate it and avoid E325 Message
	sil! "setl noswapfile swapfile"
    endif
endfu


fu! s:CheckRecover() "{{{1
    let winnr = winnr()
    if exists("b:swapname") && !exists("b:did_recovery")
	exe "recover" fnameescape(expand('%:p'))
	let  t = tempname()
	exe "sil w!" t
	call system('diff '. shellescape(expand('%:p'),1).
		    \ ' '. shellescape(t,1))
	if !v:shell_error
	    call <sid>EchoMsg("No differences, deleting old swap file")
	    call delete(b:swapname)
	else
	    call recover#DiffRecoveredFile()
	    let b:did_process_recovery=1
	    " Not sure, why this needs feedkeys
	    " Sometimes, I hate when this happens
	    call feedkeys(":wincmd p\n\n", 't')
	endif
	let b:did_recovery=1
    endif
endfun


fu! recover#SwapFoundComplete(A,L,P) "{{{1
    return "Yes\nNo"
endfu

fu! recover#ConfirmSwapDiff() "{{{1
    call inputsave()
    let p = confirm("Swap File found: Diff buffer? ", "&Yes\n&No")
    call inputrestore()
    let b:swapname=v:swapname
    if p == 1
	let v:swapchoice='r'
	" postpone recovering until later (this is done by s:CheckRecover()
	" in an BufReadPost autocommand
	call recover#AutoCmdBRP(1)
    else
	" Don't show the Recovery dialog
	let v:swapchoice='o'
	call <sid>EchoMsg("Found SwapFile, opening file readonly!")
	sleep 2
    endif
endfun

fu! recover#DiffRecoveredFile() "{{{1
	diffthis
	let b:mod='recovered version'
	let l:filetype = &ft
	noa vert new
	0r #
	$d _
	if l:filetype != ""
	    exe "setl filetype=".l:filetype
	endif
	exe "f! " . escape(expand("<afile>")," ") .
		\ escape(' (on-disk version)', ' ')
	let swapbufnr = bufnr('')
	diffthis
	setl noswapfile buftype=nowrite bufhidden=delete nobuflisted
	let b:mod='unmodified version on-disk'
	noa wincmd p
	let b:swapbufnr=swapbufnr
	command! -buffer RecoverPluginFinish :FinishRecovery
	command! -buffer FinishRecovery :call recover#RecoverFinish()
	0
	if has("balloon_eval")
	    set ballooneval bexpr=recover#BalloonExprRecover()
	endif
	setl modified
	echo 'Found Swapfile '.b:swapname . ', showing diff!'
endfu

fu! recover#Help() "{{{1
    echohl Title
    echo "Diff key mappings\n".
    \ "-----------------\n"
    echo "Normal mode commands:\n"
    echohl Normal
    echo "]c - next diff\n".
    \ "[c - prev diff\n".
    \ "do - diff obtain - get change from other window\n".
    \ "dp - diff put    - put change into other window\n"
    echohl Title
    echo "Ex-commands:\n"
    echohl Normal
    echo ":[range]diffget - get changes from other window\n".
    \ ":[range]diffput - put changes into other window\n".
    \ ":RecoverPluginDisable - DisablePlugin\n".
    \ ":RecoverPluginEnable  - EnablePlugin\n".
    \ ":RecoverPluginHelp    - this help"
    if exists(":RecoverPluginFinish")
	echo ":RecoverPluginFinish  - finish recovery"
    endif
endfun



fu! s:EchoMsg(msg) "{{{1
    echohl WarningMsg
    uns echomsg a:msg
    echohl Normal
endfu

fu! s:ModifySTL(enable) "{{{1
    if a:enable
	" Inject some info into the statusline
	:let s:ostl=&stl
	:let &stl=substitute(&stl, '%f', "\\0 %{exists('b:mod')?('['.b:mod.']') : ''}", 'g')
    else
	" Restore old statusline setting
	if exists("s:ostl")
	    let &stl=s:ostl
	endif
    endif
endfu

fu! recover#BalloonExprRecover() "{{{1
    " Set up a balloon expr.
    if exists("b:mod") 
	if v:beval_bufnr==?b:swapbufnr
	    return "This buffer shows the recovered and modified version of your file"
	else
	    return "This buffer shows the unmodified version of your file as it is stored on disk"
	endif
    endif
endfun

fu! recover#RecoverFinish() abort "{{{1
    diffoff
    exe bufwinnr(b:swapbufnr) " wincmd w"
    diffoff
    bd!
    call delete(b:swapname)
    delcommand FinishRecovery
    call s:ModifySTL(0)
endfun

fu! recover#AutoCmdBRP(on) "{{{1
    if a:on
	augroup SwapBRP
	    au!
	    " Escape spaces and backslashes
	    " On windows, we can simply replace the backslashes by forward
	    " slashes, since backslashes aren't allowed there anyway. On Unix,
	    " backslashes might exists in the path, so we handle this
	    " situation there differently.
	    if has("win16") || has("win32") || has("win64") || has("win32unix")
		exe ":au BufReadPost "
		    \ escape(substitute(fnamemodify(expand('<afile>'),
		    \ ':p'), '\\', '/', 'g'), ' \\')"
		    \ :call s:CheckRecover()"
	    else
		exe ":au BufReadPost " escape(fnamemodify(expand('<afile>'),
		    \ ':p'), ' \\')" :call s:CheckRecover()"
	    endif
	augroup END
    else
	augroup SwapBRP
	    au!
	augroup END
	augroup! SwapBRP
    endif
endfu
" Old functions, not used anymore "{{{1
finish

fu! recover#DiffRecoveredFileOld() "{{{2
	" For some reason, this only works with feedkeys.
	" I am not sure  why.
	let  histnr = histnr('cmd')+1
	call feedkeys(":diffthis\n", 't')
	call feedkeys(":setl modified\n", 't')
	call feedkeys(":let b:mod='recovered version'\n", 't')
	call feedkeys(":let g:recover_bufnr=bufnr('%')\n", 't')
	let l:filetype = &ft
	call feedkeys(":vert new\n", 't')
	call feedkeys(":0r #\n", 't')
	call feedkeys(":$delete _\n", 't')
	if l:filetype != ""
	    call feedkeys(":setl filetype=".l:filetype."\n", 't')
	endif
	call feedkeys(":f! " . escape(expand("<afile>")," ") . "\\ (on-disk\\ version)\n", 't')
	call feedkeys(":let swapbufnr = bufnr('')\n", 't')
	call feedkeys(":diffthis\n", 't')
	call feedkeys(":setl noswapfile buftype=nowrite bufhidden=delete nobuflisted\n", 't')
	call feedkeys(":let b:mod='unmodified version on-disk'\n", 't')
	call feedkeys(":exe bufwinnr(g:recover_bufnr) ' wincmd w'"."\n", 't')
	call feedkeys(":let b:swapbufnr=swapbufnr\n", 't')
	"call feedkeys(":command! -buffer DeleteSwapFile :call delete(b:swapname)|delcommand DeleteSwapFile\n", 't')
	call feedkeys(":command! -buffer RecoverPluginFinish :FinishRecovery\n", 't')
	call feedkeys(":command! -buffer FinishRecovery :call recover#RecoverFinish()\n", 't')
	call feedkeys(":0\n", 't')
	if has("balloon_eval")
	"call feedkeys(':if has("balloon_eval")|:set ballooneval|set bexpr=recover#BalloonExprRecover()|endif'."\n", 't')
	    call feedkeys(":set ballooneval|set bexpr=recover#BalloonExprRecover()\n", 't')
	endif
	"call feedkeys(":redraw!\n", 't')
	call feedkeys(":for i in range(".histnr.", histnr('cmd'), 1)|:call histdel('cmd',i)|:endfor\n",'t')
	call feedkeys(":echo 'Found Swapfile '.b:swapname . ', showing diff!'\n", 'm')
	" Delete Autocommand
	call recover#AutoCmdBRP(0)
    "endif
endfu


" Modeline "{{{1
" vim:fdl=0
doc/recoverPlugin.txt	[[[1
151
*recover.vim*   Show differences for recovered files

Author:  Christian Brabandt <cb@256bit.org>
Version: 0.12 Sun, 25 Mar 2012 20:52:25 +0200

Copyright: (c) 2009, 2010 by Christian Brabandt         
           The VIM LICENSE applies to recoverPlugin.vim and recoverPlugin.txt
           (see |copyright|) except use recoverPlugin instead of "Vim".
           NO WARRANTY, EXPRESS OR IMPLIED.  USE AT-YOUR-OWN-RISK.


==============================================================================
1. Contents                                                     *recoverPlugin*

        1.  Contents.....................................: |recoverPlugin|
        2.  recover Manual...............................: |recover-manual|
        3.  recover Feedback.............................: |recover-feedback|
        4.  recover History..............................: |recover-history|

==============================================================================
2. RecoverPlugin Manual                                       *recover-manual*

Functionality

When using |recovery|, it is hard to tell, what has been changed between the
recovered file and the actual on disk version. The aim of this plugin is, to
have an easy way to see differences, between the recovered files and the files
stored on disk.

Therefore this plugin sets up an auto command, that will create a diff buffer
between the recovered file and the on-disk version of the same file. You can
easily see, what has been changed and save your recovered work back to the
file on disk.

By default this plugin is enabled. To disable it, use >
    :RecoverPluginDisable
<
To enable this plugin again, use >
    :RecoverPluginEnable
<
When you open a file and vim detects, that an |swap-file| already exists for a
buffer, the plugin will ask you, if you'd like to see a diff of both versions
using |vimdiff|. In the dialog answer 'Yes' to open the file and display a
diff version or 'No' to open the file normally.

If you have said 'Yes', the plugin opens a new vertical splitt buffer. On the
left side, you'll find the file as it is stored on disk and the right side
will contain your recovered version of the file (using the found swap file).

You can now use the |merge| commands to copy the contents to the buffer that
holds your recovered version. If you are finished, you can close the diff
version and close the window, by issuing |:diffoff!| and |:close| in the
window, that contains the on-disk version of the file. Be sure to save the
recovered version of you file and afterwards you can safely remove the swap
file.
                                        *RecoverPluginFinish* *FinishRecovery*
In the recovered window, the command >
    :FinishRecovery
<
deletes the swapfile closes the diff window and finishes everything up.

Alternatively you can also use the command >
    :RecoveryPluginFinish
<

                                                        *RecoverPluginHelp*
The command >
    :RecoverPluginHelp
<
show a small message, on what keys can be used to move to the next different
region and how to merge the changes from one windo into the other.

                                                        *RecoverPlugin-misc*

If your Vim was built with |+balloon_eval|, recover.vim will also set up an
balloon expression, that shows you, which buffer contains the recovered
version of your file and which buffer contains the unmodified on-disk version
of your file, if you move the mouse of the buffer. (See |balloon-eval|).

If you have setup your 'statusline', recover.vim will also inject some info
(which buffer contains the on-disk version and which buffer contains the
modified, recovered version). Additionally the buffer that is read-only, will
have a filename (|:f|) of something like 'original file (on disk-version)'. If
you want to save that version, use |:saveas|.

==============================================================================
3. Plugin Feedback                                        *recover-feedback*

Feedback is always welcome. If you like the plugin, please rate it at the
vim-page:
http://www.vim.org/scripts/script.php?script_id=3068

You can also follow the development of the plugin at github:
http://github.com/chrisbra/Recover.vim

Please don't hesitate to report any bugs to the maintainer, mentioned in the
third line of this document.

==============================================================================
4. recover History                                          *recover-history*
        0.12: Mar 25, 2012      : minor documentation update
                                : delete swap files, if no difference found
                                  (issue
                                  https://github.com/chrisbra/Recover.vim/issues/1
                                  reported by y, thanks!)
                                : fix some small issues, that prevented the
                                  development versions from working
                                  (https://github.com/chrisbra/Recover.vim/issues/2
                                  reported by Rahul Kumar, thanks!)
        0.11: Oct 19, 2010      : use confirm() instead of inputdialog()
                                  (suggested by D.Fishburn, thanks!)
        0.9: Jun 02, 2010       : use feedkeys(...,'t') instead of feedkeys()
                                  (this works more reliable, although it
                                  pollutes the history), so delete those 
                                  spurious history entries
                                : |RecoverPluginHelp| shows a small help
                                  message, about diff commands (suggested by
                                  David Fishburn, thanks!)
                                : |RecoverPluginFinish| is a shortcut for
                                  |FinishRecovery|
        0.8: Jun 01, 2010       : make :FinishRecovery more robust
        0.7: Jun 01, 2010       : |FinishRecovery| closes the diff-window and
                                  cleans everything up (suggestion by
                                  David Fishburn)
                                : :DeleteSwapFile is not needed anymore
        0.6: May 31, 2010       : |recover-feedback|
                                : Ask to really open a diff buffer for a 
                                  file (suggestion: David Fishburn, thanks!)
                                : DeleteSwapFile to delete the swap file, that
                                  was used to create the diff buffer
                                : change feedkeys(...,'t') to feedkeys('..')
                                  so that not every command appears in the
                                  history.
        0.5: May 04, 2010       :0r command in recover plugin adds extra \n
                                  Patch by Sergey Khorev (Thanks!)
                                : generate help file with 'et' set, so the 
                                  README at github looks prettier
        0.4: Apr 26, 2010       : handle Windows and Unix path differently
                                : Code cleanup
                                : Enabled |:GLVS|
        0.3: Apr 20, 2010       : first public verion
                                : put plugin on a public repository 
                                  (http://github.com/chrisbra/Recover.vim)
        0.2: Apr 18, 2010       : Internal version, some cleanup,
                                  bugfixes for windows
        0.1: Apr 17, 2010       : Internal version, First working version, 
                                  using simple commands

==============================================================================
Modeline:
vim:tw=78:ts=8:ft=help:et
