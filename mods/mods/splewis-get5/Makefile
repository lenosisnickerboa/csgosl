SPLEWIS_GET5_HOME_URL="https://github.com/splewis/get5"
SPLEWIS_GET5_URL="https://github.com/splewis/get5/releases/download/0.7.1/get5_0.7.1.zip"
SPLEWIS_GET5_VERSION="0.7.1"

all: build

contrib:
	@echo "$(TARGET) splewis_get5 $(SPLEWIS_GET5_VERSION) $(SPLEWIS_GET5_HOME_URL) $(SPLEWIS_GET5_URL)"

dl:
	wget $(SPLEWIS_GET5_URL) -O get5.zip

build: dl
	\rm -rf zipped >/dev/null 2>&1
	mkdir zipped
	(cd zipped ; unzip -o ../get5.zip)
	chmod -R 777 zipped
	cp -af zipped/* $(MODS_ROOT)/
	\rm -rf zipped
	cp -af get5_match.cfg $(MODS_ROOT)/

clean:
	\rm -rf zipped get5.zip
