/* Use max string length definitions from "bmi.f90". */
#define BMI_MAXVARNAMESTR (2048)
#define BMI_MAXCOMPNAMESTR (2048)
#define BMI_MAXUNITSSTR (2048)

int bmi_new(void);
int bmi_initialize(int model, char *config_file, int n);
int bmi_finalize(int model);
int bmi_get_component_name(int model, char *name, int n);
