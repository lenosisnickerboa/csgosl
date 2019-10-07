SPLEWIS_PUGSETUP_HOME_URL="https://forums.alliedmods.net/showthread.php?t=244114"
SPLEWIS_PUGSETUP_URL="https://github.com/splewis/csgo-pug-setup/releases/download/2.0.5/pugsetup_2.0.5.zip"
SPLEWIS_PUGSETUP_VERSION="2.0.5"

all: build

contrib:
	@echo "$(TARGET) splewis_pugsetup $(SPLEWIS_PUGSETUP_VERSION) $(SPLEWIS_PUGSETUP_HOME_URL) $(SPLEWIS_PUGSETUP_URL)"

dl:
	wget $(SPLEWIS_PUGSETUP_URL) -O pugsetup.zip

build: dl
	\rm -rf zipped >/dev/null 2>&1
	mkdir zipped
	(cd zipped ; unzip -o ../pugsetup.zip)
	chmod -R 777 zipped
	cp -af zipped/* $(MODS_ROOT)/
	\rm -rf zipped

clean:
	\rm -rf zipped pugsetup.zip
