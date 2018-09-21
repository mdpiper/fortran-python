#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int n_x;
  float *temperature;
} diffusion_model;

void c_initialize(diffusion_model *m);
void c_get_grid_x(diffusion_model *m, int *n);
void c_get_value(diffusion_model *m, float **t);

int main(int argc, char *argv[]) {
  diffusion_model model;
  int i, n_x;
  float *temperature;

  c_initialize(&model);

  c_get_grid_x(&model, &n_x);
  c_get_value(&model, &temperature);

  printf("Number of array elements: %d\n", n_x);
  printf("Array values\n");
  for (i = 0; i < n_x; i++) {
    printf("%d: %f\n", i, temperature[i]);
  }
}
