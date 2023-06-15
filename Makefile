CC=gcc

SRC=./src/
GEN=./gen/
OUT=./dist/

NAME=main

CFLAGS=-Wall -Wextra -g -I. -MP -MD
CFILES := $(shell find $(SRC) -type f -name '*.c')
DIRS := $(shell find $(SRC) -type d)

OBJS=$(subst $(SRC), $(GEN), $(patsubst %.c,%.o,$(CFILES)))
DEPS=$(subst $(SRC), $(GEN), $(patsubst %.c,%.d,$(CFILES)))

EXE=$(OUT)$(NAME)

all: $(EXE)

$(EXE): $(OBJS)
	@$(shell mkdir -p $(OUT))
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