- [我的VIM配置文件](#我的vim配置文件)
- [使用之前注意事项](#使用之前注意事项)
- [build_vim](#build_vim)
- [Visual Studio配置文件](#Visual-Studio配置文件)

# 我的vim配置文件

**文件列表**

- `.vimrc` for linux  

- `.nvimrc` for neovim

- `_vimrc` for windows  

- `build_vim.sh`,用于在windows使用MinGw编译vim源代码的小脚本。

- `VisualStudio.vssettings`是Microsoft Visual Studio 2010 sp1的选项配置文件，用于Visual C++，使用`VsVim`插件，使用`Son of Obsidian`主题。

- `_vsvimrc`这是`VsVim`的配置文件

# 使用之前注意事项

* [废弃]无论win还是linux都必须安装git并加入环境变量.windows下必须安装我收集的这个工具包[VimTools](https://github.com/tracyone/VimTools)
* 首次启动会有错误，不过没关系，启动后执行`:BundleInstall`，保证你的电脑可以联网..去喝杯牛奶然后回来..
* 插件安装完毕之后，你会发现字体奇怪，请安装我精心收集的编程字体[编程专用字体](https://github.com/tracyone/program_font)
* 安装完毕之后，可以按F1，这里会弹出我自己制作的help针对本vimrc...
* 有啥问题和建议可以发email给我讨论，我也是菜鸟..
* [neovim](https://github.com/neovim/neovim)的配置使用另外一个插件管理器[vim-plug](https://github.com/junegunn/vim-plug)，首次启动会自动下载这个插件然后自动执行`PlugInstall`安装其它插件，neovim使用补全插件暂时是[YouCompleteMe](https://github.com/Valloric/YouCompleteMe)(等[Shougo](https://github.com/Shougo)君的[deoplete](https://github.com/Shougo/deoplete.nvim))，ycm的conf配置文件使用这个[newycm_extra_conf.py](https://github.com/robturtle/newycm_extra_conf.py)，这包括了`c`、`cpp`和`qt`的模板，并且有一个python脚本可以生成其它语言的模板..
* Happy vimming

# vimrc

.vimrc和_vimrc的内容是一样的，你可以将_vimrc拿到linux发行版下用，仅仅需要更换名称和转换文本格式为UNIX即可(可以使用`dos2unix工具`)。

下面用一些截图来说明使用我这个配置之后能完成的功能:

1. 万能补全，采用[Shougo的neocomplete插件](https://github.com/Shougo/neocomplete.vim),对多种编程语言补全很好，但是对java和c++这些不给力。

	![Vim completion with animation.](https://f.cloud.github.com/assets/214488/623496/94ed19a2-cf68-11e2-8d33-3aad8a39d7c1.gif)

2. 插件管理是[vundle](https://github.com/gmarik/Vundle.vim)，此插件可以通过git和github代码托管网站在线更新插件，一句话评论：够用

	![my plugin list](https://cloud.githubusercontent.com/assets/4246425/3328131/c0472718-f7b8-11e3-87ab-3483a2bfd61e.png)

3. [CtrlP](https://github.com/kien/ctrlp.vim)，当前目录及其子目录快速定位打开文件，历史记录，书签，tags和缓冲区等，一句话评论:神器。

	![ctrlp](https://cloud.githubusercontent.com/assets/4246425/3328197/a0574cfc-f7b9-11e3-86c1-0dc9ab460e91.png)

4. 文件管理器[VimExplorer](https://github.com/mbbill/VimExplorer.git),拥有几乎所有文件浏览器的功能，移动、复制、粘贴、书签、重命名和调用外部程序打开对应后缀的文件。它是直接调用的是系统的命令。它的操作当然是VIM模式，比如说p就是粘贴..dd就是删除..此外结合另外一个插件[Renamer.vim](https://github.com/vim-scripts/renamer.vim)，可以快速修改文件名..

	![VimExplorer](https://cloud.githubusercontent.com/assets/4246425/3328302/1a53973a-f7bb-11e3-9159-5698f91b4bd8.png)

5. [TagBar](https://github.com/majutsushi/tagbar.git)，这个大家很熟悉了，就是浏览源代码的tags.这个插件比[vim.org](www.vim.org)上下载量最高的taglist要好用和准确。

	![tagbar](https://cloud.githubusercontent.com/assets/4246425/3328527/8bbe2bcc-f7bd-11e3-9f8e-fcba3f34cb17.png)

6. [vim-startify](https://github.com/mhinz/vim-startify)，定制你的"开机启动画面"，有点夸大，其实这个插件就是代替打开vim时显示的内容，取而代之的是自定义字符（可以用字符画出你能画出来的东西），还有列出最近打开的文件和已经保存的会话，支持快捷键快速打开(没一行前面的字符)

	![startify](https://cloud.githubusercontent.com/assets/4246425/3328744/7a04d42e-f7bf-11e3-9eb0-6fd8ea07deed.png)

7. [ultisnips](https://github.com/SirVer/ultisnips)，也就是代码片段生成，插件本身自带了很多种的snippets，自己定义snippets也非常简单，一句话评价：神器

	![GIF Demo](https://raw.github.com/SirVer/ultisnips/master/doc/demo.gif)

8. [vimshell](https://github.com/Shougo/vimshell.vim)，这是目前为止比较好的在vim中嵌入shell的解决方案。

	![1406221403447686](https://cloud.githubusercontent.com/assets/4246425/3351706/bf344db0-fa1a-11e3-888e-98f0b88e6be9.gif)

9. 下面介绍的是在vim下集成gdb调试，使用的是[pyclewn_linux](https://github.com/tracyone/pyclewn_linux)这个我稍微修改的插件，支持菜单栏点击，基本上和ide无异了，点击链接进去看看效果..

10. 复制粘贴是使用[YankRing](https://github.com/vim-scripts/YankRing.vim),不管系统剪贴板还是vim自带的寄存器你要做的只是按下Ctrl-y所有复制的内容都会出现并支持快捷键操作.. 

    ![yankring](https://cloud.githubusercontent.com/assets/4246425/4692255/904aff64-5756-11e4-9fe5-3b1d1575e0e8.png)

11, [自动补全的字典](https://github.com/tracyone/dict),[ultisnips的个人snippets](https://github.com/tracyone/snippets),[个人收集的编程专用字体](https://github.com/tracyone/program_font),[vim主题包](https://github.com/tracyone/Colour-Sampler-Pack)


```vim
"插件列表
Bundle 'a.vim'
Bundle 'tracyone/dict'
Bundle 'EasyGrep'
Bundle 'verilog.vim'
Bundle 'tracyone/Align'
Bundle 'tracyone/calendar'
Bundle 'tracyone/Colour-Sampler-Pack'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'delimitMate.vim'
Bundle 'FuzzyFinder'
Bundle 'genutils'
"Bundle 'youjumpiwatch/vim-neoeclim'
Bundle 'mhinz/vim-startify'
Bundle 'Shougo/neomru.vim'
Bundle 'SirVer/ultisnips'
Bundle 'YankRing.vim'
Bundle 'tracyone/snippets'
Bundle 'dosbatch-indent'
if g:iswindows==0
    Bundle 'sudo.vim'
endif
if ( has("patch885") || version == 704 ) && has('lua')
    let g:use_neocomplete=1
else
    let g:use_neocomplete=0
endif
if g:use_neocomplete==1
    Bundle 'Shougo/neocomplete'
elseif g:use_neocomplete==0
    Bundle 'Shougo/neocomplcache'
endif
Bundle 'The-NERD-Commenter'
Bundle 'tracyone/nerdtree'
Bundle 'ShowMarks7'
Bundle 'surround.vim'
Bundle 'majutsushi/tagbar'
Bundle 'Shougo/unite.vim'
Bundle 'L9'
Bundle 'mattn/emmet-vim'
Bundle 'vimwiki/vimwiki'
Bundle 'VimRepress'
Bundle 'hsitz/VimOrganizer'
Bundle 'adah1972/fencview'
if g:iswindows==0
    Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
endif
Bundle 'DrawIt'
Bundle 'mbbill/VimExplorer'
Bundle 'renamer.vim'
Bundle  'hari-rangarajan/CCTree'
Bundle 'tracyone/mark.vim'
Bundle 'tracyone/MyVimHelp'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/vimshell.vim'
Bundle 'git://github.com/sjl/gundo.vim.git'
if g:iswindows == 1
    Bundle 'tracyone/pyclewn' 
else
    Bundle 'tracyone/pyclewn_linux' 
endif
Bundle 'hallison/vim-markdown'
Bundle 'greyblake/vim-preview'
```


# build_vim

`build_vim.sh`是一个可以在MinGw(Win32下的gcc编译器,或者说gnu命令行集合环境)下运行的shell脚本,它的功能就是从源代码中编译可在win32平台下的运行的gvim和vim。在运行脚本之前你必须安装以下必要的组件:

1. 安装[msys2](msys2.github.io)，安装好msys2之后通过msys2的pacman来安装Mingw-w64或者mingw-32
2. 安装[python](https://www.python.org/downloads/)，包括python2和python3
3. 安装[perl](http://strawberryperl.com/)
4. 安装[tcl](http://www.activestate.com/activetcl/downloads)
5. 安装[ruby](https://www.ruby-lang.org/en/downloads/)
6. 安装[lua](http://luabinaries.sourceforge.net/)下载其中的`Windows Libraries`和`Tools Executable`，后者编译是要用到，前者运行时gvim时要用到
7. 安装[git](https://msysgit.github.io/),安装好之后将git命令所在路径加入Path变量

安装完毕之后，请修改该脚本上对应变量的值，主要包括各个组件的安装路径，安装vim的路径还有vim源代码要放置的路径。


**语法**

```bash
./build_vim.sh all|gvim|vim|clean|install|getsrc|uninstall|ext  
```
  usage:build_vim all|gvim|vim|clean|install|getsrc|uninstall|ext

  all:            build gvim and vim then install

  gvim:           get src if not exist then build gvim

  vim:            get src if not exist then build vim

  install:        install gvim

  uninstall:      uninstall vim

  getsrc:         use git command to get vim's source or update

  ext:            Install Fonts and External Tools


# Visual Studio配置文件

效果如下图，导入配置文件到vs之后，还需要你设置VsVim的选项，将所有快捷键按照VsVim的控制。请把`_vsvimrc`放置于`$HOME`所在位置。

![整体效果](https://cloud.githubusercontent.com/assets/4246425/7606246/b51015a2-f989-11e4-81b1-b0a8936351ec.PNG)

![vsvim](https://cloud.githubusercontent.com/assets/4246425/7606244/b09dd4fa-f989-11e4-925c-4fb3472b92d0.PNG)

