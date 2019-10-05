SHANAPU_MYWEAPONALLOCATOR_HOME_URL="https://github.com/shanapu/MyWeaponAllocator"
SHANAPU_MYWEAPONALLOCATOR_URL="https://github.com/shanapu/MyWeaponAllocator/blob/master/plugins/MyWeaponAllocator.smx"
SHANAPU_MYWEAPONALLOCATOR_VERSION="2019-08-25"

all: build

contrib:
	@echo "$(TARGET) shanapu_myweaponallocator $(SHANAPU_MYWEAPONALLOCATOR_VERSION) $(SHANAPU_MYWEAPONALLOCATOR_HOME_URL) $(SHANAPU_MYWEAPONALLOCATOR_URL)"

dl:
	wget $(SHANAPU_MYWEAPONALLOCATOR_URL) -O MyWeaponAllocator.smx

build: dl
	cp -f MyWeaponAllocator.smx $(MODS_PLUGINS)/

clean:
	\rm -f MyWeaponAllocator.smx
