int c_new(void);
void c_initialize(int model);
void c_finalize(int model);
void c_get_grid_x(int model, int *n);
void c_get_value(int model, float **t);
void c_get_current_time(int model, float *time);
void c_update(int model);

void print_model(int model, int n, float time, float *temperature);
