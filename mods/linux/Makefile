#Linux
TARGET=linux
METAMOD_HOME_URL="http://www.metamodsource.net/"
METAMOD_URL="http://www.gsptalk.com/mirror/sourcemod/mmsource-1.10.6-linux.tar.gz"
METAMOD_VERSION="1.10.6"
SOURCEMOD_HOME_URL="http://www.sourcemod.net/"
SOURCEMOD_URL="http://www.sourcemod.net/smdrop/1.7/sourcemod-1.7.3-git5302-linux.tar.gz"
SOURCEMOD_VERSION="1.7.3-git5302"

all: mods

contribs:
	@echo "$(TARGET) metamod $(METAMOD_VERSION) $(METAMOD_HOME_URL) $(METAMOD_URL)"
	@echo "$(TARGET) sourcemod $(SOURCEMOD_VERSION) $(SOURCEMOD_HOME_URL) $(SOURCEMOD_URL)"

metamod:
	wget $(METAMOD_URL) -O metamod.tar.gz

sourcemod:
	wget $(SOURCEMOD_URL) -O sourcemod.tar.gz

mods: metamod sourcemod
	\rm -rf mods >/dev/null 2>&1
	mkdir mods
	(cd mods ; tar xzvpf ../metamod.tar.gz)	
	(cd mods ; tar xzvpf ../sourcemod.tar.gz)
	cp ../metamod.vdf mods/addons/
	(cd mods ; zip -r ../mods.zip *)
	\rm -rf mods >/dev/null 2>&1

clean:
	\rm -f metamod.tar.gz sourcemod.tar.gz mods.zip

