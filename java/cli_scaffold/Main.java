
import java.util.Arrays;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.commons.cli.DefaultParser;

/**
 * Main class for cli tool.
 */
public final class Main {

    private static final String SCRIPT_NAME = "test-script";

    private static final String ARG_BUCKET_REGION = "a";
    private static final String ARG_BUCKET = "b";
    private static final String ARG_ENVIRONMENT = "e";
    private static final String ARG_RUN_AS_USER = "u";
    private static final String ARG_HELP = "h";

    private Main() {
        // private constructor
    }
    /**
     * Main method entry point for cli tool.
     */
    public static void main(String[] argv) {

        Options options = new Options();
        options.addOption(new Option(ARG_ENVIRONMENT, "environment", true,
                "Target environment."));
        options.addOption(Option.builder(ARG_BUCKET).longOpt( "bucket" )
                                                    .desc( "The S3 bucket." )
                                                    .hasArg()
                                                    .argName("BUCKET")
                                                    .required()
                                                    .build());
        options.addOption(new Option(ARG_BUCKET_REGION, "aws-region-name", true,
                "The AWS region the S3 bucket is in."));
        options.addOption(new Option(ARG_RUN_AS_USER, "run-as-user", true,
                "The user."));
        options.addOption(new Option(ARG_HELP, "help", false, "Shows this help text."));


        CommandLine cmdLine = null;
        try {
            CommandLineParser parser = new DefaultParser();
            cmdLine = parser.parse(options, argv);
        } catch (ParseException e) {
            printHelpMenu(options, e.getMessage());
        }

        if (cmdLine.hasOption(ARG_HELP)) {
            printHelpMenu(options);
        }

        printOptionArgSummary(cmdLine);

        // At this point, insert your script logic which utilizes the Options and Arguments

    }

    private static void printHelpMenu(Options options, String errorMessage) {
        int exitCode = 0;
        HelpFormatter formatter = new HelpFormatter();
        formatter.setLongOptPrefix(" --");
        formatter.setLongOptSeparator("=");
        if (errorMessage != null) {
            exitCode = 1;
        }
        formatter.printHelp(SCRIPT_NAME + " [options] [args]", errorMessage, options, null);
        System.exit(exitCode);
    }

    private static void printHelpMenu(Options options) {
        printHelpMenu(options, null);
    }

    /*
    Throw away
     */
    private static void printOptionArgSummary(CommandLine commandLine) {
        System.out.println("#### Parsed Options: ####");
        for (Option o : commandLine.getOptions()) {
            System.out.println(o.getOpt() + "/" + o.getLongOpt() + " : " + o.getValue());
        }
        System.out.println("\n#### Positional arguments: ####");
        for (String s : commandLine.getArgs()) {
            System.out.println(s);
        }
        System.out.println();
        System.out.println("-u value is: " + commandLine.getOptionValue(ARG_RUN_AS_USER));
        System.out.println("-u values are: " + Arrays.toString(commandLine.getOptionValues(ARG_RUN_AS_USER)));
    }
}
