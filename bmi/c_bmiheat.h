/* Use max string length definitions from "bmi.f90". */
#define BMI_MAXVARNAMESTR (2048)
#define BMI_MAXCOMPNAMESTR (2048)
#define BMI_MAXUNITSSTR (2048)

int bmi_new(void);

int bmi_initialize(int model, char *config_file, int n);
int bmi_finalize(int model);

int bmi_get_component_name(int model, char *name, int n);
int bmi_get_input_var_name_count(int model, int *n);
int bmi_get_input_var_names(int model, char **names);
int bmi_get_output_var_name_count(int model, int *n);
int bmi_get_output_var_names(int model, char **names);

int bmi_get_start_time(int model, float *time);
int bmi_get_end_time(int model, float *time);
int bmi_get_current_time(int model, float *time);
int bmi_get_time_step(int model, float *time_step);
int bmi_get_time_units(int model, char *time_units, int n);

int bmi_update(int model);
int bmi_update_frac(int model, float time_frac);
int bmi_update_until(int model, float time_later);

int bmi_get_var_grid(int model, char *var_name, int n, int *grid_id);

int bmi_get_grid_type(int model, int grid_id, char *type, int n);
int bmi_get_grid_rank(int model, int grid_id, int *rank);
int bmi_get_grid_shape(int model, int grid_id, int *shape, int rank);
int bmi_get_grid_size(int model, int grid_id, int *size);
int bmi_get_grid_spacing(int model, int grid_id, float *spacing, int rank);
int bmi_get_grid_origin(int model, int grid_id, float *origin, int rank);

int bmi_get_var_type(int model, char *var_name, int n, char *type, int m);
int bmi_get_var_units(int model, char *var_name, int n, char *units, int m);
int bmi_get_var_itemsize(int model, char *var_name, int n, int *itemsize);
int bmi_get_var_nbytes(int model, char *var_name, int n, int *nbytes);
