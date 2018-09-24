#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "c_diffusion.h"

void print_model(int model, int n, float time, float *temperature) {
  int i;

  printf("Model %d\n", model);
  printf("- Number of array elements: %d\n", n);
  printf("- Time: %6.1f\n", time);
  printf("- Array values:");
  for (i = 0; i < n; i++) {
    printf("%6.1f", temperature[i]);
  }
  printf("\n");
}

int main(int argc, char *argv[]) {
  int model1, model2;
  int n1, n2;
  float time1, time2;
  float *temperature1, *temperature2;

  model1 = c_new();
  c_initialize(model1);
  model2 = c_new();
  c_initialize(model2);

  c_get_grid_x(model1, &n1);
  c_get_current_time(model1, &time1);
  c_get_value(model1, &temperature1);
  print_model(model1, n1, time1, temperature1);

  c_get_grid_x(model2, &n2);
  c_get_current_time(model2, &time2);
  c_get_value(model2, &temperature2);
  print_model(model2, n2, time2, temperature2);

  c_update(model1);

  c_get_current_time(model1, &time1);
  c_get_value(model1, &temperature1);
  print_model(model1, n1, time1, temperature1);

  c_get_current_time(model2, &time2);
  c_get_value(model2, &temperature2);
  print_model(model2, n2, time2, temperature2);

  c_finalize(model1);
  c_finalize(model2);
}
