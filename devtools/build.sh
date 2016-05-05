#!/bin/bash

function error() {
    echo "ERROR: $@"
    exit 1
}

function install() {
    local dest="$1"
    [ ! -d "$dest" ] && error "install $@: directory \"$dest\" does not exist"
    shift
    for i in "$@" ; do
	echo "Installing \"$i\" -> \"$dest\""
	cp "$i" "$dest/" || error "Failed to copy file \"$i\" into \"$dest\""
    done
}

function installmv() {
    local dest="$1"
    [ ! -d "$dest" ] && error "installmv $@: directory \"$dest\" does not exist"
    shift
    for i in "$@" ; do
	echo "Installing (mv) \"$i\" -> \"$dest\""
	mv "$i" "$dest/" || error "Failed to mv file \"$i\" into \"$dest\""
    done
}

function installdir() {
    for i in "$@" ; do
	echo "Installing directory \"$i\""
	mkdir -p "$i" || error "Failed to create directory \"$i\""
    done    
}

function rmall() {
    for i in "$@" ; do
	if [ -d "$i" ] ; then
	    echo "Removing directory \"$i\""
	    \rm -rf "$i" || error "Failed to remove directory \"$i\""
	elif [ -f "$i" ] ; then
	    echo "Removing file \"$i\""
	    \rm -f "$i" || error "Failed to remove file \"$i\""
	fi
    done    
}

#main

ROOT=`readlink -f $1`
TARGET="$2"
DEST="$3"

[ -z "$TARGET" ] && error "No target stated!"
echo "Building target $TARGET"
[ -z "$DEST" ] && error "No destination stated!"
mkdir -p "$DEST" || error "Failed to create directory $DEST"
\rm -rf $DEST/* >/dev/null 2>&1

SDX=$ROOT/devtools/linux/sdx.kit
[ ! -f "$SDX" ] && error "Can't find executable sdx!"
TCLKIT=$ROOT/devtools/linux/tclkit
[ ! -x "$TCLKIT" ] && error "Can't find executable tclkit!"

case $TARGET in 
    linux)
	installdir $DEST/csgosl $DEST/bin $DEST/mods
	install $DEST/mods "$ROOT"/mods/linux/mods.zip "$ROOT"/mods/linux/mods-risky.zip
	install $DEST/bin "$ROOT"/src/*.tcl "$ROOT"/src/pics/*.jpg "$ROOT"/src/pics/*.png
	install $DEST "$ROOT"/src/linux/csgosl.sh
	install $DEST/bin "$ROOT"/src/linux/server.sh
	touch $DEST/bin/needsupgrade
	(cd "$DEST"/.. ; zip -r csgosl.zip csgosl) || error "Failed to zip"
	(cd "$DEST"/.. ;  mv csgosl.zip csgosl-linux.zip)
	;;
    windows)
	installdir $DEST/csgosl.vfs $DEST/csgosl.vfs/lib $DEST/bin $DEST/mods
	install $DEST/mods "$ROOT"/mods/windows/mods.zip "$ROOT"/mods/windows/mods-risky.zip
	install $DEST/csgosl.vfs "$ROOT"/src/*.tcl "$ROOT"/src/pics/*.jpg "$ROOT"/src/pics/*.png
	$TCLKIT $SDX unwrap "$ROOT"/devtools/windows/img.kit || error "Failed to unwrap img.kit"
	install $DEST/csgosl.vfs/lib img.vfs/lib/Img/*
	rmall img.vfs
	(cd $DEST ; $TCLKIT $SDX wrap csgosl.kit) || error "Failed to wrap $DEST/csgosl.vfs to $DEST/csgosl.kit"
	installmv $DEST/bin $DEST/csgosl.kit
	rmall $DEST/csgosl.vfs
	install $DEST/bin \
	    "$ROOT"/src/windows/server-start.bat \
	    "$ROOT"/src/windows/server-autorestart.bat \
	    "$ROOT"/src/windows/server-status.bat \
	    "$ROOT"/src/windows/server-stop.bat \
	    "$ROOT"/src/windows/csgoslw.bat \
	    "$ROOT"/devtools/windows/unzip.exe \
	    "$ROOT"/devtools/windows/wget.exe \
	    $ROOT/devtools/windows/tclkit.exe
	install $DEST "$ROOT"/src/windows/csgosl.vbs
	touch $DEST/bin/needsupgrade
	(cd "$DEST"/.. ; zip -r csgosl.zip csgosl) || error "Failed to zip"
	(cd "$DEST"/.. ;  mv csgosl.zip csgosl-windows.zip)
	;;
    *)
	error "Unknown target $TARGET!"
esac

