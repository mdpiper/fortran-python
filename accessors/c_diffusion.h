typedef struct {
  int n_x;
  float *temperature;
} diffusion_model;

void c_initialize(diffusion_model *m);
void c_get_grid_x(diffusion_model *m, int *n);
void c_get_value(diffusion_model *m, float **t);
