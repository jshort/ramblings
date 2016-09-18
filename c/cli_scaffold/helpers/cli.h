#ifndef _CLI_H
#define _CLI_H

#include <argp.h>

#define SHORT_USAGE (ARGP_HELP_SHORT_USAGE | ARGP_HELP_EXIT_ERR)

enum {
  CLI_VERSION_KEY = 777,
  HIDDEN_KEY = 666
};

const char *const cli_app_version(void);

const char *const cli_help_format(void);

/* Program documentation. */
const char *const cli_documentation(void);

/* A description of the arguments we accept. */
const char *const cli_args_doc(void);

/* The options we understand. */
const struct argp_option *const cli_argp_options(void);

/* Used by main to communicate with parse_opt. */
struct arguments
{
  char *args[2];                /* arg1 & arg2 */
  int silent, verbose, hidden;
  char *output_file;
};

#endif /* cli.h */
