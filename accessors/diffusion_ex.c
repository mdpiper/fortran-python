#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "c_diffusion.h"

int main(int argc, char *argv[]) {
  diffusion_model model;
  int i, n_x;
  float time, *temperature;

  c_initialize(&model);

  c_get_grid_x(&model, &n_x);
  c_get_current_time(&model, &time);
  c_get_value(&model, &temperature);

  printf("Number of array elements: %d\n", n_x);
  printf("Time: %f\n", time);
  printf("Array values\n");
  for (i = 0; i < n_x; i++) {
    printf("%d: %f\n", i, temperature[i]);
  }

  c_update(&model);

  c_get_current_time(&model, &time);
  c_get_value(&model, &temperature);

  printf("Time: %f\n", time);
  printf("Array values\n");
  for (i = 0; i < n_x; i++) {
    printf("%d: %f\n", i, temperature[i]);
  }
}
