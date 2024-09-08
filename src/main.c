#include "things/memes.h"
#include <stdio.h>

struct S {
  int a;
  int b;
};

struct S S_constructor(int a, int b) { return (struct S){.a = a, .b = b}; }

int main() {
  show_memes();

  struct S s = S_constructor(1, 3);

  printf("%d, %d\n", s.a, s.b);

  return 0;
}