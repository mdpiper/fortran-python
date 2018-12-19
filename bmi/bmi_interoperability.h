/*
  Function prototypes for the Fortran interoperability layer.
*/

// Max string lengths from "bmi.f90".
#define MAX_COMPONENT_NAME (2048)
#define MAX_VAR_NAME (2048)
#define MAX_TYPE_NAME (2048)
#define MAX_UNITS_NAME (2048)

int new_model(void);

int initialize(int model, const char *config_file, int n_chars);
int update(int model);
int update_until(int model, double until);
int update_frac(int model, double frac);
int finalize(int model);

int get_component_name(int model, char *name, int n_chars);
int get_input_var_name_count(int model, int *count);
int get_output_var_name_count(int model, int *count);
int get_input_var_names(int model, char **names, int n_names);
int get_output_var_names(int model, char **names, int n_names);

int get_start_time(int model, double *time);
int get_end_time(int model, double *time);
int get_current_time(int model, double *time);
int get_time_step(int model, double *time);
int get_time_units(int model, char *units, int n_chars);

int get_var_grid(int model, const char *var_name, int n_chars,
		     int *grid_id);

int get_grid_type(int model, int grid_id, char *type, int n_chars);
int get_grid_rank(int model, int grid_id, int *rank);
int get_grid_shape(int model, int grid_id, int *shape, int rank);
int get_grid_size(int model, int grid_id, int *size);
int get_grid_spacing(int model, int grid_id, float *spacing, int rank);
int get_grid_origin(int model, int grid_id, float *origin, int rank);

int get_grid_x(int model, int grid_id, float *x, int size);
int get_grid_y(int model, int grid_id, float *y, int size);
int get_grid_z(int model, int grid_id, float *z, int size);
int get_grid_connectivity(int model, int grid_id, int *conn, int size);
int get_grid_offset(int model, int grid_id, int *offset, int size);

int get_var_type(int model, const char *var_name, int n_chars,
		     char *type, int m_chars);
int get_var_units(int model, const char *var_name, int n_chars,
		      char *units, int m_chars);
int get_var_itemsize(int model, const char *var_name, int n_chars,
			 int *itemsize);
int get_var_nbytes(int model, const char *var_name, int n_chars,
		       int *nbytes);

int get_value_int(int model, const char *var_name, int n_chars,
		      void *buffer, int size);
int get_value_float(int model, const char *var_name, int n_chars,
			void *buffer, int size);
int get_value_double(int model, const char *var_name, int n_chars,
			 void *buffer, int size);

int get_value_ptr(int model, const char *var_name, int n_chars, void **ptr);

int set_value_int(int model, const char *var_name, int n_chars,
		      void *buffer, int size);
int set_value_float(int model, const char *var_name, int n_chars,
			void *buffer, int size);
int set_value_double(int model, const char *var_name, int n_chars,
			 void *buffer, int size);
