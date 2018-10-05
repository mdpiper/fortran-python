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
  char *var_name;
  int grid_id;
  char *grid_type;
  int rank;
  int *shape;
  char *var_type;
  int nbytes;

  // Get a new model.
  model = bmi_new();
  printf("Model %d\n", model);

  // Initialize the model.
  status = bmi_initialize(model, config_file, nchars);
  printf("- initialize status: %d\n", status);

  // Get the model's name.
  component_name = malloc(BMI_MAXCOMPNAMESTR);
  status = bmi_get_component_name(model, component_name, BMI_MAXCOMPNAMESTR);
  printf("- component name: %s\n", component_name);
  free(component_name);

  // Get the model's inputs. Pointers to pointers, oh my.
  status = bmi_get_input_var_name_count(model, &n_invars);
  printf("- number of input vars: %d\n", n_invars);
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

  // Get the model's outputs.
  status = bmi_get_output_var_name_count(model, &n_outvars);
  printf("- number of output vars: %d\n", n_outvars);
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

  // Get time information from the model.
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

  // Update the model by a single time step.
  status = bmi_update(model);
  printf("- update status: %d\n", status);
  status = bmi_get_current_time(model, &time);
  printf("- model current time: %6.1f\n", time);

  // Update the model by a fraction of a time step.
  status = bmi_update_frac(model, 0.75);
  printf("- update_frac status: %d\n", status);
  status = bmi_get_current_time(model, &time);
  printf("- model current time: %6.1f\n", time);

  // Update the model until a later time.
  status = bmi_update_until(model, 10.0);
  printf("- update_until status: %d\n", status);
  status = bmi_get_current_time(model, &time);
  printf("- model current time: %6.1f\n", time);

  // Get the grid_id for one of the input variables.
  var_name = "plate_surface__temperature";
  nchars = strlen(var_name);
  status = bmi_get_var_grid(model, var_name, nchars, &grid_id);
  printf("- grid_id for plate_surface__temperature: %d\n", grid_id);

  // Get grid information for the plate_surface__temperature variable.
  grid_type = malloc(BMI_MAXUNITSSTR);
  memset(grid_type, 0, BMI_MAXUNITSSTR);
  status = bmi_get_grid_type(model, grid_id, grid_type, BMI_MAXUNITSSTR);
  printf("- grid type: %s\n", grid_type);
  free(grid_type);
  status = bmi_get_grid_rank(model, grid_id, &rank);
  printf("- grid rank: %d\n", rank);
  shape = malloc(rank * sizeof(int));
  /* status = bmi_get_grid_shape(model, grid_id, &shape[0]); */
  status = bmi_get_grid_shape(model, grid_id, shape, rank);
  printf("- grid shape:");
  for (i = 0; i < rank; i++) {
    printf(" %d", shape[i]);
  }
  printf("\n");
  free(shape);

  // Get information for the plate_surface__temperature variable.
  var_name = "plate_surface__temperature";
  nchars = strlen(var_name);
  printf("- Info for variable %s\n", var_name);
  var_type = malloc(BMI_MAXUNITSSTR);
  memset(var_type, 0, BMI_MAXUNITSSTR);
  status = bmi_get_var_type(model, var_name, nchars, var_type, BMI_MAXUNITSSTR);
  printf(" - variable type: %s\n", var_type);
  free(var_type);
  status = bmi_get_var_nbytes(model, var_name, nchars, &nbytes);
  printf(" - total memory (bytes): %d\n", nbytes);

  // Finalize the model.
  status = bmi_finalize(model);
  printf("- finalize status: %d\n", status);
}
