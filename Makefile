PREFIX        = /usr/local
EXEC          = tspreed
BINDIR        = $(DESTDIR)$(PREFIX)/bin
BIN           = $(BINDIR)/$(EXEC)
MANDIR        = $(DESTDIR)$(PREFIX)/share/man/man1
MANFILE       = $(EXEC).1
MAN           = $(MANDIR)/$(MANFILE)
CONFGLOBALDIR = $(DESTDIR)/etc/$(EXEC)
CONFGLOBAL    = $(CONFGLOBALDIR)/$(EXEC).rc

# Mainly for non-GNU Make
SHELL = /bin/sh

default: help

install:
# Install executable
	mkdir -p $(BINDIR)
	cp $(EXEC) $(BIN)
	chmod 755 $(BIN)
# Install man page
	mkdir -p $(MANDIR)
	cp $(MANFILE) $(MAN)
	chmod 644 $(MAN)
# Install global config
	mkdir -p $(CONFGLOBALDIR)
	cp default.rc $(CONFGLOBAL)
	chmod 644 $(CONFGLOBAL)

uninstall:
# Uninstall executable
	rm -f $(BIN)
# Uninstall man page
	rm -f $(MAN)

purge: uninstall
# Remove global config dir
	rm -rf $(CONFGLOBALDIR)
# Notify of local configs
	@echo "NOTE: Local configs may still exist in your home directory. These will need to be removed manually if so desired."

help:
	@echo ""
	@echo "             Display help"
	@echo "  install    Install $(EXEC)"
	@echo "  uninstall  Uninstall $(EXEC), preserve global config directory"
	@echo "  purge      Uninstall $(EXEC), remove global config directory"
	@echo "  help       Display help"
	@echo ""

.PHONY: default install uninstall purge help
