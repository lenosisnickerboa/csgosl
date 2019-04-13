#Linux
include common.mk
export

all: cfgs

.PHONY: contribs
contribs:
	$(MAKE) -C ../cfgs/wargames_theswemaster contrib
	$(MAKE) -C ../cfgs/esl_serverconfig contrib
	$(MAKE) -C ../cfgs/rcon_buttons contrib

.PHONY: cfgs
cfgs: 
	\rm -rf $(CFGS_ROOT) cfgs.zip >/dev/null 2>&1
	mkdir -p $(CFGS_ROOT)
	$(MAKE) -C ../cfgs/wargames_theswemaster
	$(MAKE) -C ../cfgs/esl_serverconfig
	$(MAKE) -C ../cfgs/rcon_buttons
	(cd $(CFGS_ROOT) ; zip -r ../cfgs.zip *)
	\rm -rf $(CFGS_ROOT) >/dev/null 2>&1

clean:
	$(MAKE) -C ../cfgs/esl_serverconfig clean
	$(MAKE) -C ../cfgs/wargames_theswemaster clean
	$(MAKE) -C ../cfgs/rcon_buttons clean
	\rm -f cfgs.zip
