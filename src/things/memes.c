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

void show_memes() {
  int length = sizeof(memes) / sizeof(Meme);
  for (long unsigned int i = 0; i < length; i++) {
    Meme meme = memes[i];
    printf("id: %d, name: %s\n\n", meme.id, meme.name);
  }
}

void hello(int num) {
  if (!num)
    num = 1;

  printf("hello %d\n", Y * num);
}
