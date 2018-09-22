#Windows
TARGET=windows
include ../common.mk
METAMOD_HOME_URL="http://www.metamodsource.net/"
METAMOD_URL="https://mms.alliedmods.net/mmsdrop/1.10/mmsource-1.10.7-git966-windows.zip"
METAMOD_VERSION="1.10.7-git966"
SOURCEMOD_HOME_URL="http://www.sourcemod.net/"
SOURCEMOD_URL="https://sm.alliedmods.net/smdrop/1.9/sourcemod-1.9.0-git6252-windows.zip"
SOURCEMOD_VERSION="1.9.0-git6252"
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
	$(MAKE) -C ../mods/cksurf contrib
	$(MAKE) -C ../mods/retakes contrib

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
	$(MAKE) -C ../mods/cksurf
	$(MAKE) -C ../mods/retakes
	$(DEVTOOLS_ROOT)/merge_databases_cfg.sh $(CSGOSL_ROOT)/mods/databases.cfg $(shell find $(CSGOSL_ROOT)/mods/*/ -name databases.cfg) > $(MODS_CONFIGS)/databases.cfg
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
	$(MAKE) -C ../mods/cksurf clean
	$(MAKE) -C ../mods/retakes clean
	\rm -f metamod.zip sourcemod.zip mods*.zip
