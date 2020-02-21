OS = $(shell uname -s)
USERNAME = $(shell logname)
USERGROUP = $(shell id -g $(USERNAME))
USERHOME = $(shell echo ~$(USERNAME))/
EXEC = tspreed
PREFIX = /usr/local/bin/
MANDIR = /usr/local/share/man/man1/
CONFGLOBAL = /etc/$(EXEC)/
CONFLOCAL = $(USERHOME).config/$(EXEC)/
CONFFILE = $(EXEC).rc

.PHONY: defualt install uninstall purge help
default: help

install:
# Install executable
ifneq ($(wildcard $(PREFIX)$(EXEC)),)
	@echo "$(EXEC) already installed in $(PREFIX)"
else
	@cp $(EXEC).sh $(EXEC)
	@install -d $(PREFIX)
	@install $(EXEC) $(PREFIX)
	@rm -f $(EXEC)
	@echo "$(EXEC) installed in $(PREFIX)"
endif
# Create global config
ifneq ($(wildcard $(CONFGLOBAL)$(CONFFILE)),)
	@echo "$(CONFGLOBAL)$(CONFFILE) already exists"
else
	@mkdir -p $(CONFGLOBAL)
	@touch $(CONFGLOBAL)$(CONFFILE)
	@echo "Created $(CONFGLOBAL)$(CONFFILE)"
endif
# Create local config with default values
ifneq ($(wildcard $(CONFLOCAL)$(CONFFILE)),)
	@echo "$(CONFLOCAL)$(CONFFILE) already exists"
else
	@mkdir -p $(CONFLOCAL)
	@touch $(CONFLOCAL)$(CONFFILE)
	@chown -R $(USERNAME):$(USERGROUP) $(CONFLOCAL)
	@printf "wpm=300\nfocuspointer=line\nfocusbold=true\nfocuscolor=1\n" >> $(CONFLOCAL)$(CONFFILE)
	@echo "Created $(CONFLOCAL)$(CONFFILE) with default values"
endif
# Install man page
ifneq ($(wildcard $(MANDIR)$(EXEC).1*),)
	@echo "$(MANDIR)$(EXEC).1 already exists"
else
	@mkdir -p $(MANDIR)
	@cp man/$(EXEC).1 $(MANDIR)
	@echo "Created $(MANDIR)$(EXEC).1"
endif

uninstall:
# Uninstall executable
ifeq ($(wildcard $(PREFIX)$(EXEC)),)
	@echo "$(EXEC) is not installed in $(PREFIX)"
else
	@rm -f $(PREFIX)$(EXEC)	
	@echo "$(EXEC) uninstalled from $(PREFIX)"
endif
# Uninstall man page
ifeq ($(wildcard $(MANDIR)$(EXEC).1*),)
	@echo "$(MANDIR)$(EXEC).1 does not exist"
else
	@rm -f $(MANDIR)$(EXEC).1
	@echo "Removed man page $(MANDIR)$(EXEC).1"
endif

purge: uninstall
# Remove global config dir
ifeq ($(wildcard $(CONFGLOBAL).*),)
	@echo "$(CONFGLOBAL) does not exist"
else
	@rm -rf $(CONFGLOBAL)
	@echo "Removed global config directory $(CONFGLOBAL)"
endif
# Remove local config dir
ifeq ($(wildcard $(CONFLOCAL).*),)
	@echo "$(CONFLOCAL) does not exist"
else
	@rm -rf $(CONFLOCAL)
	@echo "Removed local config directory $(CONFLOCAL)"
endif

help:
	@echo ""
	@echo "             Display help"
	@echo "  install    Install $(EXEC)"
	@echo "  uninstall  Uninstall $(EXEC), preserve config directories"
	@echo "  purge      Uninstall $(EXEC), remove config directories"
	@echo "  help       Display help"
	@echo ""
