# SimplePost - A Basic, Embedded HTTP Server
#
# Copyright (C) 2012 xorangekiller.  All rights reserved.
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

.PHONY: all release debug \
		clean clean_src clean_bin

all: release

release:
	$(MAKE) -C src -f Makefile all

debug:
	$(MAKE) -C src -f Makefile debug

clean:
	$(MAKE) -C src -f Makefile clean

clean_src:
	$(MAKE) -C src -f Makefile clean_src

clean_bin:
	$(MAKE) -C src -f Makefile clean_bin
