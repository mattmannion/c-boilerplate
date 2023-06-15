#include "thing.h"
#include <stdio.h>

struct Meme {
  int id;
  char *name;
};

struct Meme memes[] = {
    {
        .id = 0,
        .name = "asdf",
    },
    {
        .id = 1,
        .name = "qwer",
    },
};

void show_memes() {
  for (long unsigned int i = 0; i < sizeof(memes) / sizeof(struct Meme); i++) {
    printf("id: %d, name: %s\n\n", memes[i].id, memes[i].name);
  }
}

void hello() { printf("hello %d\n", Y); }
