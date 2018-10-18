#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "iop_bmiheat.h"


int main(int argc, char *argv[]) {
  int model, status, n_invars, n_outvars, i, j, k;
  char *config_file = "test.cfg";
  int nchars = strlen(config_file);
  char *component_name;
  char **input_var_names, **output_var_names;
  double time;
  char *units;
  char *var_name;
  int grid_id;
  char *grid_type;
  int grid_rank;
  int *grid_shape;
  int grid_size;
  char *var_type;
  int var_nbytes;
  void *buffer;
  void *new;
  void *ref;

  // Get a new model.
  model = iop_new();
  printf("Model %d\n", model);

  // Initialize the model.
  status = iop_initialize(model, config_file, nchars);
  printf("- initialize status: %d\n", status);

  // Get the model's name.
  component_name = malloc(MAX_COMPONENT_NAME);
  status = iop_get_component_name(model, component_name, MAX_COMPONENT_NAME);
  printf("- component name: %s\n", component_name);
  free(component_name);

  // Get the model's inputs. Pointers to pointers, oh my.
  status = iop_get_input_var_name_count(model, &n_invars);
  printf("- number of input vars: %d\n", n_invars);
  input_var_names = malloc(n_invars);
  input_var_names[0] = malloc(MAX_VAR_NAME);
  for (i = 1; i < n_invars; i++) {
    input_var_names[i] = input_var_names[i - 1] + MAX_VAR_NAME;
  }
  status = iop_get_input_var_names(model, input_var_names, n_invars);
  printf("- input var names:\n");
  for (i = 0; i < n_invars; i++) {
    printf("  - %s\n", input_var_names[i]);
  }
  free(input_var_names);

  // Get the model's outputs.
  status = iop_get_output_var_name_count(model, &n_outvars);
  printf("- number of output vars: %d\n", n_outvars);
  output_var_names = malloc(n_outvars);
  output_var_names[0] = malloc(MAX_VAR_NAME);
  for (i = 1; i < n_outvars; i++) {
    output_var_names[i] = output_var_names[i - 1] + MAX_VAR_NAME;
  }
  status = iop_get_output_var_names(model, output_var_names, n_outvars);
  printf("- output var names:\n");
  for (i = 0; i < n_outvars; i++) {
    printf("  - %s\n", output_var_names[i]);
  }
  free(output_var_names);

  // Get time information from the model.
  status = iop_get_start_time(model, &time);
  printf("- model start time: %6.1f\n", time);
  status = iop_get_end_time(model, &time);
  printf("- model stop time: %6.1f\n", time);
  status = iop_get_current_time(model, &time);
  printf("- model current time: %6.1f\n", time);
  status = iop_get_time_step(model, &time);
  printf("- model time step: %6.1f\n", time);
  units = malloc(MAX_UNITS_NAME);
  status = iop_get_time_units(model, units, MAX_UNITS_NAME);
  printf("- model time units: %s\n", units);
  free(units);

  // Update the model by a single time step.
  status = iop_update(model);
  printf("- update status: %d\n", status);
  status = iop_get_current_time(model, &time);
  printf("- model current time: %6.1f\n", time);

  // Update the model by a fraction of a time step.
  status = iop_update_frac(model, 0.75);
  printf("- update_frac status: %d\n", status);
  status = iop_get_current_time(model, &time);
  printf("- model current time: %6.1f\n", time);

  // Update the model until a later time.
  status = iop_update_until(model, 10.0);
  printf("- update_until status: %d\n", status);
  status = iop_get_current_time(model, &time);
  printf("- model current time: %6.1f\n", time);

  // Get grid information for the plate_surface__temperature variable.
  var_name = "plate_surface__temperature";
  nchars = strlen(var_name);
  status = iop_get_var_grid(model, var_name, nchars, &grid_id);
  printf("- Grid info for %s\n", var_name);
  printf(" - grid_id: %d\n", grid_id);
  grid_type = malloc(MAX_TYPE_NAME);
  memset(grid_type, 0, MAX_TYPE_NAME);
  status = iop_get_grid_type(model, grid_id, grid_type, MAX_TYPE_NAME);
  printf(" - grid type: %s\n", grid_type);
  free(grid_type);
  status = iop_get_grid_rank(model, grid_id, &grid_rank);
  printf(" - grid rank: %d\n", grid_rank);
  grid_shape = malloc(grid_rank * sizeof(int));
  /* status = iop_get_grid_shape(model, grid_id, &grid_shape[0]); */
  status = iop_get_grid_shape(model, grid_id, grid_shape, grid_rank);
  printf(" - grid shape:");
  for (i = 0; i < grid_rank; i++) {
    printf(" %d", grid_shape[i]);
  }
  printf("\n");
  status = iop_get_grid_size(model, grid_id, &grid_size);
  printf(" - grid size: %d\n", grid_size);

  // Get information for the plate_surface__temperature variable.
  var_name = "plate_surface__temperature";
  nchars = strlen(var_name);
  printf("- Variable info for %s\n", var_name);
  var_type = malloc(MAX_TYPE_NAME);
  memset(var_type, 0, MAX_TYPE_NAME);
  status = iop_get_var_type(model, var_name, nchars, var_type, MAX_TYPE_NAME);
  printf(" - variable type: %s\n", var_type);
  free(var_type);
  status = iop_get_var_nbytes(model, var_name, nchars, &var_nbytes);
  printf(" - total memory (bytes): %d\n", var_nbytes);

  // Get the values. (Note: not completely confident gridded order is correct.)
  buffer = malloc(grid_size * sizeof(float));
  status = iop_get_value_float(model, var_name, nchars, buffer, grid_size);
  printf(" - values, streamwise:\n");
  for (i = 0; i < grid_size; i++) {
    printf(" %6.1f", ((float *)buffer)[i]);
  }
  printf(" - values, dimensional:\n");
  for (j = 0; j < grid_shape[1]; j++) {
    for (i = 0; i < grid_shape[0]; i++) {
      k = i + j*grid_shape[0];
      printf(" %6.1f", ((float *)buffer)[k]);
    }
    printf("\n");
  }
  free(buffer);

  // Set values (float).
  new = malloc(grid_size * sizeof(float));
  for (i = 0; i < grid_size; i++) {
    ((float *)new)[i] = (float)i;
  }
  status = iop_set_value_float(model, var_name, nchars, new, grid_size);
  free(new);
  buffer = malloc(grid_size * sizeof(float));
  status = iop_get_value_float(model, var_name, nchars, buffer, grid_size);
  printf(" - new values (set/get), streamwise:\n");
  for (i = 0; i < grid_size; i++) {
    printf(" %6.1f", ((float *)buffer)[i]);
  }
  free(buffer);

  // Get a reference to a (float) variable and check that it updates.
  status = iop_get_current_time(model, &time);
  status = iop_get_value_ref(model, var_name, nchars, &ref);
  printf(" - values, dimensional, through ref, at time %6.1f:\n", time);
  for (j = 0; j < grid_shape[1]; j++) {
    for (i = 0; i < grid_shape[0]; i++) {
      k = i + j*grid_shape[0];
      printf(" %6.1f", ((float *)ref)[k]);
    }
    printf("\n");
  }
  status = iop_update(model);
  printf("- update status: %d\n", status);
  status = iop_get_current_time(model, &time);
  printf(" - values, dimensional, through ref, at time %6.1f:\n", time);
  for (j = 0; j < grid_shape[1]; j++) {
    for (i = 0; i < grid_shape[0]; i++) {
      k = i + j*grid_shape[0];
      printf(" %6.1f", ((float *)ref)[k]);
    }
    printf("\n");
  }

  // Clean up variables.
  free(grid_shape);

  // Finalize the model.
  status = iop_finalize(model);
  printf("- finalize status: %d\n", status);
}
