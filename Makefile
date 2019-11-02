ifndef CSGOSL_ROOT
$(error CSGOSL_ROOT is not set, source env.sh in root directory)
endif

OUT=$(CSGOSL_ROOT)/out
CONTRIBOUT=$(CSGOSL_ROOT)/contribs.txt
CONTRIBOUTTCL=$(CSGOSL_ROOT)/src/contribs.tcl

all: clean contribs windows linux

install-devtools:
	$(MAKE) -C devtools/linux
	$(MAKE) -C devtools/windows

install-mods:
	$(MAKE) -C mods/linux
	$(MAKE) -C mods/windows

install-cfgs:
	$(MAKE) -C cfgs

install: install-devtools install-mods install-cfgs

clean-devtools:
	$(MAKE) -C devtools/linux clean
	$(MAKE) -C devtools/windows clean

clean-mods:
	$(MAKE) -C mods/linux clean
	$(MAKE) -C mods/windows clean

clean-cfgs:
	$(MAKE) -C cfgs clean

install-clean: clean-devtools clean-mods clean-cfgs

contribs:
	$(MAKE) --silent contribs-doit > $(CONTRIBOUT)
	devtools/contrib.sh < $(CONTRIBOUT) > $(CONTRIBOUTTCL)

contribs-doit:
	$(MAKE) -C devtools/linux contribs
	$(MAKE) -C devtools/windows contribs
	$(MAKE) -C mods/linux contribs
	$(MAKE) -C mods/windows contribs
	$(MAKE) -C cfgs contribs

zip:
	(cd .. ; tar czvpf csgosl-`date +"%Y%m%d-%H%M%S"`.tgz --exclude csgosl/.git csgosl)

windows: src/cvars.tcl
	devtools/build.sh . windows $(OUT)/windows/csgosl

linux: src/cvars.tcl
	devtools/build.sh . linux $(OUT)/linux/csgosl

clean:
	\rm -rf $(OUT) >/dev/null 2>&1
	find . -name *~ -exec \rm -f {} \;

src/cvars.tcl:	devtools/cvarslist.txt
	devtools/cvarslist2tcl.sh devtools/cvarslist.txt > src/cvars.tcl
