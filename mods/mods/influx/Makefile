INFLUX_HOME_URL="https://influxtimer.com/"
INFLUX_URL="https://influxtimer.com/dl/influx_12_full.zip"
INFLUX_VERSION="1.2_2018-12-09"

all: build

contrib:
	@echo "$(TARGET) influx $(INFLUX_VERSION) $(INFLUX_HOME_URL) $(INFLUX_URL)"

dl:
	wget $(INFLUX_URL) -O influx.zip

build: dl
	\rm -rf zipped >/dev/null 2>&1
	mkdir zipped
	(cd zipped ; unzip -o ../influx.zip)
	cp -af zipped/* $(MODS_ROOT)/
	\rm -rf zipped

clean:
	\rm -rf zipped influx.zip
