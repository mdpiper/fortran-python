#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int n_x;
  float *temperature;
} diffusion_model;

void c_initialize(diffusion_model *x);

int main(int argc, char *argv[]) {
  diffusion_model model;
  int i;

  c_initialize(&model);

  printf("Number of array elements: %d\n", model.n_x);
  printf("Array values\n");
  for (i = 0; i < model.n_x; i++) {
    printf("%d: %f\n", i, model.temperature[i]);
  }
}
