/* Use max string length definitions from "bmi.f90". */
#define BMI_MAXVARNAMESTR (2048)
#define BMI_MAXCOMPNAMESTR (2048)
#define BMI_MAXUNITSSTR (2048)

int bmi_new(void);
int bmi_initialize(int, char *, int);
int bmi_finalize(int);
int bmi_get_component_name(int, char *, int);
int bmi_get_input_var_name_count(int, int *);
int bmi_get_input_var_names(int, char **);
int bmi_get_output_var_name_count(int, int *);
int bmi_get_output_var_names(int, char **);
int bmi_get_start_time(int, float *);
int bmi_get_end_time(int, float *);
int bmi_get_current_time(int, float *);
