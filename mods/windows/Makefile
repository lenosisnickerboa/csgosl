#Windows
TARGET=windows
include ../common.mk
METAMOD_HOME_URL="http://www.metamodsource.net/"
METAMOD_URL="http://mirror.pointysoftware.net/alliedmodders/mmsource-1.10.6-windows.zip"
METAMOD_VERSION="1.10.6"
SOURCEMOD_HOME_URL="http://www.sourcemod.net/"
SOURCEMOD_URL="https://www.sourcemod.net/smdrop/1.8/sourcemod-1.8.0-git5982-windows.zip"
SOURCEMOD_VERSION="1.8.0-git5982"
export

all: mods

contribs:
	@echo "$(TARGET) metamod $(METAMOD_VERSION) $(METAMOD_HOME_URL) $(METAMOD_URL)"
	@echo "$(TARGET) sourcemod $(SOURCEMOD_VERSION) $(SOURCEMOD_HOME_URL) $(SOURCEMOD_URL)"
	$(MAKE) -C ../mods/franug-knifes contrib
	$(MAKE) -C ../mods/franug-weapon-paint contrib
	$(MAKE) -C ../mods/warmod contrib
	$(MAKE) -C ../mods/multi1v1 contrib
	$(MAKE) -C ../mods/gunmenu contrib

dl-metamod:
	wget $(METAMOD_URL) -O metamod.zip

dl-sourcemod:
	wget $(SOURCEMOD_URL) -O sourcemod.zip

mods: dl-metamod dl-sourcemod
	\rm -rf $(MODS_ROOT) mods*.zip >/dev/null 2>&1
	mkdir -p $(MODS_ROOT)
	(cd $(MODS_ROOT) ; unzip -o ../metamod.zip)	
	(cd $(MODS_ROOT) ; unzip -o ../sourcemod.zip)
	$(MAKE) -C ../mods/warmod
	$(MAKE) -C ../mods/multi1v1
	$(MAKE) -C ../mods/gunmenu
	(cd $(MODS_ROOT) ; zip -r ../mods.zip *)
	\rm -rf $(MODS_ROOT) >/dev/null 2>&1
	mkdir -p $(MODS_ROOT)
	$(MAKE) -C ../mods/franug-knifes
	$(MAKE) -C ../mods/franug-weapon-paint
	(cd $(MODS_ROOT) ; zip -r ../mods-risky.zip *)
	\rm -rf $(MODS_ROOT) >/dev/null 2>&1

clean:
	$(MAKE) -C ../mods/franug-knifes clean
	$(MAKE) -C ../mods/franug-weapon-paint clean
	$(MAKE) -C ../mods/warmod clean
	$(MAKE) -C ../mods/multi1v1 clean
	$(MAKE) -C ../mods/gunmenu clean
	\rm -f metamod.zip sourcemod.zip mods*.zip
