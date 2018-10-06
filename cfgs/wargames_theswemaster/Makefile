WARGAMES_THESWEMASTER_HOME_URL="https://gamebanana.com/scripts/9907"
WARGAMES_THESWEMASTER_URL="http://download1654.mediafire.com/cwsd0u8q7e9g/sy0covtybh6j7gx/wargames.cfg"
WARGAMES_THESWEMASTER_VERSION="2017-06-01"

all: build

contrib:
	@echo "all wargames_theswemaster $(WARGAMES_THESWEMASTER_VERSION) $(WARGAMES_THESWEMASTER_HOME_URL) $(WARGAMES_THESWEMASTER_URL)"

dl:
	wget $(WARGAMES_THESWEMASTER_URL) -O wargames_theswemaster.cfg

build: dl
	mkdir -p wargames_theswemaster_out
	cp -af wargames_theswemaster.cfg wargames_theswemaster_out/
	mkdir -p $(CFGS_ROOT)/onserverstart
	cp -af wargames_theswemaster_out/* $(CFGS_ROOT)/onserverstart/
	\rm -rf wargames_theswemaster_out

clean:
	\rm wargames_theswemaster.cfg
	\rm -rf wargames_theswemaster_out
