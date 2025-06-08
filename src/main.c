#include <stdio.h>
#include "things/memes.h"

typedef struct {
  int a;
  int b;
} T_Stuff;

T_Stuff T_Stuff_constructor(int a, int b) {
  return (T_Stuff){.a = a, .b = b};
}

int main() {
  memes_show();

  memes_hello(3);

  T_Stuff stuff = T_Stuff_constructor(1, 3);

  printf("%d, %d\n", stuff.a, stuff.b);

  return 0;
}