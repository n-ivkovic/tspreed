USERNAME   = $(shell logname)
USERGROUP  = $(shell id -g $(USERNAME))
USERHOME   = $(shell echo ~$(USERNAME))/
ifneq (${XDG_CONFIG_HOME},)
CONFIGHOME = ${XDG_CONFIG_HOME}/
else
CONFIGHOME = $(USERHOME).config/
endif
MANSEC     = 1
EXEC       = tspreed
BINDIR     = /usr/local/bin/
MANDIR     = /usr/local/share/man/man$(MANSEC)/
CONFGLOBAL = /etc/$(EXEC)/
CONFLOCAL  = $(CONFIGHOME)$(EXEC)/
CONFFILE   = $(EXEC).rc

.PHONY: defualt
default: help

.PHONY: install
install:
# Install executable
ifneq ($(wildcard $(BINDIR)$(EXEC)),)
	@echo "$(EXEC) already installed in $(BINDIR)"
else
	@mkdir -p $(BINDIR)
	@cp $(EXEC) $(BINDIR)$(EXEC)
	@chmod 755 $(BINDIR)$(EXEC)
	@echo "Installed $(EXEC) in $(BINDIR)"
endif
# Install man page
ifneq ($(wildcard $(MANDIR)$(EXEC).$(MANSEC)*),)
	@echo "Man page $(MANDIR)$(EXEC).$(MANSEC) already exists"
else
	@mkdir -p $(MANDIR)
	@cp $(EXEC).$(MANSEC) $(MANDIR)
	@chown 644 $(MANDIR)$(EXEC).$(MANSEC)
	@echo "Created man page $(MANDIR)$(EXEC).$(MANSEC)"
endif
# Create global config
ifneq ($(wildcard $(CONFGLOBAL)$(CONFFILE)),)
	@echo "Global config $(CONFGLOBAL)$(CONFFILE) already exists"
else
	@mkdir -p $(CONFGLOBAL)
	@touch $(CONFGLOBAL)$(CONFFILE)
	@echo "Created global config $(CONFGLOBAL)$(CONFFILE)"
endif
# Create local config with default values
ifneq ($(wildcard $(CONFLOCAL)$(CONFFILE)),)
	@echo "Local config $(CONFLOCAL)$(CONFFILE) already exists"
else
	@mkdir -p $(CONFLOCAL)
	@touch $(CONFLOCAL)$(CONFFILE)
	@chown -R $(USERNAME):$(USERGROUP) $(CONFLOCAL)
	@printf "wpm=300\nhidecursor=true\nfocuspointer=line\nfocusbold=true\nfocuscolor=1\n" >> $(CONFLOCAL)$(CONFFILE)
	@echo "Created local config $(CONFLOCAL)$(CONFFILE) with default values"
endif

.PHONY: uninstall
uninstall:
# Uninstall executable
ifeq ($(wildcard $(BINDIR)$(EXEC)),)
	@echo "$(EXEC) is not installed in $(BINDIR)"
else
	@rm -f $(BINDIR)$(EXEC)	
	@echo "Uninstalled $(EXEC) from $(BINDIR)"
endif
# Uninstall man page
ifeq ($(wildcard $(MANDIR)$(EXEC).$(MANSEC)*),)
	@echo "Man page $(MANDIR)$(EXEC).$(MANSEC) does not exist"
else
	@rm -f $(MANDIR)$(EXEC).$(MANSEC)
	@echo "Removed man page $(MANDIR)$(EXEC).$(MANSEC)"
endif

.PHONY: purge
purge: uninstall
# Remove global config dir
ifeq ($(wildcard $(CONFGLOBAL).*),)
	@echo "Global config directory $(CONFGLOBAL) does not exist"
else
	@rm -rf $(CONFGLOBAL)
	@echo "Removed global config directory $(CONFGLOBAL)"
endif
# Remove local config dir
ifeq ($(wildcard $(CONFLOCAL).*),)
	@echo "Local config directory $(CONFLOCAL) does not exist"
else
	@rm -rf $(CONFLOCAL)
	@echo "Removed local config directory $(CONFLOCAL)"
endif

.PHONY: help
help:
	@echo ""
	@echo "             Display help"
	@echo "  install    Install $(EXEC)"
	@echo "  uninstall  Uninstall $(EXEC), preserve config directories"
	@echo "  purge      Uninstall $(EXEC), remove config directories"
	@echo "  help       Display help"
	@echo ""
