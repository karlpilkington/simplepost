# SimplePost - A Simple HTTP Server
#
# Copyright (C) 2012-2014 Karl Lenz.  All rights reserved.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have recieved a copy of the GNU General Public
# License along with this program; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 021110-1307, USA.

###############################################################################

# Project name
PROJECT_NAME := simplepost

# Target binary to be produced
TARGET := $(PROJECT_NAME)

# List of C source files
CSRCS := $(shell find . -type f -name '*.c' | cut -d '/' -f 2-)

# List of the objects files to be made
OBJECTS := $(CSRCS:.c=.o)

# Binary output directory (must include a trailing / if set)
OUTPUT_PATH := ../bin/

# Installation directories
PREFIX ?= /usr/local

# Application optimization used during compilation and linking:
# -O0, -O1, -O2, -O3 or -Os
ifdef DEBUG
OPTIMIZATION := -O0
else
OPTIMIZATION := -O2
endif

# List of include paths
INCLUDES :=

# List of search paths for libraries
LIB_PATH :=

# List of libraries to use during linking
LIBS := -lpthread -lmagic -lmicrohttpd

# C compiler options
CFLAGS := -xc -c -std=c11
CFLAGS += $(OPTIMIZATION)
CFLAGS += -D_POSIX_C_SOURCE=200112L -D_BSD_SOURCE -DSIMPLEPOST
ifdef DEBUG
CFLAGS += -DDEBUG -g
CFLAGS += -fno-inline -fno-diagnostics-show-option
CFLAGS += -Wall -Wextra -Werror
CFLAGS += -Wno-error=unused-parameter -Wno-error=unused-function -Wno-error=unused-result
else
CFLAGS += -D_FORTIFY_SOURCE=2
CFLAGS += -fstack-protector --param=ssp-buffer-size=4
CFLAGS += -Wcast-align -Wimplicit -Wpointer-arith -Wswitch
CFLAGS += -Wredundant-decls -Wreturn-type -Wshadow
CFLAGS += -Wno-unused-result -Wunused-variable
CFLAGS += -Wformat -Wformat-security
endif

# Linker options
LDFLAGS := $(OPTIMIZATION) $(LIB_PATH)
ifndef DEBUG
LDFLAGS += -s
endif
LDFLAGS += -Wl,-z,relro -Wl,--as-needed

# Static analyzer options
SAFLAGS := --language=c --std=c11
SAFLAGS += -DDEBUG=1 -DSIMPLEPOST
SAFLAGS += --enable=warning --enable=style --enable=portability --enable=performance
ifdef DEBUG
SAFLAGS += --verbose
endif

# Executable definitions
CC := gcc
SA := cppcheck
OBJDUMP := objdump
SIZE := size
RM := rm -f
RMDIR := rmdir
INSTALL := install

###############################################################################

.PHONY: all
all: build

.PHONY: build
build: $(TARGET)

.PHONY: rebuild
rebuild: clean build

.PHONY: install
install:
	$(INSTALL) -d -m 0755 $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -m 0755 $(OUTPUT_PATH)$(TARGET) $(DESTDIR)$(PREFIX)/bin/$(TARGET)

$(TARGET): $(OBJECTS)
	@[ "x$(OUTPUT_PATH)" = "x" ] || $(INSTALL) -d -m 0755 $(OUTPUT_PATH)
	$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $(OUTPUT_PATH)$@

.PHONY: stats
stats: $(TARGET)
	$(OBJDUMP) -th $(OUTPUT_PATH)$<
	$(SIZE) $(OUTPUT_PATH)$<

.PHONY: check
check:
	$(SA) $(SAFLAGS) .

.PHONY: clean
clean:
	$(RM) $(OBJECTS)
	$(RM) $(OUTPUT_PATH)$(TARGET)
	-@$(RMDIR) $(OUTPUT_PATH) 2>/dev/null

###############################################################################

.c.o:
	$(CC) $(CFLAGS) $< -o $@

###############################################################################
