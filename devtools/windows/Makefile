#Windows

TARGET=windows
TCLKIT_HOME_URL="http://sourceforge.net/projects/twapi"
TCLKIT_URL="http://downloads.sourceforge.net/project/twapi/Tcl%20binaries/Tclkits%20with%20TWAPI/Older%20Releases/tclkit-gui-8_6_4-twapi-4_1_27-x86-max.exe"
TCLKIT_VERSION="8_6_4-twapi-4_1_27-x86-max"
SDX_HOME_URL="http://code.google.com/archive/p/tclkit/"
SDX_URL="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/tclkit/sdx-20110317.kit"
SDX_VERSION="20110317"
UNZIP_HOME_URL="http://www.info-zip.org/UnZip.html"
UNZIP_URL="ftp://ftp.info-zip.org/pub/infozip/win32/unz600xn.exe"
UNZIP_VERSION="6.00"
IMG_HOME_URL="http://www.tcl.tk/starkits/"
IMG_URL="http://www.tcl.tk/starkits/img.kit"
IMG_VERSION="1.3"
WGET_HOME_URL="https://www.gnu.org/software/wget"
WGET_URL="https://eternallybored.org/misc/wget/releases/wget-1.21.3-win32.zip"
WGET_VERSION="1.21.3-win32"

all: wget tclkit sdx img unzip

contribs:
	@echo "$(TARGET) tclkit $(TCLKIT_VERSION) $(TCLKIT_HOME_URL) $(TCLKIT_URL)"
	@echo "$(TARGET) sdx $(SDX_VERSION) $(SDX_HOME_URL) $(SDX_URL)"
	@echo "$(TARGET) unzip $(UNZIP_VERSION) $(UNZIP_HOME_URL) $(UNZIP_URL)"
	@echo "$(TARGET) img $(IMG_VERSION) $(IMG_HOME_URL) $(IMG_URL)"
	@echo "$(TARGET) wget $(WGET_VERSION) $(WGET_HOME_URL) $(WGET_URL)"

tclkit:
	wget $(TCLKIT_URL) -O tclkit.exe
	chmod +x tclkit.exe

sdx:
	wget $(SDX_URL) -O sdx.kit

img:
	wget $(IMG_URL) -O img.kit

unzip:
	wget $(UNZIP_URL) -O unzip-self-extract.exe
	unzip -o unzip-self-extract.exe -d exclude_me
	cp exclude_me/unzip.exe .
	chmod +x unzip.exe

wget:
	wget $(WGET_URL) -O wget.zip
	unzip -o wget.zip -d exclude_me
	cp exclude_me/wget.exe .
	chmod +x wget.exe

clean:
	\rm -f tclkit.exe sdx.kit img.kit unzip-self-extract.exe unzip.exe
	\rm -rf exclude_me
