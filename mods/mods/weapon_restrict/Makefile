WEAPON_RESTRICT_HOME_URL="https://forums.alliedmods.net/showthread.php?p=950174"
WEAPON_RESTRICT_URL="https://forums.alliedmods.net/attachment.php?attachmentid=162251&d=1492626443"
WEAPON_RESTRICT_VERSION="3.1.7"

all: build

contrib:
	@echo "$(TARGET) weapon_restrict $(WEAPON_RESTRICT_VERSION) $(WEAPON_RESTRICT_HOME_URL) $(WEAPON_RESTRICT_URL)"

dl:
	wget $(WEAPON_RESTRICT_URL) -O weapon_restrict.zip

build: dl
	\rm -rf zipped >/dev/null 2>&1
	mkdir zipped
	(cd zipped ; unzip -o ../weapon_restrict.zip)
	cp -af zipped/* $(MODS_ROOT)/
	\rm -rf zipped

clean:
	\rm -rf zipped weapon_restrict.zip
