WARMOD_HOME_URL="https://forums.alliedmods.net/showthread.php?t=225474"
WARMOD_URL="http://warmod.bitbucket.org/plugins/warmod.smx"
WARMOD_VERSION="16.10.12.1911"

all: build

contrib:
	@echo "$(TARGET) warmod $(WARMOD_VERSION) $(WARMOD_HOME_URL) $(WARMOD_URL)"

dl:
	wget $(WARMOD_URL) -O warmod.smx

build: dl
	cp -f warmod.smx $(MODS_PLUGINS)/

clean:
	\rm -f warmod.smx
