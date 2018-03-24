#Linux
include common.mk
export

all: cfgs

.PHONY: contribs
contribs:
	$(MAKE) -C ../cfgs/esl_serverconfig contrib

.PHONY: cfgs
cfgs: 
	\rm -rf $(CFGS_ROOT) cfgs.zip >/dev/null 2>&1
	mkdir -p $(CFGS_ROOT)
	$(MAKE) -C ../cfgs/esl_serverconfig
	(cd $(CFGS_ROOT) ; zip -r ../cfgs.zip *)
	\rm -rf $(CFGS_ROOT) >/dev/null 2>&1

clean:
	$(MAKE) -C ../cfgs/esl_serverconfig clean
	\rm -f cfgs.zip
