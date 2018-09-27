WARMOD_HOME_URL="https://forums.alliedmods.net/showthread.php?t=225474"
WARMOD_URL="https://warmod.bitbucket.io/plugins/warmod.smx"
WARMOD_VERSION="17.08.12.1053"

all: build

contrib:
	@echo "$(TARGET) warmod $(WARMOD_VERSION) $(WARMOD_HOME_URL) $(WARMOD_URL)"

dl:
	wget $(WARMOD_URL) -O warmod.smx

build: dl
	cp -f warmod.smx $(MODS_PLUGINS)/

clean:
	\rm -f warmod.smx
