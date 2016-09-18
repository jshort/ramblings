/* compile: gcc -o cli -largp -L/usr/local/lib main.c helpers/cli.c */

#include <stdlib.h>
#include <argp.h>
#include <getopt.h>
#include "helpers/cli.h"

/* Parse a single option. */
static error_t parse_opt (int key, char *arg, struct argp_state *state)
{
  /* Get the input argument from argp_parse, which we
     know is a pointer to our arguments structure. */
  struct arguments *arguments = state->input;

  switch (key)
    {
    case 'q': case 's':
      arguments->silent = 1;
      break;
    case 'v':
      arguments->verbose = 1;
      break;
    case 'o':
      arguments->output_file = arg;
      break;
    case HIDDEN_KEY:
      arguments->hidden = 1;
      break;
    case 'h':
      argp_state_help (state, state->out_stream, ARGP_HELP_STD_HELP);
    case CLI_VERSION_KEY:
      fprintf (state->out_stream, "%s\n", cli_app_version());
      exit (0);
    case ARGP_KEY_ARG:
      if (state->arg_num >= 2) {
        fprintf (state->out_stream, "%s\n", "*** Too many arguments ***");
        /* Too many arguments. */
        argp_state_help (state, state->out_stream,
                         SHORT_USAGE);
      }

      arguments->args[state->arg_num] = arg;
      break;
    case ARGP_KEY_END:
      if (state->arg_num < 2) {
        fprintf (state->out_stream, "%s\n", "*** Too few arguments ***");
        /* Not enough arguments. */
        argp_state_help (state, state->out_stream,
                         SHORT_USAGE);
      }
      break;
    default:
      return ARGP_ERR_UNKNOWN;
    }
  return 0;
}

/* Our argp parser. */
/* struct argp argp = { cli_argp_options(), parse_opt, cli_args_doc(), cli_documentation() }; */

int main (int argc, char **argv)
{
  struct argp argp = { cli_argp_options(), parse_opt, cli_args_doc(), cli_documentation() };
  /* Customize help output */
  setenv("ARGP_HELP_FMT", cli_help_format(), 0);

  struct arguments arguments;

  /* Default values. */
  arguments.silent = 0;
  arguments.verbose = 0;
  arguments.hidden = 0;
  arguments.output_file = "-";

  /* Parse our arguments; every option seen by parse_opt will
     be reflected in arguments. */
  argp_parse (&argp, argc, argv, ARGP_NO_HELP, 0, &arguments);

  printf ("ARG1 = %s\nARG2 = %s\nOUTPUT_FILE = %s\n"
          "VERBOSE = %s\nSILENT = %s\n"
          "HIDDEN = %s\n",
          arguments.args[0], arguments.args[1],
          arguments.output_file,
          arguments.verbose ? "yes" : "no",
          arguments.silent ?  "yes" : "no",
          arguments.hidden ?  "yes" : "no");

  exit (0);
}
