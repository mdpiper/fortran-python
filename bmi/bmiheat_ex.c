#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "c_bmiheat.h"


int main(int argc, char *argv[]) {
  int model, status;
  char *config_file = "";
  int nchars = strlen(config_file);
  char *component_name;

  model = bmi_new();
  printf("Model: %d\n", model);

  status = bmi_initialize(model, config_file, nchars);
  printf("Status: %d\n", status);

  component_name = malloc(BMI_MAX_COMPONENT_NAME);
  status = bmi_get_component_name(model, component_name, BMI_MAX_COMPONENT_NAME);
  printf("Component name: %s\n", component_name);
  printf("Status: %d\n", status);

  status = bmi_finalize(model);
  printf("Status: %d\n", status);
}
