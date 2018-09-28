#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "c_bmiheat.h"


int main(int argc, char *argv[]) {
  int model, status, n_invars, n_outvars, i;
  char *config_file = "";
  int nchars = strlen(config_file);
  char *component_name;
  char **input_var_names, **output_var_names;
  float time;
  char *units;

  model = bmi_new();
  printf("Model %d\n", model);

  status = bmi_initialize(model, config_file, nchars);
  printf("- initialize status: %d\n", status);

  component_name = malloc(BMI_MAXCOMPNAMESTR);
  status = bmi_get_component_name(model, component_name, BMI_MAXCOMPNAMESTR);
  printf("- component name: %s\n", component_name);
  free(component_name);

  status = bmi_get_input_var_name_count(model, &n_invars);
  printf("- number of input vars: %d\n", n_invars);

  // Pointers to pointers, oh my.
  input_var_names = malloc(n_invars);
  input_var_names[0] = malloc(BMI_MAXVARNAMESTR);
  for (i = 1; i < n_invars; i++) {
    input_var_names[i] = input_var_names[i - 1] + BMI_MAXVARNAMESTR;
  }
  status = bmi_get_input_var_names(model, input_var_names);
  printf("- input var names:\n");
  for (i = 0; i < n_invars; i++) {
    printf("  - %s\n", input_var_names[i]);
  }
  free(input_var_names);

  status = bmi_get_output_var_name_count(model, &n_outvars);
  printf("- number of output vars: %d\n", n_outvars);

  // Pointers to pointers, oh my.
  output_var_names = malloc(n_outvars);
  output_var_names[0] = malloc(BMI_MAXVARNAMESTR);
  for (i = 1; i < n_outvars; i++) {
    output_var_names[i] = output_var_names[i - 1] + BMI_MAXVARNAMESTR;
  }
  status = bmi_get_output_var_names(model, output_var_names);
  printf("- output var names:\n");
  for (i = 0; i < n_outvars; i++) {
    printf("  - %s\n", output_var_names[i]);
  }
  free(output_var_names);

  status = bmi_get_start_time(model, &time);
  printf("- model start time: %6.1f\n", time);
  status = bmi_get_end_time(model, &time);
  printf("- model stop time: %6.1f\n", time);
  status = bmi_get_current_time(model, &time);
  printf("- model current time: %6.1f\n", time);
  status = bmi_get_time_step(model, &time);
  printf("- model time step: %6.1f\n", time);
  units = malloc(BMI_MAXUNITSSTR);
  status = bmi_get_time_units(model, units, BMI_MAXUNITSSTR);
  printf("- model time units: %s\n", units);
  free(units);

  status = bmi_finalize(model);
  printf("- finalize status: %d\n", status);
}
