RETAKES_HOME_URL="https://github.com/splewis/csgo-retakes"
RETAKES_URL="https://github.com/splewis/csgo-retakes/releases/download/v0.3.3/retakes_0.3.3.zip"
RETAKES_VERSION="0.3.3"

all: build

contrib:
	@echo "$(TARGET) retakes $(RETAKES_VERSION) $(RETAKES_HOME_URL) $(RETAKES_URL)"

dl:
	wget $(RETAKES_URL) -O retakes.zip

build: dl
	mkdir -p retakes_out
	(cd retakes_out ; unzip -o ../retakes.zip)
	cp -af retakes_out/addons/sourcemod/* $(MODS_SOURCEMOD_ROOT)/
	cp -af retakes_out/cfg/sourcemod/* $(MODS_CONFIGS)/
	\rm -rf retakes_out

clean:
	\rm -f retakes.zip
	\rm -rf retakes_out
