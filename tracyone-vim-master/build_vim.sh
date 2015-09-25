#!/bin/bash
# author        :tracyone
# date          :2013-08-11/10:54:37
# description   :build gvim/vim from src;install;clean;
# usage         :usage:./build_vim all|gvim|vim|clean|install|getsrc
#                       "all:build gvim and vim then install
#                       "gvim:get src if not exist then build gvim"
#                       "vim:get src if not exist then build vim"
#                       "install:install gvim
#                       "getsrc:use hg command to get vim\'s source "
# MACRO Define {{{

# Please modify following Variable according your need

# MINGW or CYGWIN
COMPILER=MINGW

# where your vim want to install..
INSTALL_DIR="/e/program_files/Vim"

# Where is the source directory of vim
VIM_SRC_DIR="${HOME}/work/vim_src"

MAKE=mingw32-make

# Who compile the vim..
USERNAME="tracyone\\<tracyone "
USERDOMAIN="live.cn\\>"


#0x0500 win2k,0x0501 winxp,0x0601 win7,0x0602 win8,0x0A00 win10
WINVER=0x0A00

# CPU arch
# i386 or x86-64
ARCH=x86-64

# static link libstdc++
STATIC_STDCPLUS=yes

# lua support
LUA=/e/program_files/lua
LUA_VER=53
DYNAMIC_LUA=yes

# python2 support
PYTHON=/e/program_files/Python27
DYNAMIC_PYTHON=yes
PYTHON_VER=27

# python3 support
PYTHON3=/e/program_files/Python32
DYNAMIC_PYTHON3=yes
PYTHON3_VER=32

# ruby support
RUBY=/e/program_files/Ruby200-x64
DYNAMIC_RUBY=yes
RUBY_VER=20
RUBY_VER_LONG=2.0.0

# tcl support
TCL=/e/program_files/Tcl
TCL_VER=86
DYNAMIC_TCL=yes

# perl support
PERL=/e/program_files/Perl64
PERL_VER=522
DYNAMIC_PERL=yes

CUR_DIR="$(pwd)"
OS=$(uname)

if [[ ${COMPILER} == "MINGW" ]]; then
	MAKEFILE=Make_ming.mak
elif [[ ${COMPILER} == "CYGWIN" ]]; then
	MAKEFILE=Make_cyg.mak
	if [[  "${ARCH}" == "x86-64" ]]; then
		CROSS_COMPILE=x86_64-w64-mingw32-
	else
		CROSS_COMPILE=i686-pc-mingw32-
	fi
else
	echo -e "Unknown compiler:${COMPILER}"
	exit 1
fi

# }}}
# Function Define {{{

function configure()
{
	local package_lack=""
	for i in $1
	do
		which $i > /tmp/build_vim.log 2>&1
		if [[ $? -ne 0 ]]; then
			echo -e "Checking for $i ..... no"
			package_lack="$i ${package_lack}"
		else
			echo -e "Checking for $i ..... yes"
		fi
	done	
	if [[ ${package_lack} != "" ]]; then
		echo "Please install ${package_lack} manually!"
		exit 3
	fi
}

function getsrc(){
if [[ -d ${VIM_SRC_DIR} && -d ${VIM_SRC_DIR}/.git ]]; then
    echo -e "we found vim src directory!"
	if [[ $1 == [yY] ]]; then
		cd ${VIM_SRC_DIR}/src
		${MAKE} -f Make_ming.mak clean
		cd -;cd ${VIM_SRC_DIR}
		git checkout -- "*"
		git pull
		cd -
		return
	fi
	read -n1 -p  'Do you want to upadte vim source??(y/n)[n]' UPDATE_OR_NOT
    if [[ "${UPDATE_OR_NOT}" == [yY] ]]; then
        cd ${VIM_SRC_DIR}/src
        ${MAKE} -f Make_ming.mak clean
		cd -;cd ${VIM_SRC_DIR}
        git checkout -- "*"
		git pull
        cd -
        return
      else
        return
    fi
fi

# get source
echo -e "get vim src from the internet!"
echo -e "This may take for a moment"
sleep 2
echo -e "clone vim src to local.... "
git clone https://github.com/vim/vim ${VIM_SRC_DIR}
while [ "$?" -ne 0 ]
do
    echo "Try again,press ctrl-c to exit"
    sleep 3
    rm -rf ${VIM_SRC_DIR}
    git clone https://github.com/vim/vim ${VIM_SRC_DIR}
done
}

function build_vim(){
getsrc
cd ${VIM_SRC_DIR}/src
if [[ "$1" == "vim" || "$1" == "all" ]];then
    ${MAKE} -f ${MAKEFILE} FEATURES=HUGE ARCH=${ARCH}  \
	STATIC_STDCPLUS=${STATIC_STDCPLUS} \
    GUI=no \
    OLE=YES \
    WINVER=${WINVER} \
    DIRECTX=yes \
    LUA=${LUA} LUA_VER=${LUA_VER} DYNAMIC_LUA=${DYNAMIC_LUA} \
    PYTHON=${PYTHON} DYNAMIC_PYTHON=${DYNAMIC_PYTHON} PYTHON_VER=${PYTHON_VER} \
    PYTHON3=${PYTHON3} DYNAMIC_PYTHON3=${DYNAMIC_PYTHON3} PYTHON3_VER=${PYTHON3_VER} \
    RUBY=${RUBY} DYNAMIC_RUBY=${DYNAMIC_RUBY} RUBY_VER=${RUBY_VER} RUBY_VER_LONG=${RUBY_VER_LONG} \
    TCL=${TCL} TCL_VER=${TCL_VER} DYNAMIC_TCL=${DYNAMIC_TCL} \
    PERL=${PERL} PERL_VER=${PERL_VER} DYNAMIC_PERL=${DYNAMIC_PERL} \
    USERNAME=${USERNAME} USERDOMAIN=${USERDOMAIN}
    if [ "$?" -ne 0 ]; then
		ErrorPrint
    fi
fi

if [[ "$1" == "gvim"  || "$1" == "all" ]];then
  ${MAKE} -f ${MAKEFILE} FEATURES=HUGE ARCH=${ARCH} \
  STATIC_STDCPLUS=${STATIC_STDCPLUS} \
  GUI=yes \
  OLE=yes \
  WINVER=${WINVER} \
  DIRECTX=yes \
  LUA=${LUA} LUA_VER=${LUA_VER} DYNAMIC_LUA=${DYNAMIC_LUA} \
  PYTHON=${PYTHON} DYNAMIC_PYTHON=${DYNAMIC_PYTHON} PYTHON_VER=${PYTHON_VER} \
  PYTHON3=${PYTHON3} DYNAMIC_PYTHON3=${DYNAMIC_PYTHON3} PYTHON3_VER=${PYTHON3_VER} \
  RUBY=${RUBY} DYNAMIC_RUBY=${DYNAMIC_RUBY} RUBY_VER=${RUBY_VER} RUBY_VER_LONG=${RUBY_VER_LONG} \
  TCL=${TCL} TCL_VER=${TCL_VER} DYNAMIC_TCL=${DYNAMIC_TCL} \
  PERL=${PERL} PERL_VER=${PERL_VER} DYNAMIC_PERL=${DYNAMIC_PERL} \
  USERNAME=${USERNAME} USERDOMAIN=${USERDOMAIN}
    if [ "$?" -ne 0 ]
    then
		ErrorPrint
    fi
fi
cd ../..

}


function install(){
mkdir -p "${INSTALL_DIR}/vim74"
cd ${VIM_SRC_DIR}
mkdir vim74
echo -e "start copy...\n"
cp -a runtime/* vim74
cp -a src/*.exe vim74
cp -a src/GvimExt/gvimext.dll vim74
cp -a src/xxd/xxd.exe vim74
cp -a vimtutor.bat vim74
cp -a vim74/* "${INSTALL_DIR}/vim74"
PTHREAD_DLL=$(find / -name "*libwinpthread*.dll" | head -n 1)
cp ${PTHREAD_DLL} "${INSTALL_DIR}/vim74"
cp ${CUR_DIR}/_vimrc "${INSTALL_DIR}"
echo -e "copy finish...\n"
echo -e "start install....\n"
rm -rf vim74
cd ${INSTALL_DIR}/vim74/
echo -e "Pleaese double click the \"install.exe\",input d then enter..\n"
explorer .
cd -
cd ..
}

function ErrorPrint()
{
	echo "Make sure you have installed softwares below:"
	echo "ruby${RUBY_VER_LONG} in ${RUBY}"
	echo "python${PYTHON3_VER} in ${PYTHON}"
	echo "python${PYTHON_VER} in ${PYTHON3}"
	echo "tcl${TCL_VER} in ${TCL}"
	echo "lua51 in ${LUA}"
	echo "perl${PERL_VER} in ${PERL}"
	exit 3
}

function UsagePrint()
{
    echo -e "Error!!!lack of argument."
    echo -e "usage:\tbuild_vim all|gvim|vim|clean|install|getsrc|ext"
    echo -e "all:\tbuild gvim and vim then install"
    echo -e "gvim:\tget src if not exist then build gvim"
    echo -e "vim:\tget src if not exist then build vim"
    echo -e "install:install gvim"
    echo -e "getsrc:\tuse git command to get vim\'s source or update "
    echo -e "ext:\tInstall Fonts and External Tools "
    exit 3;
}
# }}}
# Script start...{{{
configure "git ${MAKE} cp rm mv mkdir uname"
pattern='(MINGW|MSYS).*'
if [[ ! ${OS} =~ $pattern  ]]; then
	echo -e "Unsupport OS:${OS}.MINGW and msys are support!"
	exit 3
fi
if [ "$#" -ne 1 ]; then
    UsagePrint
else
    read -n1 -p  "Input the directory you want to install Vim[${INSTALL_DIR}]" user_input
    if [[ "${user_input}" == "" || "${user_input}" == [yY] ]]; then
		echo "Default to ${INSTALL_DIR}"
    else
        while [[ ! -d "${user_input}" ]]; do
            echo "The ${user_input} is not exist,we will create it!"
            mkdir "${user_input}"
            if [[ $? -ne 0 ]]; then
                echo "Create ${user_input} failed"
                read -p "Input another directory you want to install Vim[/d/Program Files/Vim]" user_input
            fi
        done
        INSTALL_DIR=${user_input}
    fi

	read -n1 -p  "Input the directory  of the vim source code[${VIM_SRC_DIR}]" user_input
    if [[ "${user_input}" == "" || "${user_input}" == [yY] ]]; then
        echo "Default to ${VIM_SRC_DIR}"
    else
        while [[ ! -d "${user_input}" ]]; do
            echo "The ${user_input} is not exist,input again"
            read -p "Input the directory  of the vim source code" user_input
        done
        VIM_SRC_DIR=${user_input}

    fi
	echo -e "arch:\t\t${ARCH}\ncompiler:\t${COMPILER}\nDest Dir:\t${INSTALL_DIR}\nOS:\t\t${OS}"
    if [ "$1" == "gvim" ]; then
        build_vim gvim
    elif [ "$1" == "vim" ]; then
        build_vim vim
    elif [ "$1" == "clean" ]; then
        cd ${VIM_SRC_DIR}/src
        rm -rf obji386/
        rm -rf gobji386/
        rm -rf gobjx86-64/
        ${MAKE} -f Make_ming.mak clean
    elif [ "$1" == "install" ]; then
        install
    elif [ "$1" == "getsrc" ]; then
        getsrc y
    elif [ "$1" == "all" ]; then
        build_vim all
        install
    elif [ "$1" == "ext" ]; then
		echo -e "Install Externanl Tools...\n"
		configure "pacman"
		pacman -S ctags cscope
		echo -e "Install fonts...\n"
		if [[  ! -d program_font ]]; then
			git clone https://github.com/tracyone/program_font
		fi
		cd program_font
		cp -a * /c/Windows/Fonts
		cd -
		rm -rf program_font
		echo -e "Install fonts finish...\n"
    else
		UsagePrint
    fi
fi
# }}}
# vim: set ft=sh fdm=marker foldlevel=0 foldmarker&:

