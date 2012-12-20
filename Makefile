
INSTALL_DIR ?= $(CURDIR)/install

export INSTALL_DIR

INSTALL_BIN_DIR = $(INSTALL_DIR)/bin
INSTALL_LIB_DIR = $(INSTALL_DIR)/lib
INSTALL_LIBEXEC_DIR = $(INSTALL_DIR)/libexec
INSTALL_SUBDIR = $(INSTALL_BIN_DIR) $(INSTALL_LIB_DIR) $(INSTALL_LIBEXEC_DIR)

SRC_DIR := $(CURDIR)/src
STAR_DIR := $(CURDIR)/isaac_variant_caller
REDIST_DIR := $(CURDIR)/redist


all: install

$(INSTALL_SUBDIR): build
	mkdir -p $@

install: $(INSTALL_SUBDIR) build
	rsync -a $(CURDIR)/etc $(INSTALL_DIR)
	rsync -a $(CURDIR)/demo $(INSTALL_BIN_DIR)
	rsync -a $(CURDIR)/redist/ $(INSTALL_DIR)/opt
	rsync -a $(STAR_DIR)/redist/samtools* $(INSTALL_DIR)/opt
	rsync -a $(STAR_DIR)/redist/tabix* $(INSTALL_DIR)/opt
	rsync -a $(STAR_DIR)/src/bin/starling2 $(INSTALL_LIBEXEC_DIR)
	$(MAKE) -C $(SRC_DIR) $@

build:
	$(MAKE) -C $(REDIST_DIR) $@
	$(MAKE) -C $(SRC_DIR) $@
	$(MAKE) -C $(STAR_DIR) $@

clean: srcclean
	$(MAKE) -C $(REDIST_DIR) $@

# developer targets:
#

# clean all but redist directory 
srcclean:
	$(MAKE) -C $(STAR_DIR) srcclean
	$(MAKE) -C $(SRC_DIR) clean

