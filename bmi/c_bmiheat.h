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
