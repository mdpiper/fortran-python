#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "c_bmiheat.h"


int main(int argc, char *argv[]) {
  int model, status;
  char *config_file = "";
  int nchars = strlen(config_file);

  model = c_new();
  printf("Model: %d\n", model);

  status = c_initialize(model, config_file, nchars);
  printf("Status: %d\n", status);

  status = c_finalize(model);
  printf("Status: %d\n", status);
}
