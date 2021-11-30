.POSIX:

SHELL    = /bin/sh
PREFIX   = /usr/local
EXEC     = tspreed
CONFVALS = default.rc
BINDIR   = $(DESTDIR)$(PREFIX)/bin
BIN      = $(BINDIR)/$(EXEC)
MANDIR   = $(DESTDIR)$(PREFIX)/share/man/man1
MAN      = $(MANDIR)/$(EXEC).1
CONFDIR  = $(DESTDIR)/etc/$(EXEC)
CONF     = $(CONFDIR)/$(EXEC).rc
PERMREG  = 644
PERMEXE  = 755

help:
	@echo
	@echo "             Display help"
	@echo "  install    Install $(EXEC)"
	@echo "  update     Update $(EXEC) installation, preserve global config"
	@echo "  uninstall  Uninstall $(EXEC), preserve global config directory"
	@echo "  purge      Uninstall $(EXEC), remove global config directory"
	@echo "  test       Test $(EXEC) via ShellCheck"
	@echo "  help       Display help"
	@echo

install:
	@mkdir -p $(BINDIR) && cp $(EXEC) $(BIN) && chmod $(PERMEXE) $(BIN) && echo "Installed $(BIN)"
	@mkdir -p $(MANDIR) && cp $(EXEC).1 $(MAN) && chmod $(PERMREG) $(MAN) && echo "Installed $(MAN)"
	@mkdir -p $(CONFDIR) && cp $(CONFVALS) $(CONF) && chmod $(PERMREG) $(CONF) && echo "Installed $(CONF)"

update:
	@cp -f $(EXEC) $(BIN) && chmod $(PERMEXE) $(BIN) && echo "Updated $(BIN)"
	@cp -f $(EXEC).1 $(MAN) && chmod $(PERMREG) $(MAN) && echo "Updated $(MAN)"
	@if [ ! -f "$(CONF)" ]; then cp $(CONFVALS) $(CONF) && chmod $(PERMREG) $(CONF) && echo "Updated $(CONF)"; fi

uninstall:
	@if [ -f "$(BIN)" ]; then rm -f $(BIN) && echo "Uninstalled $(BIN)"; else echo "$(BIN) does not exist, cannot uninstall"; fi
	@if [ -f "$(MAN)" ]; then rm -f $(MAN) && echo "Uninstalled $(MAN)"; else echo "$(MAN) does not exist, cannot uninstall"; fi

purge: uninstall
	@if [ -d "$(CONFDIR)" ]; then rm -rf $(CONFDIR) && echo "Removed $(CONFDIR)"; else echo "$(CONFDIR) does not exist, cannot remove"; fi
	@echo "NOTE: \$$XDG_CONFIG_HOME/$(EXEC) (~/.config/$(EXEC) if not defined) may still exist. This will need to be removed manually if so desired."

test:
	@-shellcheck $(EXEC) && echo "./$(EXEC) passed ShellCheck"
	@-shellcheck -s sh -e SC2034 $(CONFVALS) && echo "./$(CONFVALS) passed ShellCheck"

.PHONY: help install update uninstall purge test
