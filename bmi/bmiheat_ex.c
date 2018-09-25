#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "c_bmiheat.h"


int main(int argc, char *argv[]) {
  int model, status;

  model = c_new();
  printf("Model: %d\n", model);

  status = c_initialize(model);
  printf("Status: %d\n", status);

  status = c_finalize(model);
  printf("Status: %d\n", status);
}
