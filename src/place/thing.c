#include "thing.h"
#include <stdio.h>

struct S_Test {
  char *a;
  int b;
};

struct S_Test y[] = {
    {
        .a = "asdf",
        .b = 0,
    },
    {
        .a = "qwer",
        .b = 1,
    },
};

void show_tests() {
  for (long unsigned int i = 0; i < sizeof(y) / sizeof(struct S_Test); i++) {
    printf("%p\n", &y[i].a);
    printf("%d\n", y[i].b);
    printf("\n");
  }
}

void hello() { printf("hello %d\n", Y); }
