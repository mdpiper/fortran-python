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
  int model1, model2, model3;
  int n;
  float time;
  float *temperature;

  model1 = c_new();
  model2 = c_new();
  model3 = c_new();

  c_initialize(model1);
  c_initialize(model2);
  c_initialize(model3);

  c_get_grid_x(model1, &n);
  c_get_current_time(model1, &time);
  c_get_value(model1, &temperature);
  print_model(model1, n, time, temperature);

  c_get_grid_x(model2, &n);
  c_get_current_time(model2, &time);
  c_get_value(model2, &temperature);
  print_model(model2, n, time, temperature);

  c_get_grid_x(model3, &n);
  c_get_current_time(model3, &time);
  c_get_value(model3, &temperature);
  print_model(model3, n, time, temperature);

  c_update(model1);

  c_get_current_time(model1, &time);
  c_get_value(model1, &temperature);
  print_model(model1, n, time, temperature);

  c_get_current_time(model2, &time);
  c_get_value(model2, &temperature);
  print_model(model2, n, time, temperature);

  c_finalize(model1);
  c_finalize(model2);
}
