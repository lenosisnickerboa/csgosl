ESL_SERVERCONFIG_HOME_URL="https://play.eslgaming.com/download/26251762/"
ESL_SERVERCONFIG_URL="https://play.eslgaming.com/download/get/?file=26251762&mirror=2211"
ESL_SERVERCONFIG_VERSION="18/01/2016"

all: build

contrib:
	@echo "all esl_serverconfig $(ESL_SERVERCONFIG_VERSION) $(ESL_SERVERCONFIG_HOME_URL) $(ESL_SERVERCONFIG_URL)"

dl:
#	wget $(ESL_SERVERCONFIG_URL) -O esl_serverconfig.zip
	cp esl_serverconfig.zip.downloaded esl_serverconfig.zip

build: dl
	mkdir -p esl_serverconfig_out
	(cd esl_serverconfig_out ; unzip -o ../esl_serverconfig.zip)
	mkdir -p $(CFGS_ROOT)/onserverstart
	cp -af esl_serverconfig_out/csgo_esl_serverconfig/* $(CFGS_ROOT)/onserverstart
	\rm -rf esl_serverconfig_out

clean:
	\rm -f esl_serverconfig.zip
	\rm -rf esl_serverconfig_out
