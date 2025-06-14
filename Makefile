# Compiler choice
CC = gcc

# Binary name
NAME = main

# Project directories
SRC = ./src/
GEN = ./gen/
OUT = ./dist/
INC = ./includes/
CONAN_DIR = .conan

# Static C compiler flags 
DEBUG_OPT    = -O0
RELEASE_OPT  = -O3  
DEPFLAGS     = -MP -MD

# Find all Include(-I) dirs for header (*.h) files
INCLUDES	:= $(shell find $(INC) -type d)

# Conan pkg-config setup
PKG_CONFIG_PATH := $(CONAN_DIR)
PKG_CFLAGS := $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --cflags --silence-errors zlib)
PKG_LDFLAGS := $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --libs --silence-errors zlib)

# Create flag list for C compiler		
CFLAGS_DEBUG   := -Wall -Wextra -g -std=c2x $(DEPFLAGS) $(foreach d, $(INCLUDES), -I$(d)) $(PKG_CFLAGS)
CFLAGS_RELEASE := -Wall -Wextra -std=c2x $(RELEASE_OPT) $(DEPFLAGS) $(foreach d, $(INCLUDES), -I$(d)) $(PKG_CFLAGS)

# Find all .c files in src folder
CFILES		:= $(shell find $(SRC) -type f -name '*.c')

# Find all SRC directories
DIRS      := $(shell find $(SRC) -type d)

# Substitute CFILES SRC path with GEN path for object files
OBJS := $(subst $(SRC), $(GEN), $(patsubst %.c,%.o,$(CFILES)))
DEPS := $(subst $(SRC), $(GEN), $(patsubst %.c,%.d,$(CFILES)))

# Executable path
EXE = $(OUT)$(NAME)

# Control verbosity (silent by default, verbose if VERBOSE=1)
ifeq ($(VERBOSE), 1)
    SILENT :=
else
    SILENT := @
endif

# Default target (debug build)
all: debug

# Debug target
debug: CFLAGS = $(CFLAGS_DEBUG)
debug: $(EXE)

# Release target
release: CFLAGS = $(CFLAGS_RELEASE)
release: $(EXE)
	$(SILENT)echo "make: Release build complete"

# Target for creating the executable
$(EXE): $(OBJS)
	$(SILENT)mkdir -p $(OUT)
	$(SILENT)$(CC) -o $(EXE) $^ $(PKG_LDFLAGS)
	$(SILENT)echo "make: Compile successful for 'all'"

# Compile object files, ensure directories exist
$(GEN)%.o: $(SRC)%.c | prepare_gen_dirs
	$(SILENT)$(CC) $(CFLAGS) -c -o $@ $<

# Create necessary directories for generated files
prepare_gen_dirs:
	$(SILENT)$(foreach d, $(DIRS), mkdir -p $(subst $(SRC), $(GEN), $(d));)

# Clean the build files
clean:
	$(SILENT)rm -rf $(OUT)* $(GEN)* $(CONAN_DIR)

# Run the executable
run: $(EXE)
	$(SILENT)$(EXE)

# Update the compilation database
.PHONY: compdb
compdb: clean   ## rebuild *and* update compilation database
	@bear -- $(MAKE) -j$(nproc)

# Helpful alias so clangd always sees up-to-date flags
compile_commands.json: compdb

# Include dependency files
-include $(DEPS)

.PHONY: clean run debug release compile_commands.json
