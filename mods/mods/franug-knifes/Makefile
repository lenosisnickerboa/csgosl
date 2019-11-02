FRANUG_KNIFES_HOME_URL="https://github.com/Franc1sco/Franug-Knifes"
FRANUG_KNIFES_URL="https://github.com/Franc1sco/Franug-Knifes/archive/ff449c6.zip"
FRANUG_KNIFES_VERSION="sha-ff449c6-2016-05-05"

all: build

contrib:
	@echo "$(TARGET) franug_knifes $(FRANUG_KNIFES_VERSION) $(FRANUG_KNIFES_HOME_URL) $(FRANUG_KNIFES_URL)"

dl:
	#support discontinued, not downloading any more
	#wget $(FRANUG_KNIFES_URL) -O franug-knifes.zip
	cp franug-knifes.zip.downloaded franug-knifes.zip

build: dl
	unzip -o franug-knifes.zip
	(cd Franug-Knifes-* ; mkdir -p $(MODS_CONFIGS) && cp -f csgo_knives.cfg $(MODS_CONFIGS)/)
	(cd Franug-Knifes-* ; mkdir -p $(MODS_PLUGINS)/disabled && cp -f sm_franugknife.smx $(MODS_PLUGINS)/disabled/)
	\rm -rf Franug-Knifes-*

clean:
	\rm -f franug-knifes.zip
	\rm -rf Franug-Knifes-*
