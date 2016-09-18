
#include "cli.h"

const char *argp_program_bug_address =
  "james.short@alumni.duke.edu";

static const char *APP_VERSION = "0.1";

static const char *HELP_FMT =
  "no-dup-args-note,short-opt-col=4,long-opt-col=8";

/* Program documentation. */
static const char *DOC =
  "Example command line option/argument parsing tool in c.\v"
  "This is more doc that is placed after the options help. "
  "Specify this text after a \\v character in the doc string.";

/* A description of the arguments we accept. */
static const char *ARGS_DOC = "ARG1 ARG2";
/* This would be used if 2 args were required and n additional were options */
/* static const char *ARGS_DOC = "ARG1 ARG2 [ARGN...]"; */

static const struct argp_option options[] = {
  {0,0, 0, 0, "Program Options:", 5 },
  {"verbose",  'v', 0,          0,  "Produce verbose output" },
  {"silent",   's', 0,          0,  "Don't produce any output" },
  {0,          'q', 0,          OPTION_ALIAS },
  {"output",   'o', "FILE",     OPTION_ARG_OPTIONAL,
   "Output to FILE instead of standard output. Default: ~/.cli_out" },
  {"hidden",   HIDDEN_KEY,      0,      OPTION_HIDDEN, "You will not see this"},
  { 0, 0, 0, 0, "General Options:", -1 },
  {"help",     'h', 0,          0,  "This help menu"},
  {"version",  CLI_VERSION_KEY, 0,      0,  "Print program version"},
  { 0 }
};

const char *const cli_app_version(void)
{
  return APP_VERSION;
}

const char *const cli_help_format(void)
{
  return HELP_FMT;
}

const char *const cli_documentation(void)
{
  return DOC;
}

const char *const cli_args_doc(void)
{
  return ARGS_DOC;
}

const struct argp_option *const cli_argp_options(void)
{
  return options;
}
