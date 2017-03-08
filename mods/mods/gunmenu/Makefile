GUNMENU_HOME_URL="https://forums.alliedmods.net/showthread.php?t=259355"
GUNMENU_URL="http://www.sourcemod.net/vbcompiler.php?file_id=142936"
GUNMENU_URL_2="https://forums.alliedmods.net/attachment.php?attachmentid=142937&d=1457263823"
GUNMENU_VERSION="1.2"

all: build

contrib:
	@echo "$(TARGET) gunmenu $(GUNMENU_VERSION) $(GUNMENU_HOME_URL) $(GUNMENU_URL)"

dl:
	wget $(GUNMENU_URL) -O csgo_gunmenu.smx
	wget $(GUNMENU_URL_2) -O gunmenu.ini

build: dl
	cp -f csgo_gunmenu.smx $(MODS_PLUGINS)/
	cp -f gunmenu.ini $(MODS_CONFIGS)/

clean:
	\rm -f csgo_gunmenu.smx gunmenu.ini
