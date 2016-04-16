#Linux

TARGET=linux
TCLKIT_HOME_URL="http://tclkits.rkeene.org"
TCLKIT_URL="http://tclkits.rkeene.org/fossil/raw/tclkit-8.6.3-rhel5-ix86?name=b0ec9ce34c13c4bcc2d9dffcd359da9aaf80d807"
TCLKIT_VERSION="8.6.3-rhel5-ix86"
TCLKIT_HOME_URL="http://code.google.com/archive/p/tclkit/"
SDX_URL="http://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/tclkit/sdx-20110317.kit"
SDX_VERSION="20110317"

all: tclkit sdx

contribs:

contribs-disabled:
	@echo "$(TARGET) tclkit $(TCLKIT_VERSION) $(TCLKIT_HOME_URL) $(TCLKIT_URL)"
	@echo "$(TARGET) sdx $(SDX_VERSION) $(SDX_HOME_URL) $(SDX_URL)"

#http://tclkits.rkeene.org/fossil/wiki/Downloads
tclkit:
	wget $(TCLKIT_URL) -O tclkit
	chmod +x tclkit

sdx:
	wget $(SDX_URL) -O sdx.kit

clean:
	\rm -f tclkit sdx.kit
