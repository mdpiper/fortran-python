#define BMI_MAX_COMPONENT_NAME (2048)

int bmi_new(void);
int bmi_initialize(int model, char *config_file, int n);
int bmi_finalize(int model);
int bmi_get_component_name(int model, char *name, int n);
