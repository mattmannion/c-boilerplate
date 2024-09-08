#include "memes.h"
#include <stdio.h>

typedef struct Meme {
  int id;
  char *name;
} Meme;

Meme memes[] = {
    {
        .id = 0,
        .name = "asdf",
    },
    {
        .id = 1,
        .name = "qwer",
    },
};

void memes_show() {
  int length = sizeof(memes) / sizeof(Meme);
  for (int i = 0; i < length; i++) {
    Meme meme = memes[i];
    printf("id: %d, name: %s\n", meme.id, meme.name);
  }
}

void memes_hello(int num) { printf("hello %d\n", Y * num); }
