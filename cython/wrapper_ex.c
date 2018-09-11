#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void c_square(int *x, int *n, int *r);


int main(int argc, char *argv[]) {

  int i, n = 5;
  int x[n], r[n];

  for (i = 0; i < n; i++) {
    x[i] = i;
  }

  c_square(x, &n, r);

  printf("Square array example\n");
  printf("Numbers:");
  for (i = 0; i < n; i++) {
    printf("%5d", x[i]);
  }
  printf("\n");
  printf("Their squares:");
  for (i = 0; i < n; i++) {
    printf("%5d", r[i]);
  }
  printf("\n");
}
