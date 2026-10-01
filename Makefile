# ==================================================================================
# General

MN_SRC   := lib/makinori
MN_LIB   := $(MN_SRC)/build/lib
MN_ARS   := $(MN_LIB)/libmakinori.a $(MN_LIB)/liblua.a $(MN_LIB)/libwebsockets.a

CC        = clang
CPPFLAGS  = -D_DEFAULT_SOURCE -D_GNU_SOURCE -D_POSIX_C_SOURCE=202405L
CFLAGS    = -std=c23 -Wall -Werror -I$(MN_SRC)/include
LDFLAGS   =
LDLIBS    =

# ==================================================================================
# Recipes

.PHONY: clean prune

manage: LDLIBS += -lmakinori -llua -lm -lwebsockets
manage: LDFLAGS += -L$(MN_LIB)
manage: manage.o $(MN_ARS)
	$(CC) $(CPPFLAGS) $< -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)

$(MN_ARS):
	cd $(MN_SRC) && $(MAKE) BUILD_TYPE=Release

clean:
	find . -name "*.o" -not -path "./lib/*" -delete
	if [ -f manage ]; then rm manage; fi

prune: clean
	if [ -d lib/makinori/build ]; then rm -r lib/makinori/build; fi
