# ==================================================================================
# General

MN_SRC   := lib/makinori
MN_BIN   := $(MN_SRC)/build/bin
MN_LIB   := $(MN_SRC)/build/lib
MN_ARS   := $(MN_LIB)/libmakinori.a $(MN_LIB)/liblua.a $(MN_LIB)/libwebsockets.a

CC        = clang
CPPFLAGS  = -D_DEFAULT_SOURCE -D_GNU_SOURCE -D_POSIX_C_SOURCE=202405L
CFLAGS    = -std=c23 -Wall -Werror -I$(MN_SRC)/include
LDFLAGS   =
LDLIBS    =

# ==================================================================================
# Recipes

.PHONY: all clean docs prune

all: manage

manage: LDLIBS += -lmakinori -llua -lm -lwebsockets
manage: LDFLAGS += -L$(MN_LIB)
manage: manage.o $(MN_ARS)
	$(CC) $(CPPFLAGS) $< -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)

$(MN_ARS):
	cd $(MN_SRC) && $(MAKE) BUILD_TYPE=Release

docs:
	cd $(MN_SRC) && $(MAKE) docs
	echo "#!/bin/sh" > docs
	echo "cd $(MN_SRC) && exec build/bin/docs" >> docs
	chmod +x docs

clean:
	find . -name "*.o" -not -path "./lib/*" -delete
	if [ -f manage ]; then rm manage; fi
	if [ -f docs ]; then rm docs; fi

prune: clean
	if [ -d lib/makinori/build ]; then rm -r lib/makinori/build; fi
