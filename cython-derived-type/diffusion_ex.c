#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int n_x;
} diffusion_model;

void c_initialize(diffusion_model *x);

int main(int argc, char *argv[]) {
  diffusion_model model;

  c_initialize(&model);
  printf("The answer is: %5d\n", model.n_x);
}
