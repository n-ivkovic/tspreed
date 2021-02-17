.POSIX:

SHELL   = /bin/sh
PREFIX  = /usr/local
EXEC    = tspreed
BINDIR  = $(DESTDIR)$(PREFIX)/bin
BIN     = $(BINDIR)/$(EXEC)
MANDIR  = $(DESTDIR)$(PREFIX)/share/man/man1
MAN     = $(MANDIR)/$(EXEC).1
CONFDIR = $(DESTDIR)/etc/$(EXEC)
CONF    = $(CONFDIR)/$(EXEC).rc

help:
	@echo
	@echo "             Display help"
	@echo "  install    Install $(EXEC)"
	@echo "  uninstall  Uninstall $(EXEC), preserve global config directory"
	@echo "  purge      Uninstall $(EXEC), remove global config directory"
	@echo "  help       Display help"
	@echo

install:
	@mkdir -p $(BINDIR) && cp $(EXEC) $(BIN) && chmod 755 $(BIN) && echo "Installed $(BIN)"
	@mkdir -p $(MANDIR) && cp $(EXEC).1 $(MAN) && chmod 644 $(MAN) && echo "Installed $(MAN)"
	@[ ! -f "$(CONF)" ] && mkdir -p $(CONFDIR) && cp default.rc $(CONF) && chmod 644 $(CONF) && echo "Installed $(CONF)"

uninstall:
	@rm -f $(BIN) && echo "Uninstalled $(BIN)"
	@rm -f $(MAN) && echo "Uninstalled $(MAN)"

purge: uninstall
	@rm -rf $(CONFDIR) && echo "Removed $(CONFDIR)"
	@echo "NOTE: ~/.config/$(EXEC) (XDG_CONFIG_HOME/$(EXEC) if defined) may still exist. This will need to be removed manually if so desired."

.PHONY: help install uninstall purge
