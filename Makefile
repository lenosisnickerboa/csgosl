OUT=out
CONTRIBOUT=contribs.txt
CONTRIBOUTTCL=src/contribs.tcl

all: clean contribs windows linux

install:
	$(MAKE) -C devtools/linux
	$(MAKE) -C devtools/windows
	$(MAKE) -C mods/linux
	$(MAKE) -C mods/windows

install-clean:
	$(MAKE) -C devtools/linux clean
	$(MAKE) -C devtools/windows clean
	$(MAKE) -C mods/linux clean
	$(MAKE) -C mods/windows clean

contribs:
	$(MAKE) --silent contribs-doit > $(CONTRIBOUT)
	devtools/contrib.sh < $(CONTRIBOUT) > $(CONTRIBOUTTCL)

contribs-doit:
	$(MAKE) -C devtools/linux contribs
	$(MAKE) -C devtools/windows contribs
	$(MAKE) -C mods/linux contribs
	$(MAKE) -C mods/windows contribs

zip:
	(cd .. ; tar czvpf csgosl-`date +"%Y%m%d-%H%M%S"`.tgz csgosl --exclude csgosl/.git)

windows:
	devtools/build.sh . windows $(OUT)/windows/csgosl

linux:
	devtools/build.sh . linux $(OUT)/linux/csgosl

clean:
	\rm -rf $(OUT) >/dev/null 2>&1
	find . -name *~ -exec \rm -f {} \;

