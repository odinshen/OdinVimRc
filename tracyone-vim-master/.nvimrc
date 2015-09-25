"@file       .nvimrc 
"@brief      config file for neovim
"@date       2015-05-24/20:58:49
"@author     tracyone,tracyone@live.cn,
"@github    https://github.com/tracyone
"@website    https://onetracy.com
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Encode {{{
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb1830,big5,euc-jp,euc-kr,gbk
if v:lang=~? '^\(zh\)\|\(ja\)\|\(ko\)'
    set ambiwidth=double
endif
source $VIMRUNTIME/delmenu.vim
lan mes en_US.UTF-8
"set langmenu=nl_NL.ISO_8859-1
"}}}
"System check{{{
set filetype=unix
set ffs=unix
set keywordprg=""
set shell=zsh
set path=.,/usr/include/,/usr/include/c++/4.8/ "c++ is in /usr/include/c++/...
let $VIMFILES = $HOME.'/.vim'
set makeprg=make
let s:iswindows=0
"}}}
"Basic setting{{{
"{{{fold setting
"folding type: manual, indent, expr, marker or syntax
set foldenable                  " enable folding
augroup fold_group
    autocmd!
    autocmd FileType c,cpp setlocal foldmethod=syntax 
    autocmd FileType verilog setlocal foldmethod=marker 
    autocmd FileType verilog setlocal foldmarker=begin,end 
    autocmd FileType sh setlocal foldmethod=indent
augroup END
set foldlevel=100         " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set foldcolumn=1
function! MyFoldText()
    let line = getline(v:foldstart)
    if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
        let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
        let linenum = v:foldstart + 1
        while linenum < v:foldend
            let line = getline( linenum )
            let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
            if comment_content != ''
                break
            endif
            let linenum = linenum + 1
        endwhile
        let sub = initial . ' ' . comment_content
    else
        let sub = line
        let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
        if startbrace == '{'
            let line = getline(v:foldend)
            let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
            if endbrace == '}'
                let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
            endif
        endif
    endif
    let n = v:foldend - v:foldstart + 1
    let info = " " . n . " lines"
    let sub = sub . "                                                                                                                  "
    let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
    let fold_w = getwinvar( 0, '&foldcolumn' )
    let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
    return sub . info
endfunction
set foldtext=MyFoldText()
nnoremap <silent><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
"}}}
"list candidate word in statusline
set wildmenu
set wildmode=longest,full
set wic
set clipboard+=unnamedplus
"set list  "display unprintable characters by set list
set listchars=tab:\|\ ,trail:-  "Strings to use in 'list' mode and for the |:list| command
augroup list_group
    autocmd!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif "jump to last position last open in vim
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END
"{{{backup
set backup "generate a backupfile when open file
set backupext=.bak  "backup file'a suffix
set backupdir=$VIMFILES/vimbackup  "backup file's directory
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
"}}}
"do not Ring the bell (beep or screen flash) for error messages
set noerrorbells
set mat=2  
set report=0  "Threshold for reporting number of lines changed
set lazyredraw  " Don't update the display while executing macros
set helplang=en,cn  "set helplang=en
set autoread   "autoread when a file is changed from the outside
set nonu  "show the line number for each line
set cmdheight=1  "number of lines used for the command-line
set showmatch "when inserting a bracket, briefly jump to its match
set printfont=Yahei_Mono:h10:cGB2312  "name of the font to be used for :hardcopy
set smartcase  "override 'ignorecase' when pattern has upper case characters
set confirm  "start a dialog when a command fails
set smartindent "do clever autoindenting
"set nowrap   "don't auto linefeed
set cindent  "enable specific indenting for C code
set tabstop=4  "number of spaces a <Tab> in the text stands for
set softtabstop=4  "if non-zero, number of spaces to insert for a <Tab>
set smarttab "a <Tab> in an indent inserts 'shiftwidth' spaces
set hlsearch "highlight all matches for the last used search pattern
set shiftwidth=4 "number of spaces used for each step of (auto)indent
set showmode "display the current mode in the status line
"set ruler  "show cursor position below each window
set selection=inclusive  ""old", "inclusive" or "exclusive"; how selecting text behaves
set is  "show match for partly typed search command
"set lbr "wrap long lines at a character in 'breakat'
set backspace=indent,eol,start  "specifies what <BS>, CTRL-W, etc. can do in Insert mode
set whichwrap=b,h,l,<,>,[,]  "list of menu_flags specifying which commands wrap to another line
set mouse=a "list of menu_flags for using the mouse,support all

"unnamed" to use the * register like unnamed register
"autoselect" to always put selected text on the clipboardset clipboard+=unnamed
"set autochdir  "change to directory of file in buffer

"statuslne
set statusline=%<%t%m%r%h%w%{tagbar#currenttag('[%s]','')}
set statusline+=%=[%{(&fenc!=''?&fenc:&enc)}\|%{&ff}\|%Y][%l,%v][%p%%] 
set statusline+=[%{strftime(\"%m/%d\-\%H:%M\")}]
set guitablabel=%N\ %t  "do not show dir in tab
"0, 1 or 2; when to use a status line for the last window
set laststatus=2 "always show status
set stal=1  "always show the tabline
set sessionoptions-=folds
set sessionoptions-=options

"automatic recognition vt file as verilog 
augroup filetype_group
    autocmd!
    au BufRead,BufNewFile *.vt setlocal filetype=verilog
    "automatic recognition bld file as javascript 
    au BufRead,BufNewFile *.bld setlocal filetype=javascript
    "automatic recognition xdc file as javascript
    au BufRead,BufNewFile *.xdc setlocal filetype=javascript
    au BufRead,BufNewFile *.mk setlocal filetype=make
    au BufRead,BufNewFile *.make setlocal filetype=make
    au BufRead,BufNewFile *.veo setlocal filetype=verilog
    au BufRead,BufNewFile * let $CurBufferDir=expand('%:p:h')
    au FileType verilog setlocal tabstop=3
    au FileType verilog setlocal shiftwidth=3
    au FileType verilog setlocal softtabstop=3
    au FileType c,cpp,java,vim,verilog setlocal expandtab "instead tab with space 
    au FileType make setlocal noexpandtab
    au FileType markdown setlocal nospell
    au FileType vim setlocal fdm=marker
	autocmd CmdwinEnter * map <buffer> q <cr>
augroup END

"terminal-emulator setting
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

"##### auto fcitx  ###########
if(!has("gui_running"))
    let g:input_toggle = 1
    function! Fcitx2en()
        let s:input_status = system("fcitx-remote")
        if s:input_status == 2
            let g:input_toggle = 1
            let l:a = system("fcitx-remote -c")
        endif
    endfunction

    function! Fcitx2zh()
        let s:input_status = system("fcitx-remote")
        if s:input_status != 2 && g:input_toggle == 1
            let l:a = system("fcitx-remote -o")
            let g:input_toggle = 0
        endif
    endfunction

    set ttimeoutlen=150
    "exit insert mode
    augroup fcitx_group
        autocmd!
        autocmd InsertLeave * call Fcitx2en()
        autocmd InsertEnter * call Fcitx2zh()
    augroup END
    "##### auto fcitx end ######
endif
"}}}
"Key mapping{{{
"map jj to esc..
"fuck the meta key...
if(!has("gui_running"))
    let c='a'
    while c <= 'z'
        exec "set <m-".c.">=\e".c
        exec "inoremap \e".c." <m-".c.">"
        let c = nr2char(1+char2nr(c))
    endw
    let d='1'
    while d <= '9'
        exec "set <m-".d.">=\e".d
        exec "inoremap \e".d." <m-".d.">"
        let d = nr2char(1+char2nr(d))
    endw
    set timeout timeoutlen=500 ttimeoutlen=1
endif

""no", "yes" or "menu"; how to use the ALT key
set winaltkeys=no

"leader key
let mapleader=","
inoremap jj <c-[>
inoremap <c-d> <c-o>dd
inoremap <c-u> <c-o>viw~
vnoremap [p "0p
noremap <f4> :rightbelow 10split<cr>:terminal<cr>

"visual mode hit tab forward indent ,hit shift-tab backward indent
vnoremap <TAB>  >gv  
vnoremap <s-TAB>  <gv 
"Ctrl-tab is not work in vim
nnoremap <silent><c-TAB> :AT<cr>
nnoremap <silent><right> :tabnext<cr>
nnoremap <silent><Left> :tabp<cr>
nnoremap <m-t> :tabnew<cr>
inoremap <m-t> <esc>:tabnew<cr>
noremap <m-1> <esc>1gt
noremap <m-2> <esc>2gt
noremap <m-3> <esc>3gt
noremap <m-4> <esc>4gt
noremap <m-5> <esc>5gt
noremap <m-6> <esc>6gt
noremap <m-7> <esc>7gt
noremap <m-8> <esc>8gt
noremap <m-9> <esc>9gt

"update the _vimrc
noremap <leader>so :source $MYVIMRC<CR>
"open the vimrc in tab
noremap <leader>vc :tabedit $MYVIMRC<CR>

"insert time info
nnoremap <F7> a<C-R>=strftime("%Y-%m-%d/%H:%M:%S")<CR><ESC>
inoremap <F7> <C-R>=strftime("%Y-%m-%d/%H:%M:%S")<CR>

"clear search result
noremap <m-q> :nohls<CR>:MarkClear<cr>

"save file 
"in terminal ctrl-s is used to stop printf..
noremap <C-S>	:update<CR>
vnoremap <C-S>	<C-C>:update<CR>
inoremap <C-S>	<C-O>:update<CR>

"copy,paste and cut 
noremap <S-Insert> "+gP
inoremap <c-v>	<C-o>"+gp
cmap <C-V>	<C-R>+
cmap <S-Insert>	<C-R>+
vnoremap <C-X> "+x

"select all
noremap <m-a> gggH<C-O>G
inoremap <m-a> <C-O>gg<C-O>gH<C-O>G
cnoremap <m-a> <C-C>gggH<C-O>G
onoremap <m-a> <C-C>gggH<C-O>G
snoremap <m-a> <C-C>gggH<C-O>G
xnoremap <m-a> <C-C>ggVG

"Alignment
nnoremap <m-=> <esc>ggVG=``

" CTRL-C and SHIFT-Insert are Paste
vnoremap <C-C> "+y

"change the windows size
noremap <silent> <C-F9> :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>

"move
inoremap <m-h> <Left>
inoremap <m-l> <Right>
inoremap <m-j> <Down>
inoremap <m-k> <Up>

"move between windos
nnoremap <m-h> <C-w>h
nnoremap <m-l> <C-w>l
nnoremap <m-j> <C-w>j
nnoremap <m-k> <C-w>k

cmap <m-h> <Left>
cmap <m-l> <Right>
cmap <m-j> <Down>
cmap <m-k> <Up>

"replace
nnoremap <c-h> :%s/<C-R>=expand("<cword>")<cr>/

"delete the ^M
nnoremap dm :%s/\r\(\n\)/\1/g<CR>

"cd to current buffer's path
nnoremap <silent> <c-F7> :lcd %:h<CR>
"resize windows
noremap <F5> :call Do_Make()<CR>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

nnoremap <F6> :call Dosunix()<cr>
nnoremap <leader>o :call Open_url()<cr>

"{{{function definition
function! Do_Make()
    :wa
    execute "silent make"
    execute "normal :"
    execute "cw"
endfunction

function! Get_pattern_at_cursor(pat)
    let col = col('.') - 1
    let line = getline('.')
    let ebeg = -1
    let cont = match(line, a:pat, 0)
    while (ebeg >= 0 || (0 <= cont) && (cont <= col))
        let contn = matchend(line, a:pat, cont)
        if (cont <= col) && (col < contn)
            let ebeg = match(line, a:pat, cont)
            let elen = contn - ebeg
            break
        else
            let cont = match(line, a:pat, contn)
        endif
    endwhile
    if ebeg >= 0
        return strpart(line, ebeg, elen)
    else
        return ""
    endif
endfunction

function! Open_url()
    let s:url = Get_pattern_at_cursor('\v(https?://|ftp://|file:/{3}|www\.)(\w|[.-])+(:\d+)?(/(\w|[~@#$%^&+=/.?:-])+)?')
    if s:url == ""
        echohl WarningMsg
        echomsg 'It is not a URL on current cursor！'
        echohl None
    else
        echo 'Open URL：' . s:url
        if has("win32") || has("win64")
            call system("cmd /C start " . s:url)
        elseif has("mac")
            call system("open '" . s:url . "'")
        else
            call system("setsid firefox '" . s:url . "' &")
        endif
    endif
    unlet s:url
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

func! Dosunix()
    if &ff == 'unix'
        exec "se ff=dos"
    else
        exec "se ff=unix"
    endif
endfunc
"}}}
"}}}
"Plugin setting{{{
" Vim-plug -------------------------{{{
let &rtp=&rtp.",".$HOME."/.vim"
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.vim/bundle')
Plug 'vim-scripts/a.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator'
Plug 'dkprice/vim-easygrep'
"Plug 'vim-scripts/verilog.vim'
Plug 'tracyone/Align'
Plug 'sjl/badwolf'
Plug 'tracyone/Colour-Sampler-Pack'
Plug 'altercation/vim-colors-solarized'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/delimitMate.vim'
Plug 'vim-scripts/FuzzyFinder'
Plug 'vim-scripts/genutils'
Plug 'mhinz/vim-startify'
Plug 'Shougo/neomru.vim'
Plug 'SirVer/ultisnips'
Plug 'tracyone/snippets'
Plug 'vim-scripts/dosbatch-indent'
Plug 'vim-scripts/sudo.vim'
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'tracyone/nerdtree'
Plug 'vim-scripts/ShowMarks7'
Plug 'vim-scripts/surround.vim'
Plug 'majutsushi/tagbar'
Plug 'Shougo/unite.vim'
Plug 'vim-scripts/L9'
Plug 'mattn/emmet-vim'
Plug 'adah1972/fencview'
Plug 'vim-scripts/DrawIt'
Plug 'mbbill/VimExplorer'
Plug 'vim-scripts/renamer.vim'
Plug  'hari-rangarajan/CCTree'
Plug 'tracyone/mark.vim'
Plug 'tracyone/MyVimHelp'
Plug 'tracyone/pyclewn_linux' 
Plug 'iamcco/markdown-preview.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
call plug#end()
"}}}
" Tohtml --------------------------{{{
let html_use_css=1
let g:user_emmet_leader_key = '<c-e>'
"}}}
" Tagbar --------------------------{{{
nnoremap <silent><F9> :TagbarToggle<CR>
let g:tagbar_left=0
let g:tagbar_width=30
let g:tagbar_sort=0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_systemenc='cp936'
"}}}
" Cscope --------------------------{{{
exec "silent! cs add cscope.out"
if $CSCOPE_DB != "" "tpyically it is a include db 
    exec "silent! cs add $CSCOPE_DB"
endif
if $CSCOPE_DB1 != ""
    exec "silent! cs add $CSCOPE_DB1"
endif
if $CSCOPE_DB2 != ""
    exec "silent! cs add $CSCOPE_DB2"
endif
if $CSCOPE_DB3 != ""
    exec "silent! cs add $CSCOPE_DB3"
endif
if has("cscope")
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag
    set csprg=cscope
    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0
    set cscopequickfix=s-,c-,d-,i-,t-,e-,i-,g-,f-
    " add any cscope database in current directory
    " else add the database pointed to by environment variable 
    set cscopetagorder=0
endif
set cscopeverbose 
" show msg when any other cscope db added
nnoremap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>:cw 7<cr>
nnoremap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>d :cs find d <C-R>=expand("<cword>")<CR> <C-R>=expand("%")<CR><CR>:cw 7<cr>
nnoremap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>:cw 7<cr>
nnoremap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>:cw 7<cr>
nnoremap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>:cw 7<cr>
nnoremap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:cw 7<cr>
nnoremap <Leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:cw 7<cr>

nnoremap <C-@>s :split<CR>:cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>g :split<CR>:cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>d :split<CR>:cs find d <C-R>=expand("<cword>")<CR> <C-R>=expand("%")<CR><CR>
nnoremap <C-@>c :split<CR>:cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>t :split<CR>:cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>e :split<CR>:cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>f :split<CR>:cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-@>i :split<CR>:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

nnoremap <C-\>s :cs find s 
nnoremap <C-\>g :cs find g 
nnoremap <C-\>c :cs find c 
nnoremap <C-\>t :cs find t 
nnoremap <C-\>e :cs find e 
nnoremap <C-\>f :cs find f 
nnoremap <C-\>i :cs find i 
nnoremap <C-\>d :cs find d 
nnoremap <leader>u :call Do_CsTag()<cr>
nnoremap <leader>a :cs add cscope.out<cr>
"kill the connection of current dir 
nnoremap <leader>k :cs kill cscope.out<cr> 
function! Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(s:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if filereadable("cscope.files")
        if(s:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(s:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "I cannot delete the cscope.out,try again" | echohl None
            echo "kill the cscope connection"
            if has("cscope") && filereadable("cscope.out")
                silent! execute "cs kill cscope.out"
            endif
            if(s:iswindows==1)
                let csoutdeleted=delete(dir."\\"."cscope.out")
            else
                let csoutdeleted=delete("./"."cscope.out")
            endif
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "I still cannot delete the cscope.out,failed to do cscope" | echohl None
            return
        endif
    endif
    "if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        "silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    "endif
    if(executable('cscope') && has("cscope") )
        if(s:iswindows!=1)
            silent! execute "!find $(pwd) -name \"*.[chsS]\" > ./cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs,*.s,*.asm > cscope.files"
        endif
        silent! execute "!cscope -Rbkq -i cscope.files"
        execute "normal :"
        if filereadable("cscope.out")
            silent! execute "cs kill cscope.out"
            execute "cs add cscope.out"
        else
            echohl WarningMsg | echo "No cscope.out" | echohl None
        endif
    endif
endfunction
    "}}}
" Complete ------------------------{{{
"generate .ycm_extra_conf.py for current directory
function! GenYCM()
    let l:cur_dir=getcwd()
    cd $VIMFILES/bundle/YCM-Generator
    :silent execute  ":!./config_gen.py ".l:cur_dir
    if v:shell_error == 0
        echom "Generate successfully!"
        :YcmRestartServer
    else
        echom "Generate failed!"
    endif
    exec ":cd ". l:cur_dir
endfunction
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jf :YcmCompleter GoToDefinition<CR>
let g:syntastic_always_populate_loc_list = 1
let g:ycm_confirm_extra_conf=0
let g:syntastic_always_populate_loc_list = 1
let g:ycm_semantic_triggers = {
  \   'c' : ['->', '    ', '.', ' ', '(', '[', '&'],
\     'cpp,objcpp' : ['->', '.', ' ', '(', '[', '&', '::'],
\     'perl' : ['->', '::', ' '],
\     'php' : ['->', '::', '.'],
\     'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
\     'ruby' : ['.', '::'],
\     'lua' : ['.', ':']
\ }
let g:ycm_collect_identifiers_from_tag_files = 1
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1,
            \ 'infolog' : 1,
            \ 'mail' : 1
            \}
"}}}
" Unite.vim -----------------------{{{

nnoremap    [unite]   <Nop>
nmap   \ [unite]

nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b  :Unite buffer -input=!split<CR>
nnoremap <silent> [unite]m  :Unite file_mru<CR>
nnoremap <silent> [unite]d  :Unite directory_mru<CR>
nnoremap <silent> [unite]r  :<C-u>Unite -buffer-name=register register<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>

augroup unite_gp
    autocmd!
    autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings()
    " Overwrite settings.

    nmap <buffer> <ESC>      <Plug>(unite_exit)
    imap <buffer> jj      <Plug>(unite_insert_leave)
    "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

    " Start insert.
    " let g:unite_enable_start_insert = 0
endfunction

let g:unite_source_file_mru_limit = 200
let g:unite_enable_split_vertically = 0 "vertical split
let g:unite_data_directory = $VIMFILES . '/.unite'
"}}}
" Matchit.vim ---------------------{{{
"extend %
runtime macros/matchit.vim "important 
let loaded_matchit=0
let b:match_ignorecase=1 
set mps+=<:>
set mps+=":"
"}}}
" Nerdtree  -----------------------{{{
let NERDTreeShowLineNumbers=0	"don't show line number
let NERDTreeWinPos='left'	"show nerdtree in the rigth side
"let NERDTreeWinSize='30'
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
noremap <F12> :NERDTreeToggle .<CR> 
"map <2-LeftMouse>  *N "double click highlight the current cursor word 
inoremap <F12> <ESC> :NERDTreeToggle<CR>
"}}}
" A.vim ---------------------------{{{
":A switches to the header file corresponding to the current file being  edited (or vise versa)
":AS splits and switches
":AV vertical splits and switches
":AT new tab and switches
":AN cycles through matches
":IH switches to file under cursor
":IHS splits and switches
":IHV vertical splits and switches
":IHT new tab and switches
":IHN cycles through matches
nnoremap <leader>ih :IH<cr>
nnoremap <leader>ihs :IHS<cr>
nnoremap <leader>ihv :IHV<cr>
nnoremap <leader>iht :IHT<cr>
nnoremap <leader>ihn :IHN<cr>
nnoremap <leader>ia :A<cr>
nnoremap <leader>ias :AS<cr>
nnoremap <leader>iav :AT<cr>
nnoremap <leader>iat :AT<cr>
nnoremap <leader>ian :AN<cr>
"}}}
" Showmark  -----------------------{{{
"The following mappings are setup by default:

"<Leader>mt   - Toggles ShowMarks on and off.
"<Leader>mo   - Forces ShowMarks on.
"<Leader>mh   - Clears the mark at the current line.
"<Leader>ma   - Clears all marks in the current buffer.
"<Leader>mm   - Places the next available mark on the current line.
let showmarks_enable = 0            " disable showmarks when vim startup 
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" 
let showmarks_ignore_type = "hqm"   " help, Quickfix, non-modifiable 
"}}}
" DelimitMate ---------------------{{{
augroup delimitMate_gp
    autocmd!
    au FileType verilog,c let b:delimitMate_matchpairs = "(:),[:],{:}"
augroup END
let delimitMate_nesting_quotes = ['"','`']
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"}}}
" yankring -----------------------{{{
nnoremap <c-y> :YRGetElem<CR>
inoremap <c-y> <esc>:YRGetElem<CR>
let yankring_history_dir = $VIMFILES
let g:yankring_history_file = ".yank_history"
let g:yankring_default_menu_mode = 0
let g:yankring_replace_n_pkey = '<m-p>'
let g:yankring_replace_n_nkey = '<m-n>'
"}}}
" CCtree --------------------------{{{
let g:CCTreeKeyTraceForwardTree = '<C-\>>' "the symbol in current cursor's forward tree 
let g:CCTreeKeyTraceReverseTree = '<C-\><'
let g:CCTreeKeyHilightTree = '<C-\>l' " Static highlighting
let g:CCTreeKeySaveWindow = '<C-\>y'
let g:CCTreeKeyToggleWindow = '<C-\>w'
let g:CCTreeKeyCompressTree = 'zs' " Compress call-tree
let g:CCTreeKeyDepthPlus = '<C-\>='
let g:CCTreeKeyDepthMinus = '<C-\>-'
let CCTreeJoinProgCmd = 'PROG_JOIN JOIN_OPT IN_FILES > OUT_FILE'
let  g:CCTreeJoinProg = 'cat' 
let  g:CCTreeJoinProgOpts = ""
"let g:CCTreeUseUTF8Symbols = 1
"map <F7> :CCTreeLoadXRefDBFromDisk $CCTREE_DB<cr> 
"}}}
" Ctrlp ---------------------------{{{
" Set Ctrl-P to show match at top of list instead of at bottom, which is so
" stupid that it's not default
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_files = 50000

" Tell Ctrl-P to keep the current VIM working directory when starting a
" search, another really stupid non default
let g:ctrlp_working_path_mode = 'w'

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
" Ctrl-P ignore target dirs so VIM doesn't have to! Yay!
let g:ctrlp_custom_ignore = {
            \ 'dir': '\.git$\|\.hg$\|\.svn$\|target$\|built$\|.build$\|node_modules\|\.sass-cache',
            \ 'file': '\v\.(exe|so|dll|o|proj|out|)$',
            \ }
let g:ctrlp_extensions = ['tag', 'buffertag', 'dir', 'bookmarkdir']
"}}}
" VimExplorer ---------------------{{{
let g:VEConf_systemEncoding = 'cp936'
noremap <F11> :silent! VE .<cr>
"}}}
" UltiSnips -----------------------{{{
let g:UltiSnipsUsePythonVersion = 2 "recommend to use python2.x
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets ="<c-tab>"
let g:UltiSnipsJumpForwardTrigge="<c-j>"
let g:UltiSnipsJumpBackwardTrigge="<c-k>"
let g:UltiSnipsSnippetDirectories=["bundle/snippets"]
let g:UltiSnipsSnippetsDir=$VIM."/vimfiles/bundle/snippets"
"}}}
" FencView ------------------------{{{
let g:fencview_autodetect=0 
let g:fencview_auto_patterns='*.txt,*.htm{l\=},*.c,*.cpp,*.s,*.vim'
noremap <F10> :FencManualEncoding cp936<cr>
"}}}
" Renamer -------------------------{{{
"rename multi file name
noremap <F2> :Ren<cr>
"}}}
" Myvimhelp -----------------------{{{
let g:startupfile="first_statup.txt"
if s:iswindows==1
    let g:start_path=$VIMFILES.'/first_statup.txt'
else
    let g:start_path=$VIMFILES.'/.first_statup'
endif
if filereadable(g:start_path)
    noremap <F1> :h MyVimHelp.txt<cr>
else
    execute writefile([g:startupfile], g:start_path)
    execute "silent! h MyVimHelp.txt"
    :only
    noremap <F1> :h MyVimHelp.txt<cr>
endif
"}}}
" Nerdcommander -------------------{{{
let g:NERDMenuMode=1
"}}}
" VimStartify ---------------------{{{
if s:iswindows==1
    let g:startify_session_dir = $VIMFILES .'\sessions'
else
    let g:startify_session_dir = $VIMFILES .'/sessions'
endif
let g:startify_list_order = ['files', 'bookmarks', 'sessions']
let g:startify_change_to_dir = 1
let g:startify_files_number = 5 
let g:startify_change_to_vcs_root = 0
let g:startify_custom_header = [
            \ '   __      ___            ',
            \ '   \ \    / (_)           ',
            \ '    \ \  / / _ _ __ ___   ',
            \ '     \ \/ / | | ''_ ` _ \ ',
            \ '      \  /  | | | | | | | ',
            \ '       \/   |_|_| |_| |_| ',
            \ '',
            \ '    Help <F1> ',
            \ '    tracyone@live.cn',
            \ '',
            \ '',
            \ ]
noremap <F8> :SSave<cr>
augroup startify_gp
    autocmd!
    autocmd FileType startify setlocal buftype=
augroup END
"}}}
" Eclim ---------------------------{{{
let g:EclimCompletionMethod = 'omnifunc'
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp =
            \ '[^. *\t]\.\w*\|\h\w*::'
"}}}
" EasyGrep ------------------------{{{
let g:EasyGrepCommand=1   "use system grep
let g:EasyGrepFilesToExclude=".svn,.git"
set grepprg=grep\ -n\ --exclude-dir=.svn\ --exclude-dir=.git\ $*
command!  -nargs=* Mygp call MyGrep('<f-args>')
"}}}
" Markdown ------------------------{{{
 let g:mkdp_path_to_chrome = "chromium-browser"
"}}}
"au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} :setlocal nospell
filetype plugin indent on
syntax on
"}}}
"Gui releate{{{
set novb
set t_vb=
"highlight the screen line of the cursor
set nocul
set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm
let g:solarized_bold=1
let g:solarized_underline=0
let g:solarized_termcolors=256
let g:solarized_menu=0
set background=dark
colorscheme  solarized
"}}}
"default is on but it is off when you are root,so we put it here
set modeline
" vim: set fdm=marker foldlevel=0 foldmarker& filetype=vim: 
