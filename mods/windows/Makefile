#Windows
TARGET=windows
METAMOD_HOME_URL="http://www.metamodsource.net/"
METAMOD_URL="http://mirror.pointysoftware.net/alliedmodders/mmsource-1.10.6-windows.zip"
METAMOD_VERSION="1.10.6"
SOURCEMOD_HOME_URL="http://www.sourcemod.net/"
SOURCEMOD_URL="https://www.sourcemod.net/smdrop/1.7/sourcemod-1.7.3-git5302-windows.zip"
SOURCEMOD_VERSION="1.7.3-git5302"

all: mods

contribs:
	@echo "$(TARGET) metamod $(METAMOD_VERSION) $(METAMOD_HOME_URL) $(METAMOD_URL)"
	@echo "$(TARGET) sourcemod $(SOURCEMOD_VERSION) $(SOURCEMOD_HOME_URL) $(SOURCEMOD_URL)"

metamod:
	wget $(METAMOD_URL) -O metamod.zip

sourcemod:
	wget $(SOURCEMOD_URL) -O sourcemod.zip

mods: metamod sourcemod
	\rm -rf mods >/dev/null 2>&1
	mkdir mods
	(cd mods ; unzip -o ../metamod.zip)	
	(cd mods ; unzip -o ../sourcemod.zip)
	cp ../metamod.vdf mods/addons/
	(cd mods ; zip -r ../mods.zip *)
	\rm -rf mods >/dev/null 2>&1

clean:
	\rm -f metamod.zip sourcemod.zip mods.zip
