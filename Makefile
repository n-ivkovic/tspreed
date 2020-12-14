USERNAME      = $(shell logname)
USERHOME      = $(shell echo ~$(USERNAME))/
ifneq (${XDG_CONFIG_HOME},)
CONFIGHOME    = ${XDG_CONFIG_HOME}/
else
CONFIGHOME    = $(USERHOME).config/
endif
EXEC          = tspreed
BINDIR        = /usr/local/bin/
BIN           = $(BINDIR)$(EXEC)
MANSECTION    = 1
MANDIR        = /usr/local/share/man/man$(MANSECTION)/
MANFILE       = $(EXEC).$(MANSECTION)
MAN           = $(MANDIR)$(MANFILE)
CONFGLOBALDIR = /etc/$(EXEC)/
CONFGLOBAL    = $(CONFGLOBALDIR)$(EXEC).rc
CONFLOCALDIR  = $(CONFIGHOME)$(EXEC)/

.PHONY: defualt
default: help

.PHONY: install
install:
# Install executable
ifneq ($(wildcard $(BIN)),)
	@echo "$(EXEC) already installed in $(BINDIR)"
else
	@mkdir -p $(BINDIR)
	@cp $(EXEC) $(BIN)
	@chmod 755 $(BIN)
	@echo "Installed $(EXEC) in $(BINDIR)"
endif
# Install man page
ifneq ($(wildcard $(MAN)),)
	@echo "Man page $(MANFILE) already exists"
else
	@mkdir -p $(MANDIR)
	@cp $(MANFILE) $(MAN)
	@chown 644 $(MAN)
	@echo "Created man page $(MAN)"
endif
# Install global config
ifneq ($(wildcard $(CONFGLOBAL)),)
	@echo "Global config $(CONFGLOBAL) already exists"
else
	@mkdir -p $(CONFGLOBALDIR)
	@cp default.rc $(CONFGLOBAL)
	@chown 644 $(CONFGLOBAL)
	@echo "Created global config $(CONFGLOBAL)"
endif
# Create local config directory
ifneq ($(wildcard $(CONFLOCALDIR).*),)
	@echo "Local config directory $(CONFLOCALDIR) already exists"
else
	@mkdir -p $(CONFLOCALDIR)
	@echo "Created local config directory $(CONFLOCALDIR)"
endif

.PHONY: uninstall
uninstall:
# Uninstall executable
ifeq ($(wildcard $(BIN)),)
	@echo "$(EXEC) not installed in $(BINDIR)"
else
	@rm -f $(BIN)
	@echo "Uninstalled $(EXEC) from $(BINDIR)"
endif
# Uninstall man page
ifeq ($(wildcard $(MAN)),)
	@echo "Man page $(MAN) does not exist"
else
	@rm -f $(MAN)
	@echo "Removed man page $(MAN)"
endif

.PHONY: purge
purge: uninstall
# Remove global config dir
ifeq ($(wildcard $(CONFGLOBALDIR).*),)
	@echo "Global config directory $(CONFGLOBALDIR) does not exist"
else
	@rm -rf $(CONFGLOBALDIR)
	@echo "Removed global config directory $(CONFGLOBALDIR)"
endif
# Remove local config dir
ifeq ($(wildcard $(CONFLOCALDIR).*),)
	@echo "Local config directory $(CONFLOCALDIR) does not exist"
else
	@rm -rf $(CONFLOCALDIR)
	@echo "Removed local config directory $(CONFLOCALDIR)"
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
