#define BMI_MAX_COMPONENT_NAME (2048)

int c_new(void);
int c_initialize(int model, char *config_file, int n);
int c_finalize(int model);
int c_get_component_name(int model, char *name, int n);
