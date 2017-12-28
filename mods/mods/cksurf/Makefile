CKSURF_HOME_URL="https://forums.alliedmods.net/showthread.php?t=264498"
CKSURF_URL="https://forums.alliedmods.net/attachment.php?attachmentid=153717&d=1460462158"
CKSURF_VERSION="1.18"

all: build

contrib:
	@echo "$(TARGET) cksurf $(CKSURF_VERSION) $(CKSURF_HOME_URL) $(CKSURF_URL)"

dl:
	wget $(CKSURF_URL) -O cksurf.zip

build: dl
	\rm -rf zipped >/dev/null 2>&1
	mkdir zipped
	(cd zipped ; unzip -o ../cksurf.zip)
	cp -af zipped/csgo/* $(MODS_ROOT)/
	\rm -rf zipped

clean:
	\rm -rf zipped cksurf.zip
