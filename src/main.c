#include <stdio.h>

#include "things/memes.h"

typedef struct {
  int a;
  int b;
} S_Stuff;

S_Stuff Stuff_constructor(int a, int b) {
  return (S_Stuff){.a = a, .b = b};
}

int main() {
  memes_show();

  memes_hello(3);

  S_Stuff stuff = Stuff_constructor(1, 3);

  printf("%d, %d\n", stuff.a, stuff.b);

  return 0;
}