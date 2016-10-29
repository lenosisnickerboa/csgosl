MULTI1V1_HOME_URL="https://github.com/splewis/csgo-multi-1v1"
MULTI1V1_URL="https://github.com/splewis/csgo-multi-1v1/releases/download/1.1.4/multi1v1_1.1.4.zip"
MULTI1V1_VERSION="1.1.4"

all: build

contrib:
	@echo "$(TARGET) multi1v1 $(MULTI1V1_VERSION) $(MULTI1V1_HOME_URL) $(MULTI1V1_URL)"

dl:
	wget $(MULTI1V1_URL) -O multi_1v1.zip

build: dl
	mkdir -p multi_1v1_out
	(cd multi_1v1_out ; unzip -o ../multi_1v1.zip)
	cp -af multi_1v1_out/addons/sourcemod/* $(MODS_SOURCEMOD_ROOT)/
	cp -af multi_1v1_out/cfg/sourcemod/* $(MODS_CONFIGS)/
	\rm -rf multi_1v1_out

clean:
	\rm -f multi_1v1.zip
	\rm -rf multi_1v1_out
