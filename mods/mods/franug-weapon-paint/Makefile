FRANUG_WEAPON_PAINTS_HOME_URL="https://github.com/Franc1sco/Franug-Weapon_Paints"
FRANUG_WEAPON_PAINTS_URL="https://github.com/Franc1sco/Franug-Weapon_Paints/archive/fc7178d.zip"
FRANUG_WEAPON_PAINTS_VERSION="sha-fc7178d-2016-05-05"

all: build

contrib:
	@echo "$(TARGET) franug_weapon_paints $(FRANUG_WEAPON_PAINTS_VERSION) $(FRANUG_WEAPON_PAINTS_HOME_URL) $(FRANUG_WEAPON_PAINTS_URL)"

dl:
	wget $(FRANUG_WEAPON_PAINTS_URL) -O franug-weapon-paint.zip

build: dl
	unzip -o franug-weapon-paint.zip
	cp -f databases.cfg $(MODS_CONFIGS)/
	(cd Franug-Weapon_Paints-* ; mkdir -p $(MODS_CONFIGS) && cp -f csgo_wpaints.cfg $(MODS_CONFIGS)/)
	(cd Franug-Weapon_Paints-* ; mkdir -p $(MODS_PLUGINS)/disabled && cp -f franug_weaponpaints_public.smx $(MODS_PLUGINS)/disabled/)
	(cd Franug-Weapon_Paints-* ; mkdir -p $(MODS_TRANSLATIONS) && cp -f franug_weaponpaints.phrases.txt $(MODS_TRANSLATIONS)/)
	\rm -rf Franug-Weapon_Paints-*

clean:
	\rm -f franug-weapon-paint.zip
	\rm -rf Franug-Weapon_Paints-*
