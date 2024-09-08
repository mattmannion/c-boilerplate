# Compiler choice
CC = gcc

# Binary name
NAME = main

# Project directories
SRC = ./src/
GEN = ./gen/
OUT = ./dist/
INC = ./includes/

# Static C compiler flags 
DEBUG_OPT    = -O0
RELEASE_OPT  = -O3  
DEPFLAGS     = -MP -MD

# Find all Include(-I) dirs for header (*.h) files
INCLUDES	:= $(shell find $(INC) -type d)

# Create flag list for C compiler		
CFLAGS_DEBUG   := -Wall -Wextra -g -std=c2x $(DEPFLAGS) $(foreach d, $(INCLUDES), -I$(d))
CFLAGS_RELEASE := -Wall -Wextra -std=c2x $(RELEASE_OPT) $(DEPFLAGS) $(foreach d, $(INCLUDES), -I$(d))


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
	$(SILENT)$(CC) -o $(EXE) $^
	$(SILENT)echo "make: Compile successful for 'all'"

# Compile object files, ensure directories exist
$(GEN)%.o: $(SRC)%.c | prepare_gen_dirs
	$(SILENT)$(CC) $(CFLAGS) -c -o $@ $<

# Create necessary directories for generated files
prepare_gen_dirs:
	$(SILENT)$(foreach d, $(DIRS), mkdir -p $(subst $(SRC), $(GEN), $(d));)

# Clean the build files
clean:
	$(SILENT)rm -rf $(OUT)* $(GEN)*

# Run the executable
run: $(EXE)
	$(SILENT)$(EXE)

# Include dependency files
-include $(DEPS)

.PHONY: clean run debug release
