#Linux
TARGET=linux
include ../common.mk
METAMOD_HOME_URL="http://www.metamodsource.net/"
METAMOD_URL="https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git1148-linux.tar.gz"
METAMOD_VERSION="1.11.0-git1148"
SOURCEMOD_HOME_URL="http://www.sourcemod.net/"
SOURCEMOD_URL="https://sm.alliedmods.net/smdrop/1.11/sourcemod-1.11.0-git6936-linux.tar.gz"
SOURCEMOD_VERSION="1.11.0-git6936"
export

all: mods

contribs:
	@echo "$(TARGET) metamod $(METAMOD_VERSION) $(METAMOD_HOME_URL) $(METAMOD_URL)"
	@echo "$(TARGET) sourcemod $(SOURCEMOD_VERSION) $(SOURCEMOD_HOME_URL) $(SOURCEMOD_URL)"
	$(MAKE) -C ../mods/franug-knifes contrib
	$(MAKE) -C ../mods/franug-weapon-paint contrib
	$(MAKE) -C ../mods/weapon_restrict contrib
	$(MAKE) -C ../mods/warmod contrib
	$(MAKE) -C ../mods/multi1v1 contrib
	$(MAKE) -C ../mods/gunmenu contrib
	$(MAKE) -C ../mods/cksurf contrib
	$(MAKE) -C ../mods/retakes contrib
	$(MAKE) -C ../mods/influx contrib
	$(MAKE) -C ../mods/splewis-get5 contrib
	$(MAKE) -C ../mods/shanapu-myweaponallocator contrib
	$(MAKE) -C ../mods/splewis-pugsetup contrib

dl-metamod:
	wget $(METAMOD_URL) -O metamod.tar.gz

dl-sourcemod:
	wget $(SOURCEMOD_URL) -O sourcemod.tar.gz

mods: dl-metamod dl-sourcemod
	\rm -rf $(MODS_ROOT) mods*.zip >/dev/null 2>&1
	mkdir -p $(MODS_ROOT)
	(cd $(MODS_ROOT) ; tar xzvpf ../metamod.tar.gz)
	(cd $(MODS_ROOT) ; tar xzvpf ../sourcemod.tar.gz)
	$(MAKE) -C ../mods/weapon_restrict
	$(MAKE) -C ../mods/warmod
	$(MAKE) -C ../mods/multi1v1
	$(MAKE) -C ../mods/gunmenu
	$(MAKE) -C ../mods/cksurf
	$(MAKE) -C ../mods/retakes
	$(MAKE) -C ../mods/influx
	$(MAKE) -C ../mods/splewis-get5
	$(MAKE) -C ../mods/shanapu-myweaponallocator
	$(MAKE) -C ../mods/splewis-pugsetup
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
	$(MAKE) -C ../mods/weapon_restrict clean
	$(MAKE) -C ../mods/warmod clean
	$(MAKE) -C ../mods/multi1v1 clean
	$(MAKE) -C ../mods/gunmenu clean
	$(MAKE) -C ../mods/cksurf clean
	$(MAKE) -C ../mods/retakes clean
	$(MAKE) -C ../mods/influx clean
	$(MAKE) -C ../mods/splewis-get5 clean
	$(MAKE) -C ../mods/shanapu-myweaponallocator clean
	$(MAKE) -C ../mods/splewis-pugsetup clean
	\rm -f metamod.tar.gz sourcemod.tar.gz mods*.zip
