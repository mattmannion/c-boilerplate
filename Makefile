# compiler choice
CC = gcc

# binary name
NAME = main

# project dirs
SRC = ./src/
GEN = ./gen/
OUT = ./dist/
INC = ./includes/

# static compiler flags for C
OPT				= -O0
DEPFLAGS 	= -MP -MD

# finds all Include(-I) dirs for header(*.h) files
INCLUDES	:= $(shell find $(INC) -type d)
# creates flag list for compiler		
CFLAGS		:= -Wall -Wextra -g $(DEPFLAGS) $(foreach d, $(INCLUDES), -I$(d))
# finds all *.c files with shell
CFILES		:= $(shell find $(SRC) -type f -name '*.c')
# finds all dirs with shell
DIRS 			:= $(shell find $(SRC) -type d)

# subst replaces CFILES SRC path with GEN path
OBJS := $(subst $(SRC), $(GEN), $(patsubst %.c,%.o,$(CFILES)))
DEPS := $(subst $(SRC), $(GEN), $(patsubst %.c,%.d,$(CFILES)))

# exe path
EXE = $(OUT)$(NAME)

all: $(EXE)

$(EXE): $(OBJS)
	@$(shell mkdir -p $(OUT) $(INC))
	@$(CC) -o $(EXE) $^
	@echo "make: Compile successful for 'all'"

$(GEN)%.o: $(SRC)%.c 
	@$(foreach d, $(subst $(SRC), $(GEN), $(DIRS)), $(shell mkdir -p $(d)) )
	@$(CC) $(CFLAGS) -c -o $@ $<

clean:
	@rm -rf $(OUT)* $(GEN)*

-include $(DEPS)

run:
	@$(EXE)