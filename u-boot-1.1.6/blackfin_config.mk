# U-boot - blackfin_config.mk
#
# Copyright (c) 2005-2007 Analog Devices Inc.
#
# (C) Copyright 2000-2002
# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
#
# See file CREDITS for list of people who contributed to this
# project.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
# MA 02110-1301 USA
#

PLATFORM_CPPFLAGS += -DCONFIG_BLACKFIN -ffixed-P5 -fomit-frame-pointer

CONFIG_CPU := $(strip $(shell echo 'BFIN_CPU' | $(CPP) -P -include $(TOPDIR)/include/configs/$(BOARD).h - 2>/dev/null | tail -n 1))
PLATFORM_RELFLAGS += -mcpu=$(CONFIG_CPU)

BFIN_BOOT_MODE := $(shell \
	sed -n '/^\#define[[:space:]]*BFIN_BOOT_MODE[[:space:]]/s:.*[[:space:]]*BFIN_:BFIN_:p' \
	$(SRCTREE)/include/configs/$(BOARD).h)

ifneq ($(BFIN_BOOT_MODE),BFIN_BOOT_BYPASS)
LDR_FLAGS += --initcode $(obj)cpu/$(CPU)/init_sdram.o
endif

ifneq ($(findstring s,$(MAKEFLAGS)),)
LDR_FLAGS += --quiet
endif
