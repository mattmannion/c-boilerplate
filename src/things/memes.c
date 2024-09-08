#include "memes.h"
#include <stdio.h>

typedef struct {
  int id;
  char* name;
} S_Meme;

S_Meme memes[] = {
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
  int length = sizeof(memes) / sizeof(S_Meme);
  for (int i = 0; i < length; i++) {
    S_Meme meme = memes[i];
    printf("id: %d, name: %s\n", meme.id, meme.name);
  }
}

void memes_hello(int num) {
  printf("hello %d\n", Y * num);
}
