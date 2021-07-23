GIT-CONFIG(1)                                          Git Manual                                         GIT-CONFIG(1)

NNAAMMEE
       git-config - Get and set repository or global options

SSYYNNOOPPSSIISS
       _g_i_t _c_o_n_f_i_g [<file-option>] [--type=<type>] [--show-origin] [-z|--null] name [value [value_regex]]
       _g_i_t _c_o_n_f_i_g [<file-option>] [--type=<type>] --add name value
       _g_i_t _c_o_n_f_i_g [<file-option>] [--type=<type>] --replace-all name value [value_regex]
       _g_i_t _c_o_n_f_i_g [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get name [value_regex]
       _g_i_t _c_o_n_f_i_g [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get-all name [value_regex]
       _g_i_t _c_o_n_f_i_g [<file-option>] [--type=<type>] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
       _g_i_t _c_o_n_f_i_g [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
       _g_i_t _c_o_n_f_i_g [<file-option>] --unset name [value_regex]
       _g_i_t _c_o_n_f_i_g [<file-option>] --unset-all name [value_regex]
       _g_i_t _c_o_n_f_i_g [<file-option>] --rename-section old_name new_name
       _g_i_t _c_o_n_f_i_g [<file-option>] --remove-section name
       _g_i_t _c_o_n_f_i_g [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
       _g_i_t _c_o_n_f_i_g [<file-option>] --get-color name [default]
       _g_i_t _c_o_n_f_i_g [<file-option>] --get-colorbool name [stdout-is-tty]
       _g_i_t _c_o_n_f_i_g [<file-option>] -e | --edit

DDEESSCCRRIIPPTTIIOONN
       You can query/set/replace/unset options with this command. The name is actually the section and the key
       separated by a dot, and the value will be escaped.

       Multiple lines can be added to an option by using the ----aadddd option. If you want to update or unset an option
       which can occur on multiple lines, a POSIX regexp vvaalluuee__rreeggeexx needs to be given. Only the existing values that
       match the regexp are updated or unset. If you want to handle the lines that do nnoott match the regex, just prepend
       a single exclamation mark in front (see also the section called “EXAMPLES”).

       The ----ttyyppee==<<ttyyppee>> option instructs _g_i_t _c_o_n_f_i_g to ensure that incoming and outgoing values are canonicalize-able
       under the given <type>. If no ----ttyyppee==<<ttyyppee>> is given, no canonicalization will be performed. Callers may unset
       an existing ----ttyyppee specifier with ----nnoo--ttyyppee.

       When reading, the values are read from the system, global and repository local configuration files by default,
       and options ----ssyysstteemm, ----gglloobbaall, ----llooccaall, ----wwoorrkkttrreeee and ----ffiillee <<ffiilleennaammee>> can be used to tell the command to
       read from only that location (see the section called “FILES”).

       When writing, the new value is written to the repository local configuration file by default, and options
       ----ssyysstteemm, ----gglloobbaall, ----wwoorrkkttrreeee, ----ffiillee <<ffiilleennaammee>> can be used to tell the command to write to that location (you
       can say ----llooccaall but that is the default).

       This command will fail with non-zero status upon error. Some exit codes are:

       •   The section or key is invalid (ret=1),

       •   no section or name was provided (ret=2),

       •   the config file is invalid (ret=3),

       •   the config file cannot be written (ret=4),

       •   you try to unset an option which does not exist (ret=5),

       •   you try to unset/set an option for which multiple lines match (ret=5), or

       •   you try to use an invalid regexp (ret=6).

       On success, the command returns the exit code 0.

OOPPTTIIOONNSS
       --replace-all
           Default behavior is to replace at most one line. This replaces all lines matching the key (and optionally
           the value_regex).

       --add
           Adds a new line to the option without altering any existing values. This is the same as providing _^_$ as the
           value_regex in ----rreeppllaaccee--aallll.

       --get
           Get the value for a given key (optionally filtered by a regex matching the value). Returns error code 1 if
           the key was not found and the last value if multiple key values were found.

       --get-all
           Like get, but returns all values for a multi-valued key.

       --get-regexp
           Like --get-all, but interprets the name as a regular expression and writes out the key names. Regular
           expression matching is currently case-sensitive and done against a canonicalized version of the key in which
           section and variable names are lowercased, but subsection names are not.

       --get-urlmatch name URL
           When given a two-part name section.key, the value for section.<url>.key whose <url> part matches the best to
           the given URL is returned (if no such key exists, the value for section.key is used as a fallback). When
           given just the section as name, do so for all the keys in the section and list them. Returns error code 1 if
           no value is found.

       --global
           For writing options: write to global ~~//..ggiittccoonnffiigg file rather than the repository ..ggiitt//ccoonnffiigg, write to
           $$XXDDGG__CCOONNFFIIGG__HHOOMMEE//ggiitt//ccoonnffiigg file if this file exists and the ~~//..ggiittccoonnffiigg file doesn’t.

           For reading options: read only from global ~~//..ggiittccoonnffiigg and from $$XXDDGG__CCOONNFFIIGG__HHOOMMEE//ggiitt//ccoonnffiigg rather than
           from all available files.

           See also the section called “FILES”.

       --system
           For writing options: write to system-wide $$((pprreeffiixx))//eettcc//ggiittccoonnffiigg rather than the repository ..ggiitt//ccoonnffiigg.

           For reading options: read only from system-wide $$((pprreeffiixx))//eettcc//ggiittccoonnffiigg rather than from all available
           files.

           See also the section called “FILES”.

       --local
           For writing options: write to the repository ..ggiitt//ccoonnffiigg file. This is the default behavior.

           For reading options: read only from the repository ..ggiitt//ccoonnffiigg rather than from all available files.

           See also the section called “FILES”.

       --worktree
           Similar to ----llooccaall except that ..ggiitt//ccoonnffiigg..wwoorrkkttrreeee is read from or written to if eexxtteennssiioonnss..wwoorrkkttrreeeeCCoonnffiigg
           is present. If not it’s the same as ----llooccaall.

       -f config-file, --file config-file
           Use the given config file instead of the one specified by GIT_CONFIG.

       --blob blob
           Similar to ----ffiillee but use the given blob instead of a file. E.g. you can use _m_a_s_t_e_r_:_._g_i_t_m_o_d_u_l_e_s to read
           values from the file _._g_i_t_m_o_d_u_l_e_s in the master branch. See "SPECIFYING REVISIONS" section in ggiittrreevviissiioonnss(7)
           for a more complete list of ways to spell blob names.

       --remove-section
           Remove the given section from the configuration file.

       --rename-section
           Rename the given section to a new name.

       --unset
           Remove the line matching the key from config file.

       --unset-all
           Remove all lines matching the key from config file.

       -l, --list
           List all variables set in config file, along with their values.

       --type <type>
           _g_i_t _c_o_n_f_i_g will ensure that any input or output is valid under the given type constraint(s), and will
           canonicalize outgoing values in <<ttyyppee>>'s canonical form.

           Valid <<ttyyppee>>'s include:

           •   _b_o_o_l: canonicalize values as either "true" or "false".

           •   _i_n_t: canonicalize values as simple decimal numbers. An optional suffix of _k, _m, or _g will cause the
               value to be multiplied by 1024, 1048576, or 1073741824 upon input.

           •   _b_o_o_l_-_o_r_-_i_n_t: canonicalize according to either _b_o_o_l or _i_n_t, as described above.

           •   _p_a_t_h: canonicalize by adding a leading ~~ to the value of $$HHOOMMEE and ~~uusseerr to the home directory for the
               specified user. This specifier has no effect when setting the value (but you can use ggiitt ccoonnffiigg
               sseeccttiioonn..vvaarriiaabbllee ~~// from the command line to let your shell do the expansion.)

           •   _e_x_p_i_r_y_-_d_a_t_e: canonicalize by converting from a fixed or relative date-string to a timestamp. This
               specifier has no effect when setting the value.

           •   _c_o_l_o_r: When getting a value, canonicalize by converting to an ANSI color escape sequence. When setting a
               value, a sanity-check is performed to ensure that the given value is canonicalize-able as an ANSI color,
               but it is written as-is.

       --bool, --int, --bool-or-int, --path, --expiry-date
           Historical options for selecting a type specifier. Prefer instead ----ttyyppee (see above).

       --no-type
           Un-sets the previously set type specifier (if one was previously set). This option requests that _g_i_t _c_o_n_f_i_g
           not canonicalize the retrieved variable.  ----nnoo--ttyyppee has no effect without ----ttyyppee==<<ttyyppee>> or ----<<ttyyppee>>.

       -z, --null
           For all options that output values and/or keys, always end values with the null character (instead of a
           newline). Use newline instead as a delimiter between key and value. This allows for secure parsing of the
           output without getting confused e.g. by values that contain line breaks.

       --name-only
           Output only the names of config variables for ----lliisstt or ----ggeett--rreeggeexxpp.

       --show-origin
           Augment the output of all queried config options with the origin type (file, standard input, blob, command
           line) and the actual origin (config file path, ref, or blob id if applicable).

       --get-colorbool name [stdout-is-tty]
           Find the color setting for nnaammee (e.g.  ccoolloorr..ddiiffff) and output "true" or "false".  ssttddoouutt--iiss--ttttyy should be
           either "true" or "false", and is taken into account when configuration says "auto". If ssttddoouutt--iiss--ttttyy is
           missing, then checks the standard output of the command itself, and exits with status 0 if color is to be
           used, or exits with status 1 otherwise. When the color setting for nnaammee is undefined, the command uses
           ccoolloorr..uuii as fallback.

       --get-color name [default]
           Find the color configured for nnaammee (e.g.  ccoolloorr..ddiiffff..nneeww) and output it as the ANSI color escape sequence to
           the standard output. The optional ddeeffaauulltt parameter is used instead, if there is no color configured for
           nnaammee.

           ----ttyyppee==ccoolloorr [[----ddeeffaauulltt==<<ddeeffaauulltt>>]] is preferred over ----ggeett--ccoolloorr (but note that ----ggeett--ccoolloorr will omit the
           trailing newline printed by ----ttyyppee==ccoolloorr).

       -e, --edit
           Opens an editor to modify the specified config file; either ----ssyysstteemm, ----gglloobbaall, or repository (default).

       --[no-]includes
           Respect iinncclluuddee..**  directives in config files when looking up values. Defaults to ooffff when a specific file
           is given (e.g., using ----ffiillee, ----gglloobbaall, etc) and oonn when searching all config files.

       --default <value>
           When using ----ggeett, and the requested variable is not found, behave as if <value> were the value assigned to
           the that variable.

CCOONNFFIIGGUURRAATTIIOONN
       ppaaggeerr..ccoonnffiigg is only respected when listing configuration, i.e., when using ----lliisstt or any of the ----ggeett--** which
       may return multiple results. The default is to use a pager.

FFIILLEESS
       If not set explicitly with ----ffiillee, there are four files where _g_i_t _c_o_n_f_i_g will search for configuration options:

       $(prefix)/etc/gitconfig
           System-wide configuration file.

       $XDG_CONFIG_HOME/git/config
           Second user-specific configuration file. If $XDG_CONFIG_HOME is not set or empty, $$HHOOMMEE//..ccoonnffiigg//ggiitt//ccoonnffiigg
           will be used. Any single-valued variable set in this file will be overwritten by whatever is in
           ~~//..ggiittccoonnffiigg. It is a good idea not to create this file if you sometimes use older versions of Git, as
           support for this file was added fairly recently.

       ~/.gitconfig
           User-specific configuration file. Also called "global" configuration file.

       $GIT_DIR/config
           Repository specific configuration file.

       $GIT_DIR/config.worktree
           This is optional and is only searched when eexxtteennssiioonnss..wwoorrkkttrreeeeCCoonnffiigg is present in $GIT_DIR/config.

       If no further options are given, all reading options will read all of these files that are available. If the
       global or the system-wide configuration file are not available they will be ignored. If the repository
       configuration file is not available or readable, _g_i_t _c_o_n_f_i_g will exit with a non-zero error code. However, in
       neither case will an error message be issued.

       The files are read in the order given above, with last value found taking precedence over values read earlier.
       When multiple values are taken then all values of a key from all files will be used.

       You may override individual configuration parameters when running any git command by using the --cc option. See
       ggiitt(1) for details.

       All writing options will per default write to the repository specific configuration file. Note that this also
       affects options like ----rreeppllaaccee--aallll and ----uunnsseett. _g_i_t _c_o_n_f_i_g wwiillll oonnllyy eevveerr cchhaannggee oonnee ffiillee aatt aa ttiimmee.

       You can override these rules either by command-line options or by environment variables. The ----gglloobbaall, ----ssyysstteemm
       and ----wwoorrkkttrreeee options will limit the file used to the global, system-wide or per-worktree file respectively.
       The GGIITT__CCOONNFFIIGG environment variable has a similar effect, but you can specify any filename you want.

EENNVVIIRROONNMMEENNTT
       GIT_CONFIG
           Take the configuration from the given file instead of .git/config. Using the "--global" option forces this
           to ~/.gitconfig. Using the "--system" option forces this to $(prefix)/etc/gitconfig.

       GIT_CONFIG_NOSYSTEM
           Whether to skip reading settings from the system-wide $(prefix)/etc/gitconfig file. See ggiitt(1) for details.

       See also the section called “FILES”.

EEXXAAMMPPLLEESS
       Given a .git/config like this:

           #
           # This is the config file, and
           # a '#' or ';' character indicates
           # a comment
           #

           ; core variables
           [core]
                   ; Don't trust file modes
                   filemode = false

           ; Our diff algorithm
           [diff]
                   external = /usr/local/bin/diff-wrapper
                   renames = true

           ; Proxy settings
           [core]
                   gitproxy=proxy-command for kernel.org
                   gitproxy=default-proxy ; for all the rest

           ; HTTP
           [http]
                   sslVerify
           [http "https://weak.example.com"]
                   sslVerify = false
                   cookieFile = /tmp/cookie.txt

       you can set the filemode to true with

           % git config core.filemode true

       The hypothetical proxy command entries actually have a postfix to discern what URL they apply to. Here is how to
       change the entry for kernel.org to "ssh".

           % git config core.gitproxy '"ssh" for kernel.org' 'for kernel.org$'

       This makes sure that only the key/value pair for kernel.org is replaced.

       To delete the entry for renames, do

           % git config --unset diff.renames

       If you want to delete an entry for a multivar (like core.gitproxy above), you have to provide a regex matching
       the value of exactly one line.

       To query the value for a given key, do

           % git config --get core.filemode

       or

           % git config core.filemode

       or, to query a multivar:

           % git config --get core.gitproxy "for kernel.org$"

       If you want to know all the values for a multivar, do:

           % git config --get-all core.gitproxy

       If you like to live dangerously, you can replace aallll core.gitproxy by a new one with

           % git config --replace-all core.gitproxy ssh

       However, if you really only want to replace the line for the default proxy, i.e. the one without a "for ..."
       postfix, do something like this:

           % git config core.gitproxy ssh '! for '

       To actually match only values with an exclamation mark, you have to

           % git config section.key value '[!]'

       To add a new proxy, without altering any of the existing ones, use

           % git config --add core.gitproxy '"proxy-command" for example.com'

       An example to use customized color from the configuration in your script:

           #!/bin/sh
           WS=$(git config --get-color color.diff.whitespace "blue reverse")
           RESET=$(git config --get-color "" "reset")
           echo "${WS}your whitespace color or blue reverse${RESET}"

       For URLs in hhttttppss::////wweeaakk..eexxaammppllee..ccoomm, hhttttpp..ssssllVVeerriiffyy is set to false, while it is set to ttrruuee for all others:

           % git config --type=bool --get-urlmatch http.sslverify https://good.example.com
           true
           % git config --type=bool --get-urlmatch http.sslverify https://weak.example.com
           false
           % git config --get-urlmatch http https://weak.example.com
           http.cookieFile /tmp/cookie.txt
           http.sslverify false

CCOONNFFIIGGUURRAATTIIOONN FFIILLEE
       The Git configuration file contains a number of variables that affect the Git commands' behavior. The files
       ..ggiitt//ccoonnffiigg and optionally ccoonnffiigg..wwoorrkkttrreeee (see eexxtteennssiioonnss..wwoorrkkttrreeeeCCoonnffiigg below) in each repository are used to
       store the configuration for that repository, and $$HHOOMMEE//..ggiittccoonnffiigg is used to store a per-user configuration as
       fallback values for the ..ggiitt//ccoonnffiigg file. The file //eettcc//ggiittccoonnffiigg can be used to store a system-wide default
       configuration.

       The configuration variables are used by both the Git plumbing and the porcelains. The variables are divided into
       sections, wherein the fully qualified variable name of the variable itself is the last dot-separated segment and
       the section name is everything before the last dot. The variable names are case-insensitive, allow only
       alphanumeric characters and --, and must start with an alphabetic character. Some variables may appear multiple
       times; we say then that the variable is multivalued.

   SSyynnttaaxx
       The syntax is fairly flexible and permissive; whitespaces are mostly ignored. The _# and _; characters begin
       comments to the end of line, blank lines are ignored.

       The file consists of sections and variables. A section begins with the name of the section in square brackets
       and continues until the next section begins. Section names are case-insensitive. Only alphanumeric characters, --
       and .. are allowed in section names. Each variable must belong to some section, which means that there must be a
       section header before the first setting of a variable.

       Sections can be further divided into subsections. To begin a subsection put its name in double quotes, separated
       by space from the section name, in the section header, like in the example below:

                   [section "subsection"]

       Subsection names are case sensitive and can contain any characters except newline and the null byte. Doublequote
       "" and backslash can be included by escaping them as \\"" and \\\\, respectively. Backslashes preceding other
       characters are dropped when reading; for example, \\tt is read as tt and \\00 is read as 00 Section headers cannot
       span multiple lines. Variables may belong directly to a section or to a given subsection. You can have [[sseeccttiioonn]]
       if you have [[sseeccttiioonn ""ssuubbsseeccttiioonn""]], but you don’t need to.

       There is also a deprecated [[sseeccttiioonn..ssuubbsseeccttiioonn]] syntax. With this syntax, the subsection name is converted to
       lower-case and is also compared case sensitively. These subsection names follow the same restrictions as section
       names.

       All the other lines (and the remainder of the line after the section header) are recognized as setting
       variables, in the form _n_a_m_e _= _v_a_l_u_e (or just _n_a_m_e, which is a short-hand to say that the variable is the boolean
       "true"). The variable names are case-insensitive, allow only alphanumeric characters and --, and must start with
       an alphabetic character.

       A line that defines a value can be continued to the next line by ending it with a \\; the backquote and the
       end-of-line are stripped. Leading whitespaces after _n_a_m_e _=, the remainder of the line after the first comment
       character _# or _;, and trailing whitespaces of the line are discarded unless they are enclosed in double quotes.
       Internal whitespaces within the value are retained verbatim.

       Inside double quotes, double quote "" and backslash \\ characters must be escaped: use \\"" for "" and \\\\ for \\.

       The following escape sequences (beside \\"" and \\\\) are recognized: \\nn for newline character (NL), \\tt for
       horizontal tabulation (HT, TAB) and \\bb for backspace (BS). Other char escape sequences (including octal escape
       sequences) are invalid.

   IInncclluuddeess
       The iinncclluuddee and iinncclluuddeeIIff sections allow you to include config directives from another source. These sections
       behave identically to each other with the exception that iinncclluuddeeIIff sections may be ignored if their condition
       does not evaluate to true; see "Conditional includes" below.

       You can include a config file from another by setting the special iinncclluuddee..ppaatthh (or iinncclluuddeeIIff..**..ppaatthh) variable to
       the name of the file to be included. The variable takes a pathname as its value, and is subject to tilde
       expansion. These variables can be given multiple times.

       The contents of the included file are inserted immediately, as if they had been found at the location of the
       include directive. If the value of the variable is a relative path, the path is considered to be relative to the
       configuration file in which the include directive was found. See below for examples.

   CCoonnddiittiioonnaall iinncclluuddeess
       You can include a config file from another conditionally by setting a iinncclluuddeeIIff..<<ccoonnddiittiioonn>>..ppaatthh variable to the
       name of the file to be included.

       The condition starts with a keyword followed by a colon and some data whose format and meaning depends on the
       keyword. Supported keywords are:

       ggiittddiirr
           The data that follows the keyword ggiittddiirr:: is used as a glob pattern. If the location of the .git directory
           matches the pattern, the include condition is met.

           The .git location may be auto-discovered, or come from $$GGIITT__DDIIRR environment variable. If the repository is
           auto discovered via a .git file (e.g. from submodules, or a linked worktree), the .git location would be the
           final location where the .git directory is, not where the .git file is.

           The pattern can contain standard globbing wildcards and two additional ones, ****// and //****, that can match
           multiple path components. Please refer to ggiittiiggnnoorree(5) for details. For convenience:

           •   If the pattern starts with ~~//, ~~ will be substituted with the content of the environment variable HHOOMMEE.

           •   If the pattern starts with ..//, it is replaced with the directory containing the current config file.

           •   If the pattern does not start with either ~~//, ..// or //, ****// will be automatically prepended. For example,
               the pattern ffoooo//bbaarr becomes ****//ffoooo//bbaarr and would match //aannyy//ppaatthh//ttoo//ffoooo//bbaarr.

           •   If the pattern ends with //, **** will be automatically added. For example, the pattern ffoooo// becomes
               ffoooo//****. In other words, it matches "foo" and everything inside, recursively.

       ggiittddiirr//ii
           This is the same as ggiittddiirr except that matching is done case-insensitively (e.g. on case-insensitive file
           systems)

       oonnbbrraanncchh
           The data that follows the keyword oonnbbrraanncchh:: is taken to be a pattern with standard globbing wildcards and
           two additional ones, ****// and //****, that can match multiple path components. If we are in a worktree where the
           name of the branch that is currently checked out matches the pattern, the include condition is met.

           If the pattern ends with //, **** will be automatically added. For example, the pattern ffoooo// becomes ffoooo//****. In
           other words, it matches all branches that begin with ffoooo//. This is useful if your branches are organized
           hierarchically and you would like to apply a configuration to all the branches in that hierarchy.

       A few more notes on matching via ggiittddiirr and ggiittddiirr//ii:

       •   Symlinks in $$GGIITT__DDIIRR are not resolved before matching.

       •   Both the symlink & realpath versions of paths will be matched outside of $$GGIITT__DDIIRR. E.g. if ~/git is a
           symlink to /mnt/storage/git, both ggiittddiirr::~~//ggiitt and ggiittddiirr:://mmnntt//ssttoorraaggee//ggiitt will match.

           This was not the case in the initial release of this feature in v2.13.0, which only matched the realpath
           version. Configuration that wants to be compatible with the initial release of this feature needs to either
           specify only the realpath version, or both versions.

       •   Note that "../" is not special and will match literally, which is unlikely what you want.

   EExxaammppllee
           # Core variables
           [core]
                   ; Don't trust file modes
                   filemode = false

           # Our diff algorithm
           [diff]
                   external = /usr/local/bin/diff-wrapper
                   renames = true

           [branch "devel"]
                   remote = origin
                   merge = refs/heads/devel

           # Proxy settings
           [core]
                   gitProxy="ssh" for "kernel.org"
                   gitProxy=default-proxy ; for the rest

           [include]
                   path = /path/to/foo.inc ; include by absolute path
                   path = foo.inc ; find "foo.inc" relative to the current file
                   path = ~/foo.inc ; find "foo.inc" in your `$HOME` directory

           ; include if $GIT_DIR is /path/to/foo/.git
           [includeIf "gitdir:/path/to/foo/.git"]
                   path = /path/to/foo.inc

           ; include for all repositories inside /path/to/group
           [includeIf "gitdir:/path/to/group/"]
                   path = /path/to/foo.inc

           ; include for all repositories inside $HOME/to/group
           [includeIf "gitdir:~/to/group/"]
                   path = /path/to/foo.inc

           ; relative paths are always relative to the including
           ; file (if the condition is true); their location is not
           ; affected by the condition
           [includeIf "gitdir:/path/to/group/"]
                   path = foo.inc

           ; include only if we are in a worktree where foo-branch is
           ; currently checked out
           [includeIf "onbranch:foo-branch"]
                   path = foo.inc

   VVaalluueess
       Values of many variables are treated as a simple string, but there are variables that take values of specific
       types and there are rules as to how to spell them.

       boolean
           When a variable is said to take a boolean value, many synonyms are accepted for _t_r_u_e and _f_a_l_s_e; these are
           all case-insensitive.

           true
               Boolean true literals are yyeess, oonn, ttrruuee, and 11. Also, a variable defined without == <<vvaalluuee>> is taken as
               true.

           false
               Boolean false literals are nnoo, ooffff, ffaallssee, 00 and the empty string.

               When converting a value to its canonical form using the ----ttyyppee==bbooooll type specifier, _g_i_t _c_o_n_f_i_g will
               ensure that the output is "true" or "false" (spelled in lowercase).

       integer
           The value for many variables that specify various sizes can be suffixed with kk, MM,... to mean "scale the
           number by 1024", "by 1024x1024", etc.

       color
           The value for a variable that takes a color is a list of colors (at most two, one for foreground and one for
           background) and attributes (as many as you want), separated by spaces.

           The basic colors accepted are nnoorrmmaall, bbllaacckk, rreedd, ggrreeeenn, yyeellllooww, bblluuee, mmaaggeennttaa, ccyyaann and wwhhiittee. The first
           color given is the foreground; the second is the background.

           Colors may also be given as numbers between 0 and 255; these use ANSI 256-color mode (but note that not all
           terminals may support this). If your terminal supports it, you may also specify 24-bit RGB values as hex,
           like ##ffff00aabb33.

           The accepted attributes are bboolldd, ddiimm, uull, bblliinnkk, rreevveerrssee, iittaalliicc, and ssttrriikkee (for crossed-out or
           "strikethrough" letters). The position of any attributes with respect to the colors (before, after, or in
           between), doesn’t matter. Specific attributes may be turned off by prefixing them with nnoo or nnoo-- (e.g.,
           nnoorreevveerrssee, nnoo--uull, etc).

           An empty color string produces no color effect at all. This can be used to avoid coloring specific elements
           without disabling color entirely.

           For git’s pre-defined color slots, the attributes are meant to be reset at the beginning of each item in the
           colored output. So setting ccoolloorr..ddeeccoorraattee..bbrraanncchh to bbllaacckk will paint that branch name in a plain bbllaacckk, even
           if the previous thing on the same output line (e.g. opening parenthesis before the list of branch names in
           lloogg ----ddeeccoorraattee output) is set to be painted with bboolldd or some other attribute. However, custom log formats
           may do more complicated and layered coloring, and the negated forms may be useful there.

       pathname
           A variable that takes a pathname value can be given a string that begins with "~~//" or "~~uusseerr//", and the
           usual tilde expansion happens to such a string: ~~// is expanded to the value of $$HHOOMMEE, and ~~uusseerr// to the
           specified user’s home directory.

   VVaarriiaabblleess
       Note that this list is non-comprehensive and not necessarily complete. For command-specific variables, you will
       find a more detailed description in the appropriate manual page.

       Other git-related tools may and do use their own variables. When inventing new variables for use in your own
       tool, make sure their names do not conflict with those that are used by Git itself and other popular tools, and
       describe them in your documentation.

       advice.*
           These variables control various optional help messages designed to aid new users. All _a_d_v_i_c_e_._*  variables
           default to _t_r_u_e, and you can tell Git that you do not need help by setting these to _f_a_l_s_e:

           fetchShowForcedUpdates
               Advice shown when ggiitt--ffeettcchh(1) takes a long time to calculate forced updates after ref updates, or to
               warn that the check is disabled.

           pushUpdateRejected
               Set this variable to _f_a_l_s_e if you want to disable _p_u_s_h_N_o_n_F_F_C_u_r_r_e_n_t, _p_u_s_h_N_o_n_F_F_M_a_t_c_h_i_n_g,
               _p_u_s_h_A_l_r_e_a_d_y_E_x_i_s_t_s, _p_u_s_h_F_e_t_c_h_F_i_r_s_t, and _p_u_s_h_N_e_e_d_s_F_o_r_c_e simultaneously.

           pushNonFFCurrent
               Advice shown when ggiitt--ppuusshh(1) fails due to a non-fast-forward update to the current branch.

           pushNonFFMatching
               Advice shown when you ran ggiitt--ppuusshh(1) and pushed _m_a_t_c_h_i_n_g _r_e_f_s explicitly (i.e. you used _:, or specified
               a refspec that isn’t your current branch) and it resulted in a non-fast-forward error.

           pushAlreadyExists
               Shown when ggiitt--ppuusshh(1) rejects an update that does not qualify for fast-forwarding (e.g., a tag.)

           pushFetchFirst
               Shown when ggiitt--ppuusshh(1) rejects an update that tries to overwrite a remote ref that points at an object
               we do not have.

           pushNeedsForce
               Shown when ggiitt--ppuusshh(1) rejects an update that tries to overwrite a remote ref that points at an object
               that is not a commit-ish, or make the remote ref point at an object that is not a commit-ish.

           pushUnqualifiedRefname
               Shown when ggiitt--ppuusshh(1) gives up trying to guess based on the source and destination refs what remote ref
               namespace the source belongs in, but where we can still suggest that the user push to either
               refs/heads/* or refs/tags/* based on the type of the source object.

           statusAheadBehind
               Shown when ggiitt--ssttaattuuss(1) computes the ahead/behind counts for a local ref compared to its remote
               tracking ref, and that calculation takes longer than expected. Will not appear if ssttaattuuss..aahheeaaddBBeehhiinndd is
               false or the option ----nnoo--aahheeaadd--bbeehhiinndd is given.

           statusHints
               Show directions on how to proceed from the current state in the output of ggiitt--ssttaattuuss(1), in the template
               shown when writing commit messages in ggiitt--ccoommmmiitt(1), and in the help message shown by ggiitt--sswwiittcchh(1) or
               ggiitt--cchheecckkoouutt(1) when switching branch.

           statusUoption
               Advise to consider using the --uu option to ggiitt--ssttaattuuss(1) when the command takes more than 2 seconds to
               enumerate untracked files.

           commitBeforeMerge
               Advice shown when ggiitt--mmeerrggee(1) refuses to merge to avoid overwriting local changes.

           resetQuiet
               Advice to consider using the ----qquuiieett option to ggiitt--rreesseett(1) when the command takes more than 2 seconds
               to enumerate unstaged changes after reset.

           resolveConflict
               Advice shown by various commands when conflicts prevent the operation from being performed.

           sequencerInUse
               Advice shown when a sequencer command is already in progress.

           implicitIdentity
               Advice on how to set your identity configuration when your information is guessed from the system
               username and domain name.

           detachedHead
               Advice shown when you used ggiitt--sswwiittcchh(1) or ggiitt--cchheecckkoouutt(1) to move to the detach HEAD state, to
               instruct how to create a local branch after the fact.

           checkoutAmbiguousRemoteBranchName
               Advice shown when the argument to ggiitt--cchheecckkoouutt(1) and ggiitt--sswwiittcchh(1) ambiguously resolves to a remote
               tracking branch on more than one remote in situations where an unambiguous argument would have otherwise
               caused a remote-tracking branch to be checked out. See the cchheecckkoouutt..ddeeffaauullttRReemmoottee configuration variable
               for how to set a given remote to used by default in some situations where this advice would be printed.

           amWorkDir
               Advice that shows the location of the patch file when ggiitt--aamm(1) fails to apply it.

           rmHints
               In case of failure in the output of ggiitt--rrmm(1), show directions on how to proceed from the current state.

           addEmbeddedRepo
               Advice on what to do when you’ve accidentally added one git repo inside of another.

           ignoredHook
               Advice shown if a hook is ignored because the hook is not set as executable.

           waitingForEditor
               Print a message to the terminal whenever Git is waiting for editor input from the user.

           nestedTag
               Advice shown if a user attempts to recursively tag a tag object.

           submoduleAlternateErrorStrategyDie
               Advice shown when a submodule.alternateErrorStrategy option configured to "die" causes a fatal error.

       core.fileMode
           Tells Git if the executable bit of files in the working tree is to be honored.

           Some filesystems lose the executable bit when a file that is marked as executable is checked out, or checks
           out a non-executable file with executable bit on.  ggiitt--cclloonnee(1) or ggiitt--iinniitt(1) probe the filesystem to see
           if it handles the executable bit correctly and this variable is automatically set as necessary.

           A repository, however, may be on a filesystem that handles the filemode correctly, and this variable is set
           to _t_r_u_e when created, but later may be made accessible from another environment that loses the filemode
           (e.g. exporting ext4 via CIFS mount, visiting a Cygwin created repository with Git for Windows or Eclipse).
           In such a case it may be necessary to set this variable to _f_a_l_s_e. See ggiitt--uuppddaattee--iinnddeexx(1).

           The default is true (when core.filemode is not specified in the config file).

       core.hideDotFiles
           (Windows-only) If true, mark newly-created directories and files whose name starts with a dot as hidden. If
           _d_o_t_G_i_t_O_n_l_y, only the ..ggiitt// directory is hidden, but no other files starting with a dot. The default mode is
           _d_o_t_G_i_t_O_n_l_y.

       core.ignoreCase
           Internal variable which enables various workarounds to enable Git to work better on filesystems that are not
           case sensitive, like APFS, HFS+, FAT, NTFS, etc. For example, if a directory listing finds "makefile" when
           Git expects "Makefile", Git will assume it is really the same file, and continue to remember it as
           "Makefile".

           The default is false, except ggiitt--cclloonnee(1) or ggiitt--iinniitt(1) will probe and set core.ignoreCase true if
           appropriate when the repository is created.

           Git relies on the proper configuration of this variable for your operating and file system. Modifying this
           value may result in unexpected behavior.

       core.precomposeUnicode
           This option is only used by Mac OS implementation of Git. When core.precomposeUnicode=true, Git reverts the
           unicode decomposition of filenames done by Mac OS. This is useful when sharing a repository between Mac OS
           and Linux or Windows. (Git for Windows 1.7.10 or higher is needed, or Git under cygwin 1.7). When false,
           file names are handled fully transparent by Git, which is backward compatible with older versions of Git.

       core.protectHFS
           If set to true, do not allow checkout of paths that would be considered equivalent to ..ggiitt on an HFS+
           filesystem. Defaults to ttrruuee on Mac OS, and ffaallssee elsewhere.

       core.protectNTFS
           If set to true, do not allow checkout of paths that would cause problems with the NTFS filesystem, e.g.
           conflict with 8.3 "short" names. Defaults to ttrruuee on Windows, and ffaallssee elsewhere.

       core.fsmonitor
           If set, the value of this variable is used as a command which will identify all files that may have changed
           since the requested date/time. This information is used to speed up git by avoiding unnecessary processing
           of files that have not changed. See the "fsmonitor-watchman" section of ggiitthhooookkss(5).

       core.trustctime
           If false, the ctime differences between the index and the working tree are ignored; useful when the inode
           change time is regularly modified by something outside Git (file system crawlers and some backup systems).
           See ggiitt--uuppddaattee--iinnddeexx(1). True by default.

       core.splitIndex
           If true, the split-index feature of the index will be used. See ggiitt--uuppddaattee--iinnddeexx(1). False by default.

       core.untrackedCache
           Determines what to do about the untracked cache feature of the index. It will be kept, if this variable is
           unset or set to kkeeeepp. It will automatically be added if set to ttrruuee. And it will automatically be removed,
           if set to ffaallssee. Before setting it to ttrruuee, you should check that mtime is working properly on your system.
           See ggiitt--uuppddaattee--iinnddeexx(1).  kkeeeepp by default, unless ffeeaattuurree..mmaannyyFFiilleess is enabled which sets this setting to
           ttrruuee by default.

       core.checkStat
           When missing or is set to ddeeffaauulltt, many fields in the stat structure are checked to detect if a file has
           been modified since Git looked at it. When this configuration variable is set to mmiinniimmaall, sub-second part of
           mtime and ctime, the uid and gid of the owner of the file, the inode number (and the device number, if Git
           was compiled to use it), are excluded from the check among these fields, leaving only the whole-second part
           of mtime (and ctime, if ccoorree..ttrruussttCCttiimmee is set) and the filesize to be checked.

           There are implementations of Git that do not leave usable values in some fields (e.g. JGit); by excluding
           these fields from the comparison, the mmiinniimmaall mode may help interoperability when the same repository is
           used by these other systems at the same time.

       core.quotePath
           Commands that output paths (e.g.  _l_s_-_f_i_l_e_s, _d_i_f_f), will quote "unusual" characters in the pathname by
           enclosing the pathname in double-quotes and escaping those characters with backslashes in the same way C
           escapes control characters (e.g.  \\tt for TAB, \\nn for LF, \\\\ for backslash) or bytes with values larger than
           0x80 (e.g. octal \\330022\\226655 for "micro" in UTF-8). If this variable is set to false, bytes higher than 0x80
           are not considered "unusual" any more. Double-quotes, backslash and control characters are always escaped
           regardless of the setting of this variable. A simple space character is not considered "unusual". Many
           commands can output pathnames completely verbatim using the --zz option. The default value is true.

       core.eol
           Sets the line ending type to use in the working directory for files that are marked as text (either by
           having the tteexxtt attribute set, or by having tteexxtt==aauuttoo and Git auto-detecting the contents as text).
           Alternatives are _l_f, _c_r_l_f and _n_a_t_i_v_e, which uses the platform’s native line ending. The default value is
           nnaattiivvee. See ggiittaattttrriibbuutteess(5) for more information on end-of-line conversion. Note that this value is ignored
           if ccoorree..aauuttooccrrllff is set to ttrruuee or iinnppuutt.

       core.safecrlf
           If true, makes Git check if converting CCRRLLFF is reversible when end-of-line conversion is active. Git will
           verify if a command modifies a file in the work tree either directly or indirectly. For example, committing
           a file followed by checking out the same file should yield the original file in the work tree. If this is
           not the case for the current setting of ccoorree..aauuttooccrrllff, Git will reject the file. The variable can be set to
           "warn", in which case Git will only warn about an irreversible conversion but continue the operation.

           CRLF conversion bears a slight chance of corrupting data. When it is enabled, Git will convert CRLF to LF
           during commit and LF to CRLF during checkout. A file that contains a mixture of LF and CRLF before the
           commit cannot be recreated by Git. For text files this is the right thing to do: it corrects line endings
           such that we have only LF line endings in the repository. But for binary files that are accidentally
           classified as text the conversion can corrupt data.

           If you recognize such corruption early you can easily fix it by setting the conversion type explicitly in
           .gitattributes. Right after committing you still have the original file in your work tree and this file is
           not yet corrupted. You can explicitly tell Git that this file is binary and Git will handle the file
           appropriately.

           Unfortunately, the desired effect of cleaning up text files with mixed line endings and the undesired effect
           of corrupting binary files cannot be distinguished. In both cases CRLFs are removed in an irreversible way.
           For text files this is the right thing to do because CRLFs are line endings, while for binary files
           converting CRLFs corrupts data.

           Note, this safety check does not mean that a checkout will generate a file identical to the original file
           for a different setting of ccoorree..eeooll and ccoorree..aauuttooccrrllff, but only for the current one. For example, a text
           file with LLFF would be accepted with ccoorree..eeooll==llff and could later be checked out with ccoorree..eeooll==ccrrllff, in which
           case the resulting file would contain CCRRLLFF, although the original file contained LLFF. However, in both work
           trees the line endings would be consistent, that is either all LLFF or all CCRRLLFF, but never mixed. A file with
           mixed line endings would be reported by the ccoorree..ssaaffeeccrrllff mechanism.

       core.autocrlf
           Setting this variable to "true" is the same as setting the tteexxtt attribute to "auto" on all files and
           core.eol to "crlf". Set to true if you want to have CCRRLLFF line endings in your working directory and the
           repository has LF line endings. This variable can be set to _i_n_p_u_t, in which case no output conversion is
           performed.

       core.checkRoundtripEncoding
           A comma and/or whitespace separated list of encodings that Git performs UTF-8 round trip checks on if they
           are used in an wwoorrkkiinngg--ttrreeee--eennccooddiinngg attribute (see ggiittaattttrriibbuutteess(5)). The default value is SSHHIIFFTT--JJIISS.

       core.symlinks
           If false, symbolic links are checked out as small plain files that contain the link text.  ggiitt--uuppddaattee--
           iinnddeexx(1) and ggiitt--aadddd(1) will not change the recorded type to regular file. Useful on filesystems like FAT
           that do not support symbolic links.

           The default is true, except ggiitt--cclloonnee(1) or ggiitt--iinniitt(1) will probe and set core.symlinks false if
           appropriate when the repository is created.

       core.gitProxy
           A "proxy command" to execute (as _c_o_m_m_a_n_d _h_o_s_t _p_o_r_t) instead of establishing direct connection to the remote
           server when using the Git protocol for fetching. If the variable value is in the "COMMAND for DOMAIN"
           format, the command is applied only on hostnames ending with the specified domain string. This variable may
           be set multiple times and is matched in the given order; the first match wins.

           Can be overridden by the GGIITT__PPRROOXXYY__CCOOMMMMAANNDD environment variable (which always applies universally, without
           the special "for" handling).

           The special string nnoonnee can be used as the proxy command to specify that no proxy be used for a given domain
           pattern. This is useful for excluding servers inside a firewall from proxy use, while defaulting to a common
           proxy for external domains.

       core.sshCommand
           If this variable is set, ggiitt ffeettcchh and ggiitt ppuusshh will use the specified command instead of sssshh when they need
           to connect to a remote system. The command is in the same form as the GGIITT__SSSSHH__CCOOMMMMAANNDD environment variable
           and is overridden when the environment variable is set.

       core.ignoreStat
           If true, Git will avoid using lstat() calls to detect if files have changed by setting the
           "assume-unchanged" bit for those tracked files which it has updated identically in both the index and
           working tree.

           When files are modified outside of Git, the user will need to stage the modified files explicitly (e.g. see
           _E_x_a_m_p_l_e_s section in ggiitt--uuppddaattee--iinnddeexx(1)). Git will not normally detect changes to those files.

           This is useful on systems where lstat() calls are very slow, such as CIFS/Microsoft Windows.

           False by default.

       core.preferSymlinkRefs
           Instead of the default "symref" format for HEAD and other symbolic reference files, use symbolic links. This
           is sometimes needed to work with old scripts that expect HEAD to be a symbolic link.

       core.alternateRefsCommand
           When advertising tips of available history from an alternate, use the shell to execute the specified command
           instead of ggiitt--ffoorr--eeaacchh--rreeff(1). The first argument is the absolute path of the alternate. Output must
           contain one hex object id per line (i.e., the same as produced by ggiitt ffoorr--eeaacchh--rreeff
           ----ffoorrmmaatt==''%%((oobbjjeeccttnnaammee))'').

           Note that you cannot generally put ggiitt ffoorr--eeaacchh--rreeff directly into the config value, as it does not take a
           repository path as an argument (but you can wrap the command above in a shell script).

       core.alternateRefsPrefixes
           When listing references from an alternate, list only references that begin with the given prefix. Prefixes
           match as if they were given as arguments to ggiitt--ffoorr--eeaacchh--rreeff(1). To list multiple prefixes, separate them
           with whitespace. If ccoorree..aalltteerrnnaatteeRReeffssCCoommmmaanndd is set, setting ccoorree..aalltteerrnnaatteeRReeffssPPrreeffiixxeess has no effect.

       core.bare
           If true this repository is assumed to be _b_a_r_e and has no working directory associated with it. If this is
           the case a number of commands that require a working directory will be disabled, such as ggiitt--aadddd(1) or ggiitt--
           mmeerrggee(1).

           This setting is automatically guessed by ggiitt--cclloonnee(1) or ggiitt--iinniitt(1) when the repository was created. By
           default a repository that ends in "/.git" is assumed to be not bare (bare = false), while all other
           repositories are assumed to be bare (bare = true).

       core.worktree
           Set the path to the root of the working tree. If GGIITT__CCOOMMMMOONN__DDIIRR environment variable is set, core.worktree
           is ignored and not used for determining the root of working tree. This can be overridden by the
           GGIITT__WWOORRKK__TTRREEEE environment variable and the ----wwoorrkk--ttrreeee command-line option. The value can be an absolute
           path or relative to the path to the .git directory, which is either specified by --git-dir or GIT_DIR, or
           automatically discovered. If --git-dir or GIT_DIR is specified but none of --work-tree, GIT_WORK_TREE and
           core.worktree is specified, the current working directory is regarded as the top level of your working tree.

           Note that this variable is honored even when set in a configuration file in a ".git" subdirectory of a
           directory and its value differs from the latter directory (e.g. "/path/to/.git/config" has core.worktree set
           to "/different/path"), which is most likely a misconfiguration. Running Git commands in the "/path/to"
           directory will still use "/different/path" as the root of the work tree and can cause confusion unless you
           know what you are doing (e.g. you are creating a read-only snapshot of the same index to a location
           different from the repository’s usual working tree).

       core.logAllRefUpdates
           Enable the reflog. Updates to a ref <ref> is logged to the file "$$GGIITT__DDIIRR//llooggss//<<rreeff>>", by appending the new
           and old SHA-1, the date/time and the reason of the update, but only when the file exists. If this
           configuration variable is set to ttrruuee, missing "$$GGIITT__DDIIRR//llooggss//<<rreeff>>" file is automatically created for
           branch heads (i.e. under rreeffss//hheeaaddss//), remote refs (i.e. under rreeffss//rreemmootteess//), note refs (i.e. under
           rreeffss//nnootteess//), and the symbolic ref HHEEAADD. If it is set to aallwwaayyss, then a missing reflog is automatically
           created for any ref under rreeffss//.

           This information can be used to determine what commit was the tip of a branch "2 days ago".

           This value is true by default in a repository that has a working directory associated with it, and false by
           default in a bare repository.

       core.repositoryFormatVersion
           Internal variable identifying the repository format and layout version.

       core.sharedRepository
           When _g_r_o_u_p (or _t_r_u_e), the repository is made shareable between several users in a group (making sure all the
           files and objects are group-writable). When _a_l_l (or _w_o_r_l_d or _e_v_e_r_y_b_o_d_y), the repository will be readable by
           all users, additionally to being group-shareable. When _u_m_a_s_k (or _f_a_l_s_e), Git will use permissions reported
           by umask(2). When _0_x_x_x, where _0_x_x_x is an octal number, files in the repository will have this mode value.
           _0_x_x_x will override user’s umask value (whereas the other options will only override requested parts of the
           user’s umask value). Examples: _0_6_6_0 will make the repo read/write-able for the owner and group, but
           inaccessible to others (equivalent to _g_r_o_u_p unless umask is e.g.  _0_0_2_2).  _0_6_4_0 is a repository that is
           group-readable but not group-writable. See ggiitt--iinniitt(1). False by default.

       core.warnAmbiguousRefs
           If true, Git will warn you if the ref name you passed it is ambiguous and might match multiple refs in the
           repository. True by default.

       core.compression
           An integer -1..9, indicating a default compression level. -1 is the zlib default. 0 means no compression,
           and 1..9 are various speed/size tradeoffs, 9 being slowest. If set, this provides a default to other
           compression variables, such as ccoorree..lloooosseeCCoommpprreessssiioonn and ppaacckk..ccoommpprreessssiioonn.

       core.looseCompression
           An integer -1..9, indicating the compression level for objects that are not in a pack file. -1 is the zlib
           default. 0 means no compression, and 1..9 are various speed/size tradeoffs, 9 being slowest. If not set,
           defaults to core.compression. If that is not set, defaults to 1 (best speed).

       core.packedGitWindowSize
           Number of bytes of a pack file to map into memory in a single mapping operation. Larger window sizes may
           allow your system to process a smaller number of large pack files more quickly. Smaller window sizes will
           negatively affect performance due to increased calls to the operating system’s memory manager, but may
           improve performance when accessing a large number of large pack files.

           Default is 1 MiB if NO_MMAP was set at compile time, otherwise 32 MiB on 32 bit platforms and 1 GiB on 64
           bit platforms. This should be reasonable for all users/operating systems. You probably do not need to adjust
           this value.

           Common unit suffixes of _k, _m, or _g are supported.

       core.packedGitLimit
           Maximum number of bytes to map simultaneously into memory from pack files. If Git needs to access more than
           this many bytes at once to complete an operation it will unmap existing regions to reclaim virtual address
           space within the process.

           Default is 256 MiB on 32 bit platforms and 32 TiB (effectively unlimited) on 64 bit platforms. This should
           be reasonable for all users/operating systems, except on the largest projects. You probably do not need to
           adjust this value.

           Common unit suffixes of _k, _m, or _g are supported.

       core.deltaBaseCacheLimit
           Maximum number of bytes to reserve for caching base objects that may be referenced by multiple deltified
           objects. By storing the entire decompressed base objects in a cache Git is able to avoid unpacking and
           decompressing frequently used base objects multiple times.

           Default is 96 MiB on all platforms. This should be reasonable for all users/operating systems, except on the
           largest projects. You probably do not need to adjust this value.

           Common unit suffixes of _k, _m, or _g are supported.

       core.bigFileThreshold
           Files larger than this size are stored deflated, without attempting delta compression. Storing large files
           without delta compression avoids excessive memory usage, at the slight expense of increased disk usage.
           Additionally files larger than this size are always treated as binary.

           Default is 512 MiB on all platforms. This should be reasonable for most projects as source code and other
           text files can still be delta compressed, but larger binary media files won’t be.

           Common unit suffixes of _k, _m, or _g are supported.

       core.excludesFile
           Specifies the pathname to the file that contains patterns to describe paths that are not meant to be
           tracked, in addition to ..ggiittiiggnnoorree (per-directory) and ..ggiitt//iinnffoo//eexxcclluuddee. Defaults to
           $$XXDDGG__CCOONNFFIIGG__HHOOMMEE//ggiitt//iiggnnoorree. If $$XXDDGG__CCOONNFFIIGG__HHOOMMEE is either not set or empty, $$HHOOMMEE//..ccoonnffiigg//ggiitt//iiggnnoorree is
           used instead. See ggiittiiggnnoorree(5).

       core.askPass
           Some commands (e.g. svn and http interfaces) that interactively ask for a password can be told to use an
           external program given via the value of this variable. Can be overridden by the GGIITT__AASSKKPPAASSSS environment
           variable. If not set, fall back to the value of the SSSSHH__AASSKKPPAASSSS environment variable or, failing that, a
           simple password prompt. The external program shall be given a suitable prompt as command-line argument and
           write the password on its STDOUT.

       core.attributesFile
           In addition to ..ggiittaattttrriibbuutteess (per-directory) and ..ggiitt//iinnffoo//aattttrriibbuutteess, Git looks into this file for
           attributes (see ggiittaattttrriibbuutteess(5)). Path expansions are made the same way as for ccoorree..eexxcclluuddeessFFiillee. Its
           default value is $$XXDDGG__CCOONNFFIIGG__HHOOMMEE//ggiitt//aattttrriibbuutteess. If $$XXDDGG__CCOONNFFIIGG__HHOOMMEE is either not set or empty,
           $$HHOOMMEE//..ccoonnffiigg//ggiitt//aattttrriibbuutteess is used instead.

       core.hooksPath
           By default Git will look for your hooks in the $$GGIITT__DDIIRR//hhooookkss directory. Set this to different path, e.g.
           //eettcc//ggiitt//hhooookkss, and Git will try to find your hooks in that directory, e.g.  //eettcc//ggiitt//hhooookkss//pprree--rreecceeiivvee
           instead of in $$GGIITT__DDIIRR//hhooookkss//pprree--rreecceeiivvee.

           The path can be either absolute or relative. A relative path is taken as relative to the directory where the
           hooks are run (see the "DESCRIPTION" section of ggiitthhooookkss(5)).

           This configuration variable is useful in cases where you’d like to centrally configure your Git hooks
           instead of configuring them on a per-repository basis, or as a more flexible and centralized alternative to
           having an iinniitt..tteemmppllaatteeDDiirr where you’ve changed default hooks.

       core.editor
           Commands such as ccoommmmiitt and ttaagg that let you edit messages by launching an editor use the value of this
           variable when it is set, and the environment variable GGIITT__EEDDIITTOORR is not set. See ggiitt--vvaarr(1).

       core.commentChar
           Commands such as ccoommmmiitt and ttaagg that let you edit messages consider a line that begins with this character
           commented, and removes them after the editor returns (default _#).

           If set to "auto", ggiitt--ccoommmmiitt would select a character that is not the beginning character of any line in
           existing commit messages.

       core.filesRefLockTimeout
           The length of time, in milliseconds, to retry when trying to lock an individual reference. Value 0 means not
           to retry at all; -1 means to try indefinitely. Default is 100 (i.e., retry for 100ms).

       core.packedRefsTimeout
           The length of time, in milliseconds, to retry when trying to lock the ppaacckkeedd--rreeffss file. Value 0 means not to
           retry at all; -1 means to try indefinitely. Default is 1000 (i.e., retry for 1 second).

       core.pager
           Text viewer for use by Git commands (e.g., _l_e_s_s). The value is meant to be interpreted by the shell. The
           order of preference is the $$GGIITT__PPAAGGEERR environment variable, then ccoorree..ppaaggeerr configuration, then $$PPAAGGEERR, and
           then the default chosen at compile time (usually _l_e_s_s).

           When the LLEESSSS environment variable is unset, Git sets it to FFRRXX (if LLEESSSS environment variable is set, Git
           does not change it at all). If you want to selectively override Git’s default setting for LLEESSSS, you can set
           ccoorree..ppaaggeerr to e.g.  lleessss --SS. This will be passed to the shell by Git, which will translate the final command
           to LLEESSSS==FFRRXX lleessss --SS. The environment does not set the SS option but the command line does, instructing less
           to truncate long lines. Similarly, setting ccoorree..ppaaggeerr to lleessss --++FF will deactivate the FF option specified by
           the environment from the command-line, deactivating the "quit if one screen" behavior of lleessss. One can
           specifically activate some flags for particular commands: for example, setting ppaaggeerr..bbllaammee to lleessss --SS
           enables line truncation only for ggiitt bbllaammee.

           Likewise, when the LLVV environment variable is unset, Git sets it to --cc. You can override this setting by
           exporting LLVV with another value or setting ccoorree..ppaaggeerr to llvv ++cc.

       core.whitespace
           A comma separated list of common whitespace problems to notice.  _g_i_t _d_i_f_f will use ccoolloorr..ddiiffff..wwhhiitteessppaaccee to
           highlight them, and _g_i_t _a_p_p_l_y _-_-_w_h_i_t_e_s_p_a_c_e_=_e_r_r_o_r will consider them as errors. You can prefix -- to disable
           any of them (e.g.  --ttrraaiilliinngg--ssppaaccee):

           •   bbllaannkk--aatt--eeooll treats trailing whitespaces at the end of the line as an error (enabled by default).

           •   ssppaaccee--bbeeffoorree--ttaabb treats a space character that appears immediately before a tab character in the initial
               indent part of the line as an error (enabled by default).

           •   iinnddeenntt--wwiitthh--nnoonn--ttaabb treats a line that is indented with space characters instead of the equivalent tabs
               as an error (not enabled by default).

           •   ttaabb--iinn--iinnddeenntt treats a tab character in the initial indent part of the line as an error (not enabled by
               default).

           •   bbllaannkk--aatt--eeooff treats blank lines added at the end of file as an error (enabled by default).

           •   ttrraaiilliinngg--ssppaaccee is a short-hand to cover both bbllaannkk--aatt--eeooll and bbllaannkk--aatt--eeooff.

           •   ccrr--aatt--eeooll treats a carriage-return at the end of line as part of the line terminator, i.e. with it,
               ttrraaiilliinngg--ssppaaccee does not trigger if the character before such a carriage-return is not a whitespace (not
               enabled by default).

           •   ttaabbwwiiddtthh==<<nn>> tells how many character positions a tab occupies; this is relevant for iinnddeenntt--wwiitthh--nnoonn--ttaabb
               and when Git fixes ttaabb--iinn--iinnddeenntt errors. The default tab width is 8. Allowed values are 1 to 63.

       core.fsyncObjectFiles
           This boolean will enable _f_s_y_n_c_(_) when writing object files.

           This is a total waste of time and effort on a filesystem that orders data writes properly, but can be useful
           for filesystems that do not use journalling (traditional UNIX filesystems) or that only journal metadata and
           not file contents (OS X’s HFS+, or Linux ext3 with "data=writeback").

       core.preloadIndex
           Enable parallel index preload for operations like _g_i_t _d_i_f_f

           This can speed up operations like _g_i_t _d_i_f_f and _g_i_t _s_t_a_t_u_s especially on filesystems like NFS that have weak
           caching semantics and thus relatively high IO latencies. When enabled, Git will do the index comparison to
           the filesystem data in parallel, allowing overlapping IO’s. Defaults to true.

       core.unsetenvvars
           Windows-only: comma-separated list of environment variables' names that need to be unset before spawning any
           other process. Defaults to PPEERRLL55LLIIBB to account for the fact that Git for Windows insists on using its own
           Perl interpreter.

       core.restrictinheritedhandles
           Windows-only: override whether spawned processes inherit only standard file handles (ssttddiinn, ssttddoouutt and
           ssttddeerrrr) or all handles. Can be aauuttoo, ttrruuee or ffaallssee. Defaults to aauuttoo, which means ttrruuee on Windows 7 and
           later, and ffaallssee on older Windows versions.

       core.createObject
           You can set this to _l_i_n_k, in which case a hardlink followed by a delete of the source are used to make sure
           that object creation will not overwrite existing objects.

           On some file system/operating system combinations, this is unreliable. Set this config setting to _r_e_n_a_m_e
           there; However, This will remove the check that makes sure that existing object files will not get
           overwritten.

       core.notesRef
           When showing commit messages, also show notes which are stored in the given ref. The ref must be fully
           qualified. If the given ref does not exist, it is not an error but means that no notes should be printed.

           This setting defaults to "refs/notes/commits", and it can be overridden by the GGIITT__NNOOTTEESS__RREEFF environment
           variable. See ggiitt--nnootteess(1).

       core.commitGraph
           If true, then git will read the commit-graph file (if it exists) to parse the graph structure of commits.
           Defaults to true. See ggiitt--ccoommmmiitt--ggrraapphh(1) for more information.

       core.useReplaceRefs
           If set to ffaallssee, behave as if the ----nnoo--rreeppllaaccee--oobbjjeeccttss option was given on the command line. See ggiitt(1) and
           ggiitt--rreeppllaaccee(1) for more information.

       core.multiPackIndex
           Use the multi-pack-index file to track multiple packfiles using a single index. See tthhee mmuullttii--ppaacckk--iinnddeexx
           ddeessiiggnn ddooccuummeenntt[1].

       core.sparseCheckout
           Enable "sparse checkout" feature. See ggiitt--ssppaarrssee--cchheecckkoouutt(1) for more information.

       core.sparseCheckoutCone
           Enables the "cone mode" of the sparse checkout feature. When the sparse-checkout file contains a limited set
           of patterns, then this mode provides significant performance advantages. See ggiitt--ssppaarrssee--cchheecckkoouutt(1) for more
           information.

       core.abbrev
           Set the length object names are abbreviated to. If unspecified or set to "auto", an appropriate value is
           computed based on the approximate number of packed objects in your repository, which hopefully is enough for
           abbreviated object names to stay unique for some time. The minimum length is 4.

       add.ignoreErrors, add.ignore-errors (deprecated)
           Tells _g_i_t _a_d_d to continue adding files when some files cannot be added due to indexing errors. Equivalent to
           the ----iiggnnoorree--eerrrroorrss option of ggiitt--aadddd(1).  aadddd..iiggnnoorree--eerrrroorrss is deprecated, as it does not follow the usual
           naming convention for configuration variables.

       add.interactive.useBuiltin
           [EXPERIMENTAL] Set to ttrruuee to use the experimental built-in implementation of the interactive version of
           ggiitt--aadddd(1) instead of the Perl script version. Is ffaallssee by default.

       alias.*
           Command aliases for the ggiitt(1) command wrapper - e.g. after defining aalliiaass..llaasstt == ccaatt--ffiillee ccoommmmiitt HHEEAADD, the
           invocation ggiitt llaasstt is equivalent to ggiitt ccaatt--ffiillee ccoommmmiitt HHEEAADD. To avoid confusion and troubles with script
           usage, aliases that hide existing Git commands are ignored. Arguments are split by spaces, the usual shell
           quoting and escaping is supported. A quote pair or a backslash can be used to quote them.

           Note that the first word of an alias does not necessarily have to be a command. It can be a command-line
           option that will be passed into the invocation of ggiitt. In particular, this is useful when used with --cc to
           pass in one-time configurations or --pp to force pagination. For example, lloouudd--rreebbaassee == --cc ccoommmmiitt..vveerrbboossee==ttrruuee
           rreebbaassee can be defined such that running ggiitt lloouudd--rreebbaassee would be equivalent to ggiitt --cc ccoommmmiitt..vveerrbboossee==ttrruuee
           rreebbaassee. Also, ppss == --pp ssttaattuuss would be a helpful alias since ggiitt ppss would paginate the output of ggiitt ssttaattuuss
           where the original command does not.

           If the alias expansion is prefixed with an exclamation point, it will be treated as a shell command. For
           example, defining aalliiaass..nneeww == !!ggiittkk ----aallll ----nnoott OORRIIGG__HHEEAADD, the invocation ggiitt nneeww is equivalent to running
           the shell command ggiittkk ----aallll ----nnoott OORRIIGG__HHEEAADD. Note that shell commands will be executed from the top-level
           directory of a repository, which may not necessarily be the current directory.  GGIITT__PPRREEFFIIXX is set as
           returned by running ggiitt rreevv--ppaarrssee ----sshhooww--pprreeffiixx from the original current directory. See ggiitt--rreevv--ppaarrssee(1).

       am.keepcr
           If true, git-am will call git-mailsplit for patches in mbox format with parameter ----kkeeeepp--ccrr. In this case
           git-mailsplit will not remove \\rr from lines ending with \\rr\\nn. Can be overridden by giving ----nnoo--kkeeeepp--ccrr from
           the command line. See ggiitt--aamm(1), ggiitt--mmaaiillsspplliitt(1).

       am.threeWay
           By default, ggiitt aamm will fail if the patch does not apply cleanly. When set to true, this setting tells ggiitt
           aamm to fall back on 3-way merge if the patch records the identity of blobs it is supposed to apply to and we
           have those blobs available locally (equivalent to giving the ----33wwaayy option from the command line). Defaults
           to ffaallssee. See ggiitt--aamm(1).

       apply.ignoreWhitespace
           When set to _c_h_a_n_g_e, tells _g_i_t _a_p_p_l_y to ignore changes in whitespace, in the same way as the
           ----iiggnnoorree--ssppaaccee--cchhaannggee option. When set to one of: no, none, never, false tells _g_i_t _a_p_p_l_y to respect all
           whitespace differences. See ggiitt--aappppllyy(1).

       apply.whitespace
           Tells _g_i_t _a_p_p_l_y how to handle whitespaces, in the same way as the ----wwhhiitteessppaaccee option. See ggiitt--aappppllyy(1).

       blame.blankBoundary
           Show blank commit object name for boundary commits in ggiitt--bbllaammee(1). This option defaults to false.

       blame.coloring
           This determines the coloring scheme to be applied to blame output. It can be _r_e_p_e_a_t_e_d_L_i_n_e_s, _h_i_g_h_l_i_g_h_t_R_e_c_e_n_t,
           or _n_o_n_e which is the default.

       blame.date
           Specifies the format used to output dates in ggiitt--bbllaammee(1). If unset the iso format is used. For supported
           values, see the discussion of the ----ddaattee option at ggiitt--lloogg(1).

       blame.showEmail
           Show the author email instead of author name in ggiitt--bbllaammee(1). This option defaults to false.

       blame.showRoot
           Do not treat root commits as boundaries in ggiitt--bbllaammee(1). This option defaults to false.

       blame.ignoreRevsFile
           Ignore revisions listed in the file, one unabbreviated object name per line, in ggiitt--bbllaammee(1). Whitespace and
           comments beginning with ## are ignored. This option may be repeated multiple times. Empty file names will
           reset the list of ignored revisions. This option will be handled before the command line option
           ----iiggnnoorree--rreevvss--ffiillee.

       blame.markUnblamables
           Mark lines that were changed by an ignored revision that we could not attribute to another commit with a _*
           in the output of ggiitt--bbllaammee(1).

       blame.markIgnoredLines
           Mark lines that were changed by an ignored revision that we attributed to another commit with a _?  in the
           output of ggiitt--bbllaammee(1).

       branch.autoSetupMerge
           Tells _g_i_t _b_r_a_n_c_h, _g_i_t _s_w_i_t_c_h and _g_i_t _c_h_e_c_k_o_u_t to set up new branches so that ggiitt--ppuullll(1) will appropriately
           merge from the starting point branch. Note that even if this option is not set, this behavior can be chosen
           per-branch using the ----ttrraacckk and ----nnoo--ttrraacckk options. The valid settings are: ffaallssee — no automatic setup is
           done; ttrruuee — automatic setup is done when the starting point is a remote-tracking branch; aallwwaayyss —
           automatic setup is done when the starting point is either a local branch or remote-tracking branch. This
           option defaults to true.

       branch.autoSetupRebase
           When a new branch is created with _g_i_t _b_r_a_n_c_h, _g_i_t _s_w_i_t_c_h or _g_i_t _c_h_e_c_k_o_u_t that tracks another branch, this
           variable tells Git to set up pull to rebase instead of merge (see "branch.<name>.rebase"). When nneevveerr,
           rebase is never automatically set to true. When llooccaall, rebase is set to true for tracked branches of other
           local branches. When rreemmoottee, rebase is set to true for tracked branches of remote-tracking branches. When
           aallwwaayyss, rebase will be set to true for all tracking branches. See "branch.autoSetupMerge" for details on how
           to set up a branch to track another branch. This option defaults to never.

       branch.sort
           This variable controls the sort ordering of branches when displayed by ggiitt--bbrraanncchh(1). Without the
           "--sort=<value>" option provided, the value of this variable will be used as the default. See ggiitt--ffoorr--eeaacchh--
           rreeff(1) field names for valid values.

       branch.<name>.remote
           When on branch <name>, it tells _g_i_t _f_e_t_c_h and _g_i_t _p_u_s_h which remote to fetch from/push to. The remote to
           push to may be overridden with rreemmoottee..ppuusshhDDeeffaauulltt (for all branches). The remote to push to, for the current
           branch, may be further overridden by bbrraanncchh..<<nnaammee>>..ppuusshhRReemmoottee. If no remote is configured, or if you are not
           on any branch, it defaults to oorriiggiinn for fetching and rreemmoottee..ppuusshhDDeeffaauulltt for pushing. Additionally, ..  (a
           period) is the current local repository (a dot-repository), see bbrraanncchh..<<nnaammee>>..mmeerrggee's final note below.

       branch.<name>.pushRemote
           When on branch <name>, it overrides bbrraanncchh..<<nnaammee>>..rreemmoottee for pushing. It also overrides rreemmoottee..ppuusshhDDeeffaauulltt
           for pushing from branch <name>. When you pull from one place (e.g. your upstream) and push to another place
           (e.g. your own publishing repository), you would want to set rreemmoottee..ppuusshhDDeeffaauulltt to specify the remote to
           push to for all branches, and use this option to override it for a specific branch.

       branch.<name>.merge
           Defines, together with branch.<name>.remote, the upstream branch for the given branch. It tells _g_i_t
           _f_e_t_c_h/_g_i_t _p_u_l_l/_g_i_t _r_e_b_a_s_e which branch to merge and can also affect _g_i_t _p_u_s_h (see push.default). When in
           branch <name>, it tells _g_i_t _f_e_t_c_h the default refspec to be marked for merging in FETCH_HEAD. The value is
           handled like the remote part of a refspec, and must match a ref which is fetched from the remote given by
           "branch.<name>.remote". The merge information is used by _g_i_t _p_u_l_l (which at first calls _g_i_t _f_e_t_c_h) to lookup
           the default branch for merging. Without this option, _g_i_t _p_u_l_l defaults to merge the first refspec fetched.
           Specify multiple values to get an octopus merge. If you wish to setup _g_i_t _p_u_l_l so that it merges into <name>
           from another branch in the local repository, you can point branch.<name>.merge to the desired branch, and
           use the relative path setting ..  (a period) for branch.<name>.remote.

       branch.<name>.mergeOptions
           Sets default options for merging into branch <name>. The syntax and supported options are the same as those
           of ggiitt--mmeerrggee(1), but option values containing whitespace characters are currently not supported.

       branch.<name>.rebase
           When true, rebase the branch <name> on top of the fetched branch, instead of merging the default branch from
           the default remote when "git pull" is run. See "pull.rebase" for doing this in a non branch-specific manner.

           When mmeerrggeess, pass the ----rreebbaassee--mmeerrggeess option to _g_i_t _r_e_b_a_s_e so that the local merge commits are included in
           the rebase (see ggiitt--rreebbaassee(1) for details).

           When pprreesseerrvvee (deprecated in favor of mmeerrggeess), also pass ----pprreesseerrvvee--mmeerrggeess along to _g_i_t _r_e_b_a_s_e so that
           locally committed merge commits will not be flattened by running _g_i_t _p_u_l_l.

           When the value is iinntteerraaccttiivvee, the rebase is run in interactive mode.

           NNOOTTEE: this is a possibly dangerous operation; do nnoott use it unless you understand the implications (see ggiitt--
           rreebbaassee(1) for details).

       branch.<name>.description
           Branch description, can be edited with ggiitt bbrraanncchh ----eeddiitt--ddeessccrriippttiioonn. Branch description is automatically
           added in the format-patch cover letter or request-pull summary.

       browser.<tool>.cmd
           Specify the command to invoke the specified browser. The specified command is evaluated in shell with the
           URLs passed as arguments. (See ggiitt--wweebb----bbrroowwssee(1).)

       browser.<tool>.path
           Override the path for the given tool that may be used to browse HTML help (see --ww option in ggiitt--hheellpp(1)) or
           a working repository in gitweb (see ggiitt--iinnssttaawweebb(1)).

       checkout.defaultRemote
           When you run _g_i_t _c_h_e_c_k_o_u_t _<_s_o_m_e_t_h_i_n_g_> or _g_i_t _s_w_i_t_c_h _<_s_o_m_e_t_h_i_n_g_> and only have one remote, it may implicitly
           fall back on checking out and tracking e.g.  _o_r_i_g_i_n_/_<_s_o_m_e_t_h_i_n_g_>. This stops working as soon as you have more
           than one remote with a _<_s_o_m_e_t_h_i_n_g_> reference. This setting allows for setting the name of a preferred remote
           that should always win when it comes to disambiguation. The typical use-case is to set this to oorriiggiinn.

           Currently this is used by ggiitt--sswwiittcchh(1) and ggiitt--cchheecckkoouutt(1) when _g_i_t _c_h_e_c_k_o_u_t _<_s_o_m_e_t_h_i_n_g_> or _g_i_t _s_w_i_t_c_h
           _<_s_o_m_e_t_h_i_n_g_> will checkout the _<_s_o_m_e_t_h_i_n_g_> branch on another remote, and by ggiitt--wwoorrkkttrreeee(1) when _g_i_t _w_o_r_k_t_r_e_e
           _a_d_d refers to a remote branch. This setting might be used for other checkout-like commands or functionality
           in the future.

       clean.requireForce
           A boolean to make git-clean do nothing unless given -f, -i or -n. Defaults to true.

       color.advice
           A boolean to enable/disable color in hints (e.g. when a push failed, see aaddvviiccee..**  for a list). May be set
           to aallwwaayyss, ffaallssee (or nneevveerr) or aauuttoo (or ttrruuee), in which case colors are used only when the error output goes
           to a terminal. If unset, then the value of ccoolloorr..uuii is used (aauuttoo by default).

       color.advice.hint
           Use customized color for hints.

       color.blame.highlightRecent
           This can be used to color the metadata of a blame line depending on age of the line.

           This setting should be set to a comma-separated list of color and date settings, starting and ending with a
           color, the dates should be set from oldest to newest. The metadata will be colored given the colors if the
           line was introduced before the given timestamp, overwriting older timestamped colors.

           Instead of an absolute timestamp relative timestamps work as well, e.g. 2.weeks.ago is valid to address
           anything older than 2 weeks.

           It defaults to _b_l_u_e_,_1_2 _m_o_n_t_h _a_g_o_,_w_h_i_t_e_,_1 _m_o_n_t_h _a_g_o_,_r_e_d, which colors everything older than one year blue,
           recent changes between one month and one year old are kept white, and lines introduced within the last month
           are colored red.

       color.blame.repeatedLines
           Use the customized color for the part of git-blame output that is repeated meta information per line (such
           as commit id, author name, date and timezone). Defaults to cyan.

       color.branch
           A boolean to enable/disable color in the output of ggiitt--bbrraanncchh(1). May be set to aallwwaayyss, ffaallssee (or nneevveerr) or
           aauuttoo (or ttrruuee), in which case colors are used only when the output is to a terminal. If unset, then the
           value of ccoolloorr..uuii is used (aauuttoo by default).

       color.branch.<slot>
           Use customized color for branch coloration.  <<sslloott>> is one of ccuurrrreenntt (the current branch), llooccaall (a local
           branch), rreemmoottee (a remote-tracking branch in refs/remotes/), uuppssttrreeaamm (upstream tracking branch), ppllaaiinn
           (other refs).

       color.diff
           Whether to use ANSI escape sequences to add color to patches. If this is set to aallwwaayyss, ggiitt--ddiiffff(1), ggiitt--
           lloogg(1), and ggiitt--sshhooww(1) will use color for all patches. If it is set to ttrruuee or aauuttoo, those commands will
           only use color when output is to the terminal. If unset, then the value of ccoolloorr..uuii is used (aauuttoo by
           default).

           This does not affect ggiitt--ffoorrmmaatt--ppaattcchh(1) or the _g_i_t_-_d_i_f_f_-_* plumbing commands. Can be overridden on the
           command line with the ----ccoolloorr[[==<<wwhheenn>>]] option.

       color.diff.<slot>
           Use customized color for diff colorization.  <<sslloott>> specifies which part of the patch to use the specified
           color, and is one of ccoonntteexxtt (context text - ppllaaiinn is a historical synonym), mmeettaa (metainformation), ffrraagg
           (hunk header), _f_u_n_c (function in hunk header), oolldd (removed lines), nneeww (added lines), ccoommmmiitt (commit
           headers), wwhhiitteessppaaccee (highlighting whitespace errors), oollddMMoovveedd (deleted lines), nneewwMMoovveedd (added lines),
           oollddMMoovveeddDDiimmmmeedd, oollddMMoovveeddAAlltteerrnnaattiivvee, oollddMMoovveeddAAlltteerrnnaattiivveeDDiimmmmeedd, nneewwMMoovveeddDDiimmmmeedd, nneewwMMoovveeddAAlltteerrnnaattiivvee
           nneewwMMoovveeddAAlltteerrnnaattiivveeDDiimmmmeedd (See the _<_m_o_d_e_> setting of _-_-_c_o_l_o_r_-_m_o_v_e_d in ggiitt--ddiiffff(1) for details),
           ccoonntteexxttDDiimmmmeedd, oollddDDiimmmmeedd, nneewwDDiimmmmeedd, ccoonntteexxttBBoolldd, oollddBBoolldd, and nneewwBBoolldd (see ggiitt--rraannggee--ddiiffff(1) for details).

       color.decorate.<slot>
           Use customized color for _g_i_t _l_o_g _-_-_d_e_c_o_r_a_t_e output.  <<sslloott>> is one of bbrraanncchh, rreemmootteeBBrraanncchh, ttaagg, ssttaasshh or
           HHEEAADD for local branches, remote-tracking branches, tags, stash and HEAD, respectively and ggrraafftteedd for
           grafted commits.

       color.grep
           When set to aallwwaayyss, always highlight matches. When ffaallssee (or nneevveerr), never. When set to ttrruuee or aauuttoo, use
           color only when the output is written to the terminal. If unset, then the value of ccoolloorr..uuii is used (aauuttoo by
           default).

       color.grep.<slot>
           Use customized color for grep colorization.  <<sslloott>> specifies which part of the line to use the specified
           color, and is one of

           ccoonntteexxtt
               non-matching text in context lines (when using --AA, --BB, or --CC)

           ffiilleennaammee
               filename prefix (when not using --hh)

           ffuunnccttiioonn
               function name lines (when using --pp)

           lliinneeNNuummbbeerr
               line number prefix (when using --nn)

           ccoolluummnn
               column number prefix (when using ----ccoolluummnn)

           mmaattcchh
               matching text (same as setting mmaattcchhCCoonntteexxtt and mmaattcchhSSeelleecctteedd)

           mmaattcchhCCoonntteexxtt
               matching text in context lines

           mmaattcchhSSeelleecctteedd
               matching text in selected lines

           sseelleecctteedd
               non-matching text in selected lines

           sseeppaarraattoorr
               separators between fields on a line (::, --, and ==) and between hunks (----)

       color.interactive
           When set to aallwwaayyss, always use colors for interactive prompts and displays (such as those used by "git-add
           --interactive" and "git-clean --interactive"). When false (or nneevveerr), never. When set to ttrruuee or aauuttoo, use
           colors only when the output is to the terminal. If unset, then the value of ccoolloorr..uuii is used (aauuttoo by
           default).

       color.interactive.<slot>
           Use customized color for _g_i_t _a_d_d _-_-_i_n_t_e_r_a_c_t_i_v_e and _g_i_t _c_l_e_a_n _-_-_i_n_t_e_r_a_c_t_i_v_e output.  <<sslloott>> may be pprroommpptt,
           hheeaaddeerr, hheellpp or eerrrroorr, for four distinct types of normal output from interactive commands.

       color.pager
           A boolean to enable/disable colored output when the pager is in use (default is true).

       color.push
           A boolean to enable/disable color in push errors. May be set to aallwwaayyss, ffaallssee (or nneevveerr) or aauuttoo (or ttrruuee),
           in which case colors are used only when the error output goes to a terminal. If unset, then the value of
           ccoolloorr..uuii is used (aauuttoo by default).

       color.push.error
           Use customized color for push errors.

       color.remote
           If set, keywords at the start of the line are highlighted. The keywords are "error", "warning", "hint" and
           "success", and are matched case-insensitively. May be set to aallwwaayyss, ffaallssee (or nneevveerr) or aauuttoo (or ttrruuee). If
           unset, then the value of ccoolloorr..uuii is used (aauuttoo by default).

       color.remote.<slot>
           Use customized color for each remote keyword.  <<sslloott>> may be hhiinntt, wwaarrnniinngg, ssuucccceessss or eerrrroorr which match the
           corresponding keyword.

       color.showBranch
           A boolean to enable/disable color in the output of ggiitt--sshhooww--bbrraanncchh(1). May be set to aallwwaayyss, ffaallssee (or
           nneevveerr) or aauuttoo (or ttrruuee), in which case colors are used only when the output is to a terminal. If unset,
           then the value of ccoolloorr..uuii is used (aauuttoo by default).

       color.status
           A boolean to enable/disable color in the output of ggiitt--ssttaattuuss(1). May be set to aallwwaayyss, ffaallssee (or nneevveerr) or
           aauuttoo (or ttrruuee), in which case colors are used only when the output is to a terminal. If unset, then the
           value of ccoolloorr..uuii is used (aauuttoo by default).

       color.status.<slot>
           Use customized color for status colorization.  <<sslloott>> is one of hheeaaddeerr (the header text of the status
           message), aaddddeedd or uuppddaatteedd (files which are added but not committed), cchhaannggeedd (files which are changed but
           not added in the index), uunnttrraacckkeedd (files which are not tracked by Git), bbrraanncchh (the current branch),
           nnoobbrraanncchh (the color the _n_o _b_r_a_n_c_h warning is shown in, defaulting to red), llooccaallBBrraanncchh or rreemmootteeBBrraanncchh (the
           local and remote branch names, respectively, when branch and tracking information is displayed in the status
           short-format), or uunnmmeerrggeedd (files which have unmerged changes).

       color.transport
           A boolean to enable/disable color when pushes are rejected. May be set to aallwwaayyss, ffaallssee (or nneevveerr) or aauuttoo
           (or ttrruuee), in which case colors are used only when the error output goes to a terminal. If unset, then the
           value of ccoolloorr..uuii is used (aauuttoo by default).

       color.transport.rejected
           Use customized color when a push was rejected.

       color.ui
           This variable determines the default value for variables such as ccoolloorr..ddiiffff and ccoolloorr..ggrreepp that control the
           use of color per command family. Its scope will expand as more commands learn configuration to set a default
           for the ----ccoolloorr option. Set it to ffaallssee or nneevveerr if you prefer Git commands not to use color unless enabled
           explicitly with some other configuration or the ----ccoolloorr option. Set it to aallwwaayyss if you want all output not
           intended for machine consumption to use color, to ttrruuee or aauuttoo (this is the default since Git 1.8.4) if you
           want such output to use color when written to the terminal.

       column.ui
           Specify whether supported commands should output in columns. This variable consists of a list of tokens
           separated by spaces or commas:

           These options control when the feature should be enabled (defaults to _n_e_v_e_r):

           aallwwaayyss
               always show in columns

           nneevveerr
               never show in columns

           aauuttoo
               show in columns if the output is to the terminal

           These options control layout (defaults to _c_o_l_u_m_n). Setting any of these implies _a_l_w_a_y_s if none of _a_l_w_a_y_s,
           _n_e_v_e_r, or _a_u_t_o are specified.

           ccoolluummnn
               fill columns before rows

           rrooww
               fill rows before columns

           ppllaaiinn
               show in one column

           Finally, these options can be combined with a layout option (defaults to _n_o_d_e_n_s_e):

           ddeennssee
               make unequal size columns to utilize more space

           nnooddeennssee
               make equal size columns

       column.branch
           Specify whether to output branch listing in ggiitt bbrraanncchh in columns. See ccoolluummnn..uuii for details.

       column.clean
           Specify the layout when list items in ggiitt cclleeaann --ii, which always shows files and directories in columns. See
           ccoolluummnn..uuii for details.

       column.status
           Specify whether to output untracked files in ggiitt ssttaattuuss in columns. See ccoolluummnn..uuii for details.

       column.tag
           Specify whether to output tag listing in ggiitt ttaagg in columns. See ccoolluummnn..uuii for details.

       commit.cleanup
           This setting overrides the default of the ----cclleeaannuupp option in ggiitt ccoommmmiitt. See ggiitt--ccoommmmiitt(1) for details.
           Changing the default can be useful when you always want to keep lines that begin with comment character ## in
           your log message, in which case you would do ggiitt ccoonnffiigg ccoommmmiitt..cclleeaannuupp wwhhiitteessppaaccee (note that you will have
           to remove the help lines that begin with ## in the commit log template yourself, if you do this).

       commit.gpgSign
           A boolean to specify whether all commits should be GPG signed. Use of this option when doing operations such
           as rebase can result in a large number of commits being signed. It may be convenient to use an agent to
           avoid typing your GPG passphrase several times.

       commit.status
           A boolean to enable/disable inclusion of status information in the commit message template when using an
           editor to prepare the commit message. Defaults to true.

       commit.template
           Specify the pathname of a file to use as the template for new commit messages.

       commit.verbose
           A boolean or int to specify the level of verbose with ggiitt ccoommmmiitt. See ggiitt--ccoommmmiitt(1).

       credential.helper
           Specify an external helper to be called when a username or password credential is needed; the helper may
           consult external storage to avoid prompting the user for the credentials. Note that multiple helpers may be
           defined. See ggiittccrreeddeennttiiaallss(7) for details.

       credential.useHttpPath
           When acquiring credentials, consider the "path" component of an http or https URL to be important. Defaults
           to false. See ggiittccrreeddeennttiiaallss(7) for more information.

       credential.username
           If no username is set for a network authentication, use this username by default. See credential.<context>.*
           below, and ggiittccrreeddeennttiiaallss(7).

       credential.<url>.*
           Any of the credential.* options above can be applied selectively to some credentials. For example
           "credential.https://example.com.username" would set the default username only for https connections to
           example.com. See ggiittccrreeddeennttiiaallss(7) for details on how URLs are matched.

       credentialCache.ignoreSIGHUP
           Tell git-credential-cache—daemon to ignore SIGHUP, instead of quitting.

       completion.commands
           This is only used by git-completion.bash to add or remove commands from the list of completed commands.
           Normally only porcelain commands and a few select others are completed. You can add more commands, separated
           by space, in this variable. Prefixing the command with _- will remove it from the existing list.

       diff.autoRefreshIndex
           When using _g_i_t _d_i_f_f to compare with work tree files, do not consider stat-only change as changed. Instead,
           silently run ggiitt uuppddaattee--iinnddeexx ----rreeffrreesshh to update the cached stat information for paths whose contents in
           the work tree match the contents in the index. This option defaults to true. Note that this affects only _g_i_t
           _d_i_f_f Porcelain, and not lower level _d_i_f_f commands such as _g_i_t _d_i_f_f_-_f_i_l_e_s.

       diff.dirstat
           A comma separated list of ----ddiirrssttaatt parameters specifying the default behavior of the ----ddiirrssttaatt option to
           ggiitt--ddiiffff(1) and friends. The defaults can be overridden on the command line (using
           ----ddiirrssttaatt==<<ppaarraamm11,,ppaarraamm22,,......>>). The fallback defaults (when not changed by ddiiffff..ddiirrssttaatt) are
           cchhaannggeess,,nnoonnccuummuullaattiivvee,,33. The following parameters are available:

           cchhaannggeess
               Compute the dirstat numbers by counting the lines that have been removed from the source, or added to
               the destination. This ignores the amount of pure code movements within a file. In other words,
               rearranging lines in a file is not counted as much as other changes. This is the default behavior when
               no parameter is given.

           lliinneess
               Compute the dirstat numbers by doing the regular line-based diff analysis, and summing the removed/added
               line counts. (For binary files, count 64-byte chunks instead, since binary files have no natural concept
               of lines). This is a more expensive ----ddiirrssttaatt behavior than the cchhaannggeess behavior, but it does count
               rearranged lines within a file as much as other changes. The resulting output is consistent with what
               you get from the other ----**ssttaatt options.

           ffiilleess
               Compute the dirstat numbers by counting the number of files changed. Each changed file counts equally in
               the dirstat analysis. This is the computationally cheapest ----ddiirrssttaatt behavior, since it does not have to
               look at the file contents at all.

           ccuummuullaattiivvee
               Count changes in a child directory for the parent directory as well. Note that when using ccuummuullaattiivvee,
               the sum of the percentages reported may exceed 100%. The default (non-cumulative) behavior can be
               specified with the nnoonnccuummuullaattiivvee parameter.

           <limit>
               An integer parameter specifies a cut-off percent (3% by default). Directories contributing less than
               this percentage of the changes are not shown in the output.

           Example: The following will count changed files, while ignoring directories with less than 10% of the total
           amount of changed files, and accumulating child directory counts in the parent directories:
           ffiilleess,,1100,,ccuummuullaattiivvee.

       diff.statGraphWidth
           Limit the width of the graph part in --stat output. If set, applies to all commands generating --stat output
           except format-patch.

       diff.context
           Generate diffs with <n> lines of context instead of the default of 3. This value is overridden by the -U
           option.

       diff.interHunkContext
           Show the context between diff hunks, up to the specified number of lines, thereby fusing the hunks that are
           close to each other. This value serves as the default for the ----iinntteerr--hhuunnkk--ccoonntteexxtt command line option.

       diff.external
           If this config variable is set, diff generation is not performed using the internal diff machinery, but
           using the given command. Can be overridden with the ‘GIT_EXTERNAL_DIFF’ environment variable. The command is
           called with parameters as described under "git Diffs" in ggiitt(1). Note: if you want to use an external diff
           program only on a subset of your files, you might want to use ggiittaattttrriibbuutteess(5) instead.

       diff.ignoreSubmodules
           Sets the default value of --ignore-submodules. Note that this affects only _g_i_t _d_i_f_f Porcelain, and not lower
           level _d_i_f_f commands such as _g_i_t _d_i_f_f_-_f_i_l_e_s.  _g_i_t _c_h_e_c_k_o_u_t and _g_i_t _s_w_i_t_c_h also honor this setting when
           reporting uncommitted changes. Setting it to _a_l_l disables the submodule summary normally shown by _g_i_t _c_o_m_m_i_t
           and _g_i_t _s_t_a_t_u_s when ssttaattuuss..ssuubbmmoodduulleeSSuummmmaarryy is set unless it is overridden by using the --ignore-submodules
           command-line option. The _g_i_t _s_u_b_m_o_d_u_l_e commands are not affected by this setting.

       diff.mnemonicPrefix
           If set, _g_i_t _d_i_f_f uses a prefix pair that is different from the standard "a/" and "b/" depending on what is
           being compared. When this configuration is in effect, reverse diff output also swaps the order of the
           prefixes:

           ggiitt ddiiffff
               compares the (i)ndex and the (w)ork tree;

           ggiitt ddiiffff HHEEAADD
               compares a (c)ommit and the (w)ork tree;

           ggiitt ddiiffff ----ccaacchheedd
               compares a (c)ommit and the (i)ndex;

           ggiitt ddiiffff HHEEAADD::ffiillee11 ffiillee22
               compares an (o)bject and a (w)ork tree entity;

           ggiitt ddiiffff ----nnoo--iinnddeexx aa bb
               compares two non-git things (1) and (2).

       diff.noprefix
           If set, _g_i_t _d_i_f_f does not show any source or destination prefix.

       diff.orderFile
           File indicating how to order files within a diff. See the _-_O option to ggiitt--ddiiffff(1) for details. If
           ddiiffff..oorrddeerrFFiillee is a relative pathname, it is treated as relative to the top of the working tree.

       diff.renameLimit
           The number of files to consider when performing the copy/rename detection; equivalent to the _g_i_t _d_i_f_f option
           --ll. This setting has no effect if rename detection is turned off.

       diff.renames
           Whether and how Git detects renames. If set to "false", rename detection is disabled. If set to "true",
           basic rename detection is enabled. If set to "copies" or "copy", Git will detect copies, as well. Defaults
           to true. Note that this affects only _g_i_t _d_i_f_f Porcelain like ggiitt--ddiiffff(1) and ggiitt--lloogg(1), and not lower level
           commands such as ggiitt--ddiiffff--ffiilleess(1).

       diff.suppressBlankEmpty
           A boolean to inhibit the standard behavior of printing a space before each empty output line. Defaults to
           false.

       diff.submodule
           Specify the format in which differences in submodules are shown. The "short" format just shows the names of
           the commits at the beginning and end of the range. The "log" format lists the commits in the range like ggiitt--
           ssuubbmmoodduullee(1) ssuummmmaarryy does. The "diff" format shows an inline diff of the changed contents of the submodule.
           Defaults to "short".

       diff.wordRegex
           A POSIX Extended Regular Expression used to determine what is a "word" when performing word-by-word
           difference calculations. Character sequences that match the regular expression are "words", all other
           characters are iiggnnoorraabbllee whitespace.

       diff.<driver>.command
           The custom diff driver command. See ggiittaattttrriibbuutteess(5) for details.

       diff.<driver>.xfuncname
           The regular expression that the diff driver should use to recognize the hunk header. A built-in pattern may
           also be used. See ggiittaattttrriibbuutteess(5) for details.

       diff.<driver>.binary
           Set this option to true to make the diff driver treat files as binary. See ggiittaattttrriibbuutteess(5) for details.

       diff.<driver>.textconv
           The command that the diff driver should call to generate the text-converted version of a file. The result of
           the conversion is used to generate a human-readable diff. See ggiittaattttrriibbuutteess(5) for details.

       diff.<driver>.wordRegex
           The regular expression that the diff driver should use to split words in a line. See ggiittaattttrriibbuutteess(5) for
           details.

       diff.<driver>.cachetextconv
           Set this option to true to make the diff driver cache the text conversion outputs. See ggiittaattttrriibbuutteess(5) for
           details.

       diff.tool
           Controls which diff tool is used by ggiitt--ddiiffffttooooll(1). This variable overrides the value configured in
           mmeerrggee..ttooooll. The list below shows the valid built-in values. Any other value is treated as a custom diff tool
           and requires that a corresponding difftool.<tool>.cmd variable is defined.

       diff.guitool
           Controls which diff tool is used by ggiitt--ddiiffffttooooll(1) when the -g/--gui flag is specified. This variable
           overrides the value configured in mmeerrggee..gguuiittooooll. The list below shows the valid built-in values. Any other
           value is treated as a custom diff tool and requires that a corresponding difftool.<guitool>.cmd variable is
           defined.

           •   araxis

           •   bc

           •   bc3

           •   codecompare

           •   deltawalker

           •   diffmerge

           •   diffuse

           •   ecmerge

           •   emerge

           •   examdiff

           •   guiffy

           •   gvimdiff

           •   gvimdiff2

           •   gvimdiff3

           •   kdiff3

           •   kompare

           •   meld

           •   opendiff

           •   p4merge

           •   smerge

           •   tkdiff

           •   vimdiff

           •   vimdiff2

           •   vimdiff3

           •   winmerge

           •   xxdiff

       diff.indentHeuristic
           Set this option to ffaallssee to disable the default heuristics that shift diff hunk boundaries to make patches
           easier to read.

       diff.algorithm
           Choose a diff algorithm. The variants are as follows:

           ddeeffaauulltt, mmyyeerrss
               The basic greedy diff algorithm. Currently, this is the default.

           mmiinniimmaall
               Spend extra time to make sure the smallest possible diff is produced.

           ppaattiieennccee
               Use "patience diff" algorithm when generating patches.

           hhiissttooggrraamm
               This algorithm extends the patience algorithm to "support low-occurrence common elements".

       diff.wsErrorHighlight
           Highlight whitespace errors in the ccoonntteexxtt, oolldd or nneeww lines of the diff. Multiple values are separated by
           comma, nnoonnee resets previous values, ddeeffaauulltt reset the list to nneeww and aallll is a shorthand for
           oolldd,,nneeww,,ccoonntteexxtt. The whitespace errors are colored with ccoolloorr..ddiiffff..wwhhiitteessppaaccee. The command line option
           ----wwss--eerrrroorr--hhiigghhlliigghhtt==<<kkiinndd>> overrides this setting.

       diff.colorMoved
           If set to either a valid <<mmooddee>> or a true value, moved lines in a diff are colored differently, for details
           of valid modes see _-_-_c_o_l_o_r_-_m_o_v_e_d in ggiitt--ddiiffff(1). If simply set to true the default color mode will be used.
           When set to false, moved lines are not colored.

       diff.colorMovedWS
           When moved lines are colored using e.g. the ddiiffff..ccoolloorrMMoovveedd setting, this option controls the <<mmooddee>> how
           spaces are treated for details of valid modes see _-_-_c_o_l_o_r_-_m_o_v_e_d_-_w_s in ggiitt--ddiiffff(1).

       difftool.<tool>.path
           Override the path for the given tool. This is useful in case your tool is not in the PATH.

       difftool.<tool>.cmd
           Specify the command to invoke the specified diff tool. The specified command is evaluated in shell with the
           following variables available: _L_O_C_A_L is set to the name of the temporary file containing the contents of the
           diff pre-image and _R_E_M_O_T_E is set to the name of the temporary file containing the contents of the diff
           post-image.

       difftool.prompt
           Prompt before each invocation of the diff tool.

       fastimport.unpackLimit
           If the number of objects imported by ggiitt--ffaasstt--iimmppoorrtt(1) is below this limit, then the objects will be
           unpacked into loose object files. However if the number of imported objects equals or exceeds this limit
           then the pack will be stored as a pack. Storing the pack from a fast-import can make the import operation
           complete faster, especially on slow filesystems. If not set, the value of ttrraannssffeerr..uunnppaacckkLLiimmiitt is used
           instead.

       feature.*
           The config settings that start with ffeeaattuurree..  modify the defaults of a group of other config settings. These
           groups are created by the Git developer community as recommended defaults and are subject to change. In
           particular, new config options may be added with different defaults.

       feature.experimental
           Enable config options that are new to Git, and are being considered for future defaults. Config settings
           included here may be added or removed with each release, including minor version updates. These settings may
           have unintended interactions since they are so new. Please enable this setting if you are interested in
           providing feedback on experimental features. The new default values are:

           •   ppaacckk..uusseeSSppaarrssee==ttrruuee uses a new algorithm when constructing a pack-file which can improve ggiitt ppuusshh
               performance in repos with many files.

           •   ffeettcchh..nneeggoottiiaattiioonnAAllggoorriitthhmm==sskkiippppiinngg may improve fetch negotiation times by skipping more commits at a
               time, reducing the number of round trips.

           •   ffeettcchh..wwrriitteeCCoommmmiittGGrraapphh==ttrruuee writes a commit-graph after every ggiitt ffeettcchh command that downloads a
               pack-file from a remote. Using the ----sspplliitt option, most executions will create a very small commit-graph
               file on top of the existing commit-graph file(s). Occasionally, these files will merge and the write may
               take longer. Having an updated commit-graph file helps performance of many Git commands, including ggiitt
               mmeerrggee--bbaassee, ggiitt ppuusshh --ff, and ggiitt lloogg ----ggrraapphh.

       feature.manyFiles
           Enable config options that optimize for repos with many files in the working directory. With many files,
           commands such as ggiitt ssttaattuuss and ggiitt cchheecckkoouutt may be slow and these new defaults improve performance:

           •   iinnddeexx..vveerrssiioonn==44 enables path-prefix compression in the index.

           •   ccoorree..uunnttrraacckkeeddCCaacchhee==ttrruuee enables the untracked cache. This setting assumes that mtime is working on your
               machine.

       fetch.recurseSubmodules
           This option can be either set to a boolean value or to _o_n_-_d_e_m_a_n_d. Setting it to a boolean changes the
           behavior of fetch and pull to unconditionally recurse into submodules when set to true or to not recurse at
           all when set to false. When set to _o_n_-_d_e_m_a_n_d (the default value), fetch and pull will only recurse into a
           populated submodule when its superproject retrieves a commit that updates the submodule’s reference.

       fetch.fsckObjects
           If it is set to true, git-fetch-pack will check all fetched objects. See ttrraannssffeerr..ffsscckkOObbjjeeccttss for what’s
           checked. Defaults to false. If not set, the value of ttrraannssffeerr..ffsscckkOObbjjeeccttss is used instead.

       fetch.fsck.<msg-id>
           Acts like ffsscckk..<<mmssgg--iidd>>, but is used by ggiitt--ffeettcchh--ppaacckk(1) instead of ggiitt--ffsscckk(1). See the ffsscckk..<<mmssgg--iidd>>
           documentation for details.

       fetch.fsck.skipList
           Acts like ffsscckk..sskkiippLLiisstt, but is used by ggiitt--ffeettcchh--ppaacckk(1) instead of ggiitt--ffsscckk(1). See the ffsscckk..sskkiippLLiisstt
           documentation for details.

       fetch.unpackLimit
           If the number of objects fetched over the Git native transfer is below this limit, then the objects will be
           unpacked into loose object files. However if the number of received objects equals or exceeds this limit
           then the received pack will be stored as a pack, after adding any missing delta bases. Storing the pack from
           a push can make the push operation complete faster, especially on slow filesystems. If not set, the value of
           ttrraannssffeerr..uunnppaacckkLLiimmiitt is used instead.

       fetch.prune
           If true, fetch will automatically behave as if the ----pprruunnee option was given on the command line. See also
           rreemmoottee..<<nnaammee>>..pprruunnee and the PRUNING section of ggiitt--ffeettcchh(1).

       fetch.pruneTags
           If true, fetch will automatically behave as if the rreeffss//ttaaggss//**::rreeffss//ttaaggss//** refspec was provided when
           pruning, if not set already. This allows for setting both this option and ffeettcchh..pprruunnee to maintain a 1=1
           mapping to upstream refs. See also rreemmoottee..<<nnaammee>>..pprruunneeTTaaggss and the PRUNING section of ggiitt--ffeettcchh(1).

       fetch.output
           Control how ref update status is printed. Valid values are ffuullll and ccoommppaacctt. Default value is ffuullll. See
           section OUTPUT in ggiitt--ffeettcchh(1) for detail.

       fetch.negotiationAlgorithm
           Control how information about the commits in the local repository is sent when negotiating the contents of
           the packfile to be sent by the server. Set to "skipping" to use an algorithm that skips commits in an effort
           to converge faster, but may result in a larger-than-necessary packfile; The default is "default" which
           instructs Git to use the default algorithm that never skips commits (unless the server has acknowledged it
           or one of its descendants). If ffeeaattuurree..eexxppeerriimmeennttaall is enabled, then this setting defaults to "skipping".
           Unknown values will cause _g_i_t _f_e_t_c_h to error out.

           See also the ----nneeggoottiiaattiioonn--ttiipp option for ggiitt--ffeettcchh(1).

       fetch.showForcedUpdates
           Set to false to enable ----nnoo--sshhooww--ffoorrcceedd--uuppddaatteess in ggiitt--ffeettcchh(1) and ggiitt--ppuullll(1) commands. Defaults to true.

       fetch.parallel
           Specifies the maximal number of fetch operations to be run in parallel at a time (submodules, or remotes
           when the ----mmuullttiippllee option of ggiitt--ffeettcchh(1) is in effect).

           A value of 0 will give some reasonable default. If unset, it defaults to 1.

           For submodules, this setting can be overridden using the ssuubbmmoodduullee..ffeettcchhJJoobbss config setting.

       fetch.writeCommitGraph
           Set to true to write a commit-graph after every ggiitt ffeettcchh command that downloads a pack-file from a remote.
           Using the ----sspplliitt option, most executions will create a very small commit-graph file on top of the existing
           commit-graph file(s). Occasionally, these files will merge and the write may take longer. Having an updated
           commit-graph file helps performance of many Git commands, including ggiitt mmeerrggee--bbaassee, ggiitt ppuusshh --ff, and ggiitt lloogg
           ----ggrraapphh. Defaults to false, unless ffeeaattuurree..eexxppeerriimmeennttaall is true.

       format.attach
           Enable multipart/mixed attachments as the default for _f_o_r_m_a_t_-_p_a_t_c_h. The value can also be a double quoted
           string which will enable attachments as the default and set the value as the boundary. See the --attach
           option in ggiitt--ffoorrmmaatt--ppaattcchh(1).

       format.from
           Provides the default value for the ----ffrroomm option to format-patch. Accepts a boolean value, or a name and
           email address. If false, format-patch defaults to ----nnoo--ffrroomm, using commit authors directly in the "From:"
           field of patch mails. If true, format-patch defaults to ----ffrroomm, using your committer identity in the "From:"
           field of patch mails and including a "From:" field in the body of the patch mail if different. If set to a
           non-boolean value, format-patch uses that value instead of your committer identity. Defaults to false.

       format.numbered
           A boolean which can enable or disable sequence numbers in patch subjects. It defaults to "auto" which
           enables it only if there is more than one patch. It can be enabled or disabled for all messages by setting
           it to "true" or "false". See --numbered option in ggiitt--ffoorrmmaatt--ppaattcchh(1).

       format.headers
           Additional email headers to include in a patch to be submitted by mail. See ggiitt--ffoorrmmaatt--ppaattcchh(1).

       format.to, format.cc
           Additional recipients to include in a patch to be submitted by mail. See the --to and --cc options in ggiitt--
           ffoorrmmaatt--ppaattcchh(1).

       format.subjectPrefix
           The default for format-patch is to output files with the _[_P_A_T_C_H_] subject prefix. Use this variable to change
           that prefix.

       format.coverFromDescription
           The default mode for format-patch to determine which parts of the cover letter will be populated using the
           branch’s description. See the ----ccoovveerr--ffrroomm--ddeessccrriippttiioonn option in ggiitt--ffoorrmmaatt--ppaattcchh(1).

       format.signature
           The default for format-patch is to output a signature containing the Git version number. Use this variable
           to change that default. Set this variable to the empty string ("") to suppress signature generation.

       format.signatureFile
           Works just like format.signature except the contents of the file specified by this variable will be used as
           the signature.

       format.suffix
           The default for format-patch is to output files with the suffix ..ppaattcchh. Use this variable to change that
           suffix (make sure to include the dot if you want it).

       format.pretty
           The default pretty format for log/show/whatchanged command, See ggiitt--lloogg(1), ggiitt--sshhooww(1), ggiitt--wwhhaattcchhaannggeedd(1).

       format.thread
           The default threading style for _g_i_t _f_o_r_m_a_t_-_p_a_t_c_h. Can be a boolean value, or sshhaallllooww or ddeeeepp.  sshhaallllooww
           threading makes every mail a reply to the head of the series, where the head is chosen from the cover
           letter, the ----iinn--rreeppllyy--ttoo, and the first patch mail, in this order.  ddeeeepp threading makes every mail a reply
           to the previous one. A true boolean value is the same as sshhaallllooww, and a false value disables threading.

       format.signOff
           A boolean value which lets you enable the --ss//----ssiiggnnooffff option of format-patch by default.  NNoottee:: Adding the
           Signed-off-by: line to a patch should be a conscious act and means that you certify you have the rights to
           submit this work under the same open source license. Please see the _S_u_b_m_i_t_t_i_n_g_P_a_t_c_h_e_s document for further
           discussion.

       format.coverLetter
           A boolean that controls whether to generate a cover-letter when format-patch is invoked, but in addition can
           be set to "auto", to generate a cover-letter only when there’s more than one patch. Default is false.

       format.outputDirectory
           Set a custom directory to store the resulting files instead of the current working directory. All directory
           components will be created.

       format.useAutoBase
           A boolean value which lets you enable the ----bbaassee==aauuttoo option of format-patch by default.

       format.notes
           Provides the default value for the ----nnootteess option to format-patch. Accepts a boolean value, or a ref which
           specifies where to get notes. If false, format-patch defaults to ----nnoo--nnootteess. If true, format-patch defaults
           to ----nnootteess. If set to a non-boolean value, format-patch defaults to ----nnootteess==<<rreeff>>, where rreeff is the
           non-boolean value. Defaults to false.

           If one wishes to use the ref rreeff//nnootteess//ttrruuee, please use that literal instead.

           This configuration can be specified multiple times in order to allow multiple notes refs to be included. In
           that case, it will behave similarly to multiple ----[[nnoo--]]nnootteess[[==]] options passed in. That is, a value of ttrruuee
           will show the default notes, a value of <<rreeff>> will also show notes from that notes ref and a value of ffaallssee
           will negate previous configurations and not show notes.

           For example,

               [format]
                       notes = true
                       notes = foo
                       notes = false
                       notes = bar

           will only show notes from rreeffss//nnootteess//bbaarr.

       filter.<driver>.clean
           The command which is used to convert the content of a worktree file to a blob upon checkin. See
           ggiittaattttrriibbuutteess(5) for details.

       filter.<driver>.smudge
           The command which is used to convert the content of a blob object to a worktree file upon checkout. See
           ggiittaattttrriibbuutteess(5) for details.

       fsck.<msg-id>
           During fsck git may find issues with legacy data which wouldn’t be generated by current versions of git, and
           which wouldn’t be sent over the wire if ttrraannssffeerr..ffsscckkOObbjjeeccttss was set. This feature is intended to support
           working with legacy repositories containing such data.

           Setting ffsscckk..<<mmssgg--iidd>> will be picked up by ggiitt--ffsscckk(1), but to accept pushes of such data set
           rreecceeiivvee..ffsscckk..<<mmssgg--iidd>> instead, or to clone or fetch it set ffeettcchh..ffsscckk..<<mmssgg--iidd>>.

           The rest of the documentation discusses ffsscckk..**  for brevity, but the same applies for the corresponding
           rreecceeiivvee..ffsscckk..**  and ffeettcchh..<<mmssgg--iidd>>..**. variables.

           Unlike variables like ccoolloorr..uuii and ccoorree..eeddiittoorr the rreecceeiivvee..ffsscckk..<<mmssgg--iidd>> and ffeettcchh..ffsscckk..<<mmssgg--iidd>> variables
           will not fall back on the ffsscckk..<<mmssgg--iidd>> configuration if they aren’t set. To uniformly configure the same
           fsck settings in different circumstances all three of them they must all set to the same values.

           When ffsscckk..<<mmssgg--iidd>> is set, errors can be switched to warnings and vice versa by configuring the
           ffsscckk..<<mmssgg--iidd>> setting where the <<mmssgg--iidd>> is the fsck message ID and the value is one of eerrrroorr, wwaarrnn or
           iiggnnoorree. For convenience, fsck prefixes the error/warning with the message ID, e.g. "missingEmail: invalid
           author/committer line - missing email" means that setting ffsscckk..mmiissssiinnggEEmmaaiill == iiggnnoorree will hide that issue.

           In general, it is better to enumerate existing objects with problems with ffsscckk..sskkiippLLiisstt, instead of listing
           the kind of breakages these problematic objects share to be ignored, as doing the latter will allow new
           instances of the same breakages go unnoticed.

           Setting an unknown ffsscckk..<<mmssgg--iidd>> value will cause fsck to die, but doing the same for rreecceeiivvee..ffsscckk..<<mmssgg--iidd>>
           and ffeettcchh..ffsscckk..<<mmssgg--iidd>> will only cause git to warn.

       fsck.skipList
           The path to a list of object names (i.e. one unabbreviated SHA-1 per line) that are known to be broken in a
           non-fatal way and should be ignored. On versions of Git 2.20 and later comments (_#), empty lines, and any
           leading and trailing whitespace is ignored. Everything but a SHA-1 per line will error out on older
           versions.

           This feature is useful when an established project should be accepted despite early commits containing
           errors that can be safely ignored such as invalid committer email addresses. Note: corrupt objects cannot be
           skipped with this setting.

           Like ffsscckk..<<mmssgg--iidd>> this variable has corresponding rreecceeiivvee..ffsscckk..sskkiippLLiisstt and ffeettcchh..ffsscckk..sskkiippLLiisstt variants.

           Unlike variables like ccoolloorr..uuii and ccoorree..eeddiittoorr the rreecceeiivvee..ffsscckk..sskkiippLLiisstt and ffeettcchh..ffsscckk..sskkiippLLiisstt variables
           will not fall back on the ffsscckk..sskkiippLLiisstt configuration if they aren’t set. To uniformly configure the same
           fsck settings in different circumstances all three of them they must all set to the same values.

           Older versions of Git (before 2.20) documented that the object names list should be sorted. This was never a
           requirement, the object names could appear in any order, but when reading the list we tracked whether the
           list was sorted for the purposes of an internal binary search implementation, which could save itself some
           work with an already sorted list. Unless you had a humongous list there was no reason to go out of your way
           to pre-sort the list. After Git version 2.20 a hash implementation is used instead, so there’s now no reason
           to pre-sort the list.

       gc.aggressiveDepth
           The depth parameter used in the delta compression algorithm used by _g_i_t _g_c _-_-_a_g_g_r_e_s_s_i_v_e. This defaults to
           50, which is the default for the ----ddeepptthh option when ----aaggggrreessssiivvee isn’t in use.

           See the documentation for the ----ddeepptthh option in ggiitt--rreeppaacckk(1) for more details.

       gc.aggressiveWindow
           The window size parameter used in the delta compression algorithm used by _g_i_t _g_c _-_-_a_g_g_r_e_s_s_i_v_e. This defaults
           to 250, which is a much more aggressive window size than the default ----wwiinnddooww of 10.

           See the documentation for the ----wwiinnddooww option in ggiitt--rreeppaacckk(1) for more details.

       gc.auto
           When there are approximately more than this many loose objects in the repository, ggiitt ggcc ----aauuttoo will pack
           them. Some Porcelain commands use this command to perform a light-weight garbage collection from time to
           time. The default value is 6700.

           Setting this to 0 disables not only automatic packing based on the number of loose objects, but any other
           heuristic ggiitt ggcc ----aauuttoo will otherwise use to determine if there’s work to do, such as ggcc..aauuttooPPaacckkLLiimmiitt.

       gc.autoPackLimit
           When there are more than this many packs that are not marked with **..kkeeeepp file in the repository, ggiitt ggcc
           ----aauuttoo consolidates them into one larger pack. The default value is 50. Setting this to 0 disables it.
           Setting ggcc..aauuttoo to 0 will also disable this.

           See the ggcc..bbiiggPPaacckkTThhrreesshhoolldd configuration variable below. When in use, it’ll affect how the auto pack limit
           works.

       gc.autoDetach
           Make ggiitt ggcc ----aauuttoo return immediately and run in background if the system supports it. Default is true.

       gc.bigPackThreshold
           If non-zero, all packs larger than this limit are kept when ggiitt ggcc is run. This is very similar to
           ----kkeeeepp--bbaassee--ppaacckk except that all packs that meet the threshold are kept, not just the base pack. Defaults to
           zero. Common unit suffixes of _k, _m, or _g are supported.

           Note that if the number of kept packs is more than gc.autoPackLimit, this configuration variable is ignored,
           all packs except the base pack will be repacked. After this the number of packs should go below
           gc.autoPackLimit and gc.bigPackThreshold should be respected again.

           If the amount of memory estimated for ggiitt rreeppaacckk to run smoothly is not available and ggcc..bbiiggPPaacckkTThhrreesshhoolldd is
           not set, the largest pack will also be excluded (this is the equivalent of running ggiitt ggcc with
           ----kkeeeepp--bbaassee--ppaacckk).

       gc.writeCommitGraph
           If true, then gc will rewrite the commit-graph file when ggiitt--ggcc(1) is run. When using ggiitt ggcc ----aauuttoo the
           commit-graph will be updated if housekeeping is required. Default is true. See ggiitt--ccoommmmiitt--ggrraapphh(1) for
           details.

       gc.logExpiry
           If the file gc.log exists, then ggiitt ggcc ----aauuttoo will print its content and exit with status zero instead of
           running unless that file is more than _g_c_._l_o_g_E_x_p_i_r_y old. Default is "1.day". See ggcc..pprruunneeEExxppiirree for more ways
           to specify its value.

       gc.packRefs
           Running ggiitt ppaacckk--rreeffss in a repository renders it unclonable by Git versions prior to 1.5.1.2 over dumb
           transports such as HTTP. This variable determines whether _g_i_t _g_c runs ggiitt ppaacckk--rreeffss. This can be set to
           nnoottbbaarree to enable it within all non-bare repos or it can be set to a boolean value. The default is ttrruuee.

       gc.pruneExpire
           When _g_i_t _g_c is run, it will call _p_r_u_n_e _-_-_e_x_p_i_r_e _2_._w_e_e_k_s_._a_g_o. Override the grace period with this config
           variable. The value "now" may be used to disable this grace period and always prune unreachable objects
           immediately, or "never" may be used to suppress pruning. This feature helps prevent corruption when _g_i_t _g_c
           runs concurrently with another process writing to the repository; see the "NOTES" section of ggiitt--ggcc(1).

       gc.worktreePruneExpire
           When _g_i_t _g_c is run, it calls _g_i_t _w_o_r_k_t_r_e_e _p_r_u_n_e _-_-_e_x_p_i_r_e _3_._m_o_n_t_h_s_._a_g_o. This config variable can be used to
           set a different grace period. The value "now" may be used to disable the grace period and prune
           $$GGIITT__DDIIRR//wwoorrkkttrreeeess immediately, or "never" may be used to suppress pruning.

       gc.reflogExpire, gc.<pattern>.reflogExpire
           _g_i_t _r_e_f_l_o_g _e_x_p_i_r_e removes reflog entries older than this time; defaults to 90 days. The value "now" expires
           all entries immediately, and "never" suppresses expiration altogether. With "<pattern>" (e.g. "refs/stash")
           in the middle the setting applies only to the refs that match the <pattern>.

       gc.reflogExpireUnreachable, gc.<pattern>.reflogExpireUnreachable
           _g_i_t _r_e_f_l_o_g _e_x_p_i_r_e removes reflog entries older than this time and are not reachable from the current tip;
           defaults to 30 days. The value "now" expires all entries immediately, and "never" suppresses expiration
           altogether. With "<pattern>" (e.g. "refs/stash") in the middle, the setting applies only to the refs that
           match the <pattern>.

           These types of entries are generally created as a result of using ggiitt ccoommmmiitt ----aammeenndd or ggiitt rreebbaassee and are
           the commits prior to the amend or rebase occurring. Since these changes are not part of the current project
           most users will want to expire them sooner, which is why the default is more aggressive than
           ggcc..rreeffllooggEExxppiirree.

       gc.rerereResolved
           Records of conflicted merge you resolved earlier are kept for this many days when _g_i_t _r_e_r_e_r_e _g_c is run. You
           can also use more human-readable "1.month.ago", etc. The default is 60 days. See ggiitt--rreerreerree(1).

       gc.rerereUnresolved
           Records of conflicted merge you have not resolved are kept for this many days when _g_i_t _r_e_r_e_r_e _g_c is run. You
           can also use more human-readable "1.month.ago", etc. The default is 15 days. See ggiitt--rreerreerree(1).

       gitcvs.commitMsgAnnotation
           Append this string to each commit message. Set to empty string to disable this feature. Defaults to "via
           git-CVS emulator".

       gitcvs.enabled
           Whether the CVS server interface is enabled for this repository. See ggiitt--ccvvsssseerrvveerr(1).

       gitcvs.logFile
           Path to a log file where the CVS server interface well... logs various stuff. See ggiitt--ccvvsssseerrvveerr(1).

       gitcvs.usecrlfattr
           If true, the server will look up the end-of-line conversion attributes for files to determine the --kk modes
           to use. If the attributes force Git to treat a file as text, the --kk mode will be left blank so CVS clients
           will treat it as text. If they suppress text conversion, the file will be set with _-_k_b mode, which
           suppresses any newline munging the client might otherwise do. If the attributes do not allow the file type
           to be determined, then ggiittccvvss..aallllBBiinnaarryy is used. See ggiittaattttrriibbuutteess(5).

       gitcvs.allBinary
           This is used if ggiittccvvss..uusseeccrrllffaattttrr does not resolve the correct _-_k_b mode to use. If true, all unresolved
           files are sent to the client in mode _-_k_b. This causes the client to treat them as binary files, which
           suppresses any newline munging it otherwise might do. Alternatively, if it is set to "guess", then the
           contents of the file are examined to decide if it is binary, similar to ccoorree..aauuttooccrrllff.

       gitcvs.dbName
           Database used by git-cvsserver to cache revision information derived from the Git repository. The exact
           meaning depends on the used database driver, for SQLite (which is the default driver) this is a filename.
           Supports variable substitution (see ggiitt--ccvvsssseerrvveerr(1) for details). May not contain semicolons (;;). Default:
           _%_G_g_i_t_c_v_s_._%_m_._s_q_l_i_t_e

       gitcvs.dbDriver
           Used Perl DBI driver. You can specify any available driver for this here, but it might not work.
           git-cvsserver is tested with _D_B_D_:_:_S_Q_L_i_t_e, reported to work with _D_B_D_:_:_P_g, and reported nnoott to work with
           _D_B_D_:_:_m_y_s_q_l. Experimental feature. May not contain double colons (::). Default: _S_Q_L_i_t_e. See ggiitt--ccvvsssseerrvveerr(1).

       gitcvs.dbUser, gitcvs.dbPass
           Database user and password. Only useful if setting ggiittccvvss..ddbbDDrriivveerr, since SQLite has no concept of database
           users and/or passwords.  _g_i_t_c_v_s_._d_b_U_s_e_r supports variable substitution (see ggiitt--ccvvsssseerrvveerr(1) for details).

       gitcvs.dbTableNamePrefix
           Database table name prefix. Prepended to the names of any database tables used, allowing a single database
           to be used for several repositories. Supports variable substitution (see ggiitt--ccvvsssseerrvveerr(1) for details). Any
           non-alphabetic characters will be replaced with underscores.

       All gitcvs variables except for ggiittccvvss..uusseeccrrllffaattttrr and ggiittccvvss..aallllBBiinnaarryy can also be specified as
       _g_i_t_c_v_s_._<_a_c_c_e_s_s___m_e_t_h_o_d_>_._<_v_a_r_n_a_m_e_> (where _a_c_c_e_s_s___m_e_t_h_o_d is one of "ext" and "pserver") to make them apply only for
       the given access method.

       gitweb.category, gitweb.description, gitweb.owner, gitweb.url
           See ggiittwweebb(1) for description.

       gitweb.avatar, gitweb.blame, gitweb.grep, gitweb.highlight, gitweb.patches, gitweb.pickaxe, gitweb.remote_heads,
       gitweb.showSizes, gitweb.snapshot
           See ggiittwweebb..ccoonnff(5) for description.

       grep.lineNumber
           If set to true, enable --nn option by default.

       grep.column
           If set to true, enable the ----ccoolluummnn option by default.

       grep.patternType
           Set the default matching behavior. Using a value of _b_a_s_i_c, _e_x_t_e_n_d_e_d, _f_i_x_e_d, or _p_e_r_l will enable the
           ----bbaassiicc--rreeggeexxpp, ----eexxtteennddeedd--rreeggeexxpp, ----ffiixxeedd--ssttrriinnggss, or ----ppeerrll--rreeggeexxpp option accordingly, while the value
           _d_e_f_a_u_l_t will return to the default matching behavior.

       grep.extendedRegexp
           If set to true, enable ----eexxtteennddeedd--rreeggeexxpp option by default. This option is ignored when the ggrreepp..ppaatttteerrnnTTyyppee
           option is set to a value other than _d_e_f_a_u_l_t.

       grep.threads
           Number of grep worker threads to use. See ggrreepp..tthhrreeaaddss in ggiitt--ggrreepp(1) for more information.

       grep.fallbackToNoIndex
           If set to true, fall back to git grep --no-index if git grep is executed outside of a git repository.
           Defaults to false.

       gpg.program
           Use this custom program instead of "ggppgg" found on $$PPAATTHH when making or verifying a PGP signature. The
           program must support the same command-line interface as GPG, namely, to verify a detached signature, "ggppgg
           ----vveerriiffyy $$ssiiggnnaattuurree -- <<$$ffiillee" is run, and the program is expected to signal a good signature by exiting with
           code 0, and to generate an ASCII-armored detached signature, the standard input of "ggppgg --bbssaauu $$kkeeyy" is fed
           with the contents to be signed, and the program is expected to send the result to its standard output.

       gpg.format
           Specifies which key format to use when signing with ----ggppgg--ssiiggnn. Default is "openpgp" and another possible
           value is "x509".

       gpg.<format>.program
           Use this to customize the program used for the signing format you chose. (see ggppgg..pprrooggrraamm and ggppgg..ffoorrmmaatt)
           ggppgg..pprrooggrraamm can still be used as a legacy synonym for ggppgg..ooppeennppggpp..pprrooggrraamm. The default value for
           ggppgg..xx550099..pprrooggrraamm is "gpgsm".

       gui.commitMsgWidth
           Defines how wide the commit message window is in the ggiitt--gguuii(1). "75" is the default.

       gui.diffContext
           Specifies how many context lines should be used in calls to diff made by the ggiitt--gguuii(1). The default is "5".

       gui.displayUntracked
           Determines if ggiitt--gguuii(1) shows untracked files in the file list. The default is "true".

       gui.encoding
           Specifies the default encoding to use for displaying of file contents in ggiitt--gguuii(1) and ggiittkk(1). It can be
           overridden by setting the _e_n_c_o_d_i_n_g attribute for relevant files (see ggiittaattttrriibbuutteess(5)). If this option is
           not set, the tools default to the locale encoding.

       gui.matchTrackingBranch
           Determines if new branches created with ggiitt--gguuii(1) should default to tracking remote branches with matching
           names or not. Default: "false".

       gui.newBranchTemplate
           Is used as suggested name when creating new branches using the ggiitt--gguuii(1).

       gui.pruneDuringFetch
           "true" if ggiitt--gguuii(1) should prune remote-tracking branches when performing a fetch. The default value is
           "false".

       gui.trustmtime
           Determines if ggiitt--gguuii(1) should trust the file modification timestamp or not. By default the timestamps are
           not trusted.

       gui.spellingDictionary
           Specifies the dictionary used for spell checking commit messages in the ggiitt--gguuii(1). When set to "none" spell
           checking is turned off.

       gui.fastCopyBlame
           If true, _g_i_t _g_u_i _b_l_a_m_e uses --CC instead of --CC --CC for original location detection. It makes blame
           significantly faster on huge repositories at the expense of less thorough copy detection.

       gui.copyBlameThreshold
           Specifies the threshold to use in _g_i_t _g_u_i _b_l_a_m_e original location detection, measured in alphanumeric
           characters. See the ggiitt--bbllaammee(1) manual for more information on copy detection.

       gui.blamehistoryctx
           Specifies the radius of history context in days to show in ggiittkk(1) for the selected commit, when the SShhooww
           HHiissttoorryy CCoonntteexxtt menu item is invoked from _g_i_t _g_u_i _b_l_a_m_e. If this variable is set to zero, the whole history
           is shown.

       guitool.<name>.cmd
           Specifies the shell command line to execute when the corresponding item of the ggiitt--gguuii(1) TToooollss menu is
           invoked. This option is mandatory for every tool. The command is executed from the root of the working
           directory, and in the environment it receives the name of the tool as GGIITT__GGUUIITTOOOOLL, the name of the currently
           selected file as _F_I_L_E_N_A_M_E, and the name of the current branch as _C_U_R___B_R_A_N_C_H (if the head is detached,
           _C_U_R___B_R_A_N_C_H is empty).

       guitool.<name>.needsFile
           Run the tool only if a diff is selected in the GUI. It guarantees that _F_I_L_E_N_A_M_E is not empty.

       guitool.<name>.noConsole
           Run the command silently, without creating a window to display its output.

       guitool.<name>.noRescan
           Don’t rescan the working directory for changes after the tool finishes execution.

       guitool.<name>.confirm
           Show a confirmation dialog before actually running the tool.

       guitool.<name>.argPrompt
           Request a string argument from the user, and pass it to the tool through the AARRGGSS environment variable.
           Since requesting an argument implies confirmation, the _c_o_n_f_i_r_m option has no effect if this is enabled. If
           the option is set to _t_r_u_e, _y_e_s, or _1, the dialog uses a built-in generic prompt; otherwise the exact value
           of the variable is used.

       guitool.<name>.revPrompt
           Request a single valid revision from the user, and set the RREEVVIISSIIOONN environment variable. In other aspects
           this option is similar to _a_r_g_P_r_o_m_p_t, and can be used together with it.

       guitool.<name>.revUnmerged
           Show only unmerged branches in the _r_e_v_P_r_o_m_p_t subdialog. This is useful for tools similar to merge or rebase,
           but not for things like checkout or reset.

       guitool.<name>.title
           Specifies the title to use for the prompt dialog. The default is the tool name.

       guitool.<name>.prompt
           Specifies the general prompt string to display at the top of the dialog, before subsections for _a_r_g_P_r_o_m_p_t
           and _r_e_v_P_r_o_m_p_t. The default value includes the actual command.

       help.browser
           Specify the browser that will be used to display help in the _w_e_b format. See ggiitt--hheellpp(1).

       help.format
           Override the default help format used by ggiitt--hheellpp(1). Values _m_a_n, _i_n_f_o, _w_e_b and _h_t_m_l are supported.  _m_a_n is
           the default.  _w_e_b and _h_t_m_l are the same.

       help.autoCorrect
           Automatically correct and execute mistyped commands after waiting for the given number of deciseconds (0.1
           sec). If more than one command can be deduced from the entered text, nothing will be executed. If the value
           of this option is negative, the corrected command will be executed immediately. If the value is 0 - the
           command will be just shown but not executed. This is the default.

       help.htmlPath
           Specify the path where the HTML documentation resides. File system paths and URLs are supported. HTML pages
           will be prefixed with this path when help is displayed in the _w_e_b format. This defaults to the documentation
           path of your Git installation.

       http.proxy
           Override the HTTP proxy, normally configured using the _h_t_t_p___p_r_o_x_y, _h_t_t_p_s___p_r_o_x_y, and _a_l_l___p_r_o_x_y environment
           variables (see ccuurrll((11))). In addition to the syntax understood by curl, it is possible to specify a proxy
           string with a user name but no password, in which case git will attempt to acquire one in the same way it
           does for other credentials. See ggiittccrreeddeennttiiaallss(7) for more information. The syntax thus is
           _[_p_r_o_t_o_c_o_l_:_/_/_]_[_u_s_e_r_[_:_p_a_s_s_w_o_r_d_]_@_]_p_r_o_x_y_h_o_s_t_[_:_p_o_r_t_]. This can be overridden on a per-remote basis; see
           remote.<name>.proxy

       http.proxyAuthMethod
           Set the method with which to authenticate against the HTTP proxy. This only takes effect if the configured
           proxy string contains a user name part (i.e. is of the form _u_s_e_r_@_h_o_s_t or _u_s_e_r_@_h_o_s_t_:_p_o_r_t). This can be
           overridden on a per-remote basis; see rreemmoottee..<<nnaammee>>..pprrooxxyyAAuutthhMMeetthhoodd. Both can be overridden by the
           GGIITT__HHTTTTPP__PPRROOXXYY__AAUUTTHHMMEETTHHOODD environment variable. Possible values are:

           •   aannyyaauutthh - Automatically pick a suitable authentication method. It is assumed that the proxy answers an
               unauthenticated request with a 407 status code and one or more Proxy-authenticate headers with supported
               authentication methods. This is the default.

           •   bbaassiicc - HTTP Basic authentication

           •   ddiiggeesstt - HTTP Digest authentication; this prevents the password from being transmitted to the proxy in
               clear text

           •   nneeggoottiiaattee - GSS-Negotiate authentication (compare the --negotiate option of ccuurrll((11)))

           •   nnttllmm - NTLM authentication (compare the --ntlm option of ccuurrll((11)))

       http.emptyAuth
           Attempt authentication without seeking a username or password. This can be used to attempt GSS-Negotiate
           authentication without specifying a username in the URL, as libcurl normally requires a username for
           authentication.

       http.delegation
           Control GSSAPI credential delegation. The delegation is disabled by default in libcurl since version 7.21.7.
           Set parameter to tell the server what it is allowed to delegate when it comes to user credentials. Used with
           GSS/kerberos. Possible values are:

           •   nnoonnee - Don’t allow any delegation.

           •   ppoolliiccyy - Delegates if and only if the OK-AS-DELEGATE flag is set in the Kerberos service ticket, which
               is a matter of realm policy.

           •   aallwwaayyss - Unconditionally allow the server to delegate.

       http.extraHeader
           Pass an additional HTTP header when communicating with a server. If more than one such entry exists, all of
           them are added as extra headers. To allow overriding the settings inherited from the system config, an empty
           value will reset the extra headers to the empty list.

       http.cookieFile
           The pathname of a file containing previously stored cookie lines, which should be used in the Git http
           session, if they match the server. The file format of the file to read cookies from should be plain HTTP
           headers or the Netscape/Mozilla cookie file format (see ccuurrll((11))). NOTE that the file specified with
           http.cookieFile is used only as input unless http.saveCookies is set.

       http.saveCookies
           If set, store cookies received during requests to the file specified by http.cookieFile. Has no effect if
           http.cookieFile is unset.

       http.version
           Use the specified HTTP protocol version when communicating with a server. If you want to force the default.
           The available and default version depend on libcurl. Currently the possible values of this option are:

           •   HTTP/2

           •   HTTP/1.1

       http.sslVersion
           The SSL version to use when negotiating an SSL connection, if you want to force the default. The available
           and default version depend on whether libcurl was built against NSS or OpenSSL and the particular
           configuration of the crypto library in use. Internally this sets the _C_U_R_L_O_P_T___S_S_L___V_E_R_S_I_O_N option; see the
           libcurl documentation for more details on the format of this option and for the ssl version supported.
           Currently the possible values of this option are:

           •   sslv2

           •   sslv3

           •   tlsv1

           •   tlsv1.0

           •   tlsv1.1

           •   tlsv1.2

           •   tlsv1.3

           Can be overridden by the GGIITT__SSSSLL__VVEERRSSIIOONN environment variable. To force git to use libcurl’s default ssl
           version and ignore any explicit http.sslversion option, set GGIITT__SSSSLL__VVEERRSSIIOONN to the empty string.

       http.sslCipherList
           A list of SSL ciphers to use when negotiating an SSL connection. The available ciphers depend on whether
           libcurl was built against NSS or OpenSSL and the particular configuration of the crypto library in use.
           Internally this sets the _C_U_R_L_O_P_T___S_S_L___C_I_P_H_E_R___L_I_S_T option; see the libcurl documentation for more details on
           the format of this list.

           Can be overridden by the GGIITT__SSSSLL__CCIIPPHHEERR__LLIISSTT environment variable. To force git to use libcurl’s default
           cipher list and ignore any explicit http.sslCipherList option, set GGIITT__SSSSLL__CCIIPPHHEERR__LLIISSTT to the empty string.

       http.sslVerify
           Whether to verify the SSL certificate when fetching or pushing over HTTPS. Defaults to true. Can be
           overridden by the GGIITT__SSSSLL__NNOO__VVEERRIIFFYY environment variable.

       http.sslCert
           File containing the SSL certificate when fetching or pushing over HTTPS. Can be overridden by the
           GGIITT__SSSSLL__CCEERRTT environment variable.

       http.sslKey
           File containing the SSL private key when fetching or pushing over HTTPS. Can be overridden by the
           GGIITT__SSSSLL__KKEEYY environment variable.

       http.sslCertPasswordProtected
           Enable Git’s password prompt for the SSL certificate. Otherwise OpenSSL will prompt the user, possibly many
           times, if the certificate or private key is encrypted. Can be overridden by the
           GGIITT__SSSSLL__CCEERRTT__PPAASSSSWWOORRDD__PPRROOTTEECCTTEEDD environment variable.

       http.sslCAInfo
           File containing the certificates to verify the peer with when fetching or pushing over HTTPS. Can be
           overridden by the GGIITT__SSSSLL__CCAAIINNFFOO environment variable.

       http.sslCAPath
           Path containing files with the CA certificates to verify the peer with when fetching or pushing over HTTPS.
           Can be overridden by the GGIITT__SSSSLL__CCAAPPAATTHH environment variable.

       http.sslBackend
           Name of the SSL backend to use (e.g. "openssl" or "schannel"). This option is ignored if cURL lacks support
           for choosing the SSL backend at runtime.

       http.schannelCheckRevoke
           Used to enforce or disable certificate revocation checks in cURL when http.sslBackend is set to "schannel".
           Defaults to ttrruuee if unset. Only necessary to disable this if Git consistently errors and the message is
           about checking the revocation status of a certificate. This option is ignored if cURL lacks support for
           setting the relevant SSL option at runtime.

       http.schannelUseSSLCAInfo
           As of cURL v7.60.0, the Secure Channel backend can use the certificate bundle provided via hhttttpp..ssssllCCAAIInnffoo,
           but that would override the Windows Certificate Store. Since this is not desirable by default, Git will tell
           cURL not to use that bundle by default when the sscchhaannnneell backend was configured via hhttttpp..ssssllBBaacckkeenndd, unless
           hhttttpp..sscchhaannnneellUUsseeSSSSLLCCAAIInnffoo overrides this behavior.

       http.pinnedpubkey
           Public key of the https service. It may either be the filename of a PEM or DER encoded public key file or a
           string starting with _s_h_a_2_5_6_/_/ followed by the base64 encoded sha256 hash of the public key. See also libcurl
           _C_U_R_L_O_P_T___P_I_N_N_E_D_P_U_B_L_I_C_K_E_Y. git will exit with an error if this option is set but not supported by cURL.

       http.sslTry
           Attempt to use AUTH SSL/TLS and encrypted data transfers when connecting via regular FTP protocol. This
           might be needed if the FTP server requires it for security reasons or you wish to connect securely whenever
           remote FTP server supports it. Default is false since it might trigger certificate verification errors on
           misconfigured servers.

       http.maxRequests
           How many HTTP requests to launch in parallel. Can be overridden by the GGIITT__HHTTTTPP__MMAAXX__RREEQQUUEESSTTSS environment
           variable. Default is 5.

       http.minSessions
           The number of curl sessions (counted across slots) to be kept across requests. They will not be ended with
           curl_easy_cleanup() until http_cleanup() is invoked. If USE_CURL_MULTI is not defined, this value will be
           capped at 1. Defaults to 1.

       http.postBuffer
           Maximum size in bytes of the buffer used by smart HTTP transports when POSTing data to the remote system.
           For requests larger than this buffer size, HTTP/1.1 and Transfer-Encoding: chunked is used to avoid creating
           a massive pack file locally. Default is 1 MiB, which is sufficient for most requests.

           Note that raising this limit is only effective for disabling chunked transfer encoding and therefore should
           be used only where the remote server or a proxy only supports HTTP/1.0 or is noncompliant with the HTTP
           standard. Raising this is not, in general, an effective solution for most push problems, but can increase
           memory consumption significantly since the entire buffer is allocated even for small pushes.

       http.lowSpeedLimit, http.lowSpeedTime
           If the HTTP transfer speed is less than _h_t_t_p_._l_o_w_S_p_e_e_d_L_i_m_i_t for longer than _h_t_t_p_._l_o_w_S_p_e_e_d_T_i_m_e seconds, the
           transfer is aborted. Can be overridden by the GGIITT__HHTTTTPP__LLOOWW__SSPPEEEEDD__LLIIMMIITT and GGIITT__HHTTTTPP__LLOOWW__SSPPEEEEDD__TTIIMMEE
           environment variables.

       http.noEPSV
           A boolean which disables using of EPSV ftp command by curl. This can helpful with some "poor" ftp servers
           which don’t support EPSV mode. Can be overridden by the GGIITT__CCUURRLL__FFTTPP__NNOO__EEPPSSVV environment variable. Default
           is false (curl will use EPSV).

       http.userAgent
           The HTTP USER_AGENT string presented to an HTTP server. The default value represents the version of the
           client Git such as git/1.7.1. This option allows you to override this value to a more common value such as
           Mozilla/4.0. This may be necessary, for instance, if connecting through a firewall that restricts HTTP
           connections to a set of common USER_AGENT strings (but not including those like git/1.7.1). Can be
           overridden by the GGIITT__HHTTTTPP__UUSSEERR__AAGGEENNTT environment variable.

       http.followRedirects
           Whether git should follow HTTP redirects. If set to ttrruuee, git will transparently follow any redirect issued
           by a server it encounters. If set to ffaallssee, git will treat all redirects as errors. If set to iinniittiiaall, git
           will follow redirects only for the initial request to a remote, but not for subsequent follow-up HTTP
           requests. Since git uses the redirected URL as the base for the follow-up requests, this is generally
           sufficient. The default is iinniittiiaall.

       http.<url>.*
           Any of the http.* options above can be applied selectively to some URLs. For a config key to match a URL,
           each element of the config key is compared to that of the URL, in the following order:

            1. Scheme (e.g., hhttttppss in hhttttppss::////eexxaammppllee..ccoomm//). This field must match exactly between the config key and
               the URL.

            2. Host/domain name (e.g., eexxaammppllee..ccoomm in hhttttppss::////eexxaammppllee..ccoomm//). This field must match between the config
               key and the URL. It is possible to specify a ** as part of the host name to match all subdomains at this
               level.  hhttttppss::////**..eexxaammppllee..ccoomm// for example would match hhttttppss::////ffoooo..eexxaammppllee..ccoomm//, but not
               hhttttppss::////ffoooo..bbaarr..eexxaammppllee..ccoomm//.

            3. Port number (e.g., 88008800 in hhttttpp::////eexxaammppllee..ccoomm::88008800//). This field must match exactly between the config
               key and the URL. Omitted port numbers are automatically converted to the correct default for the scheme
               before matching.

            4. Path (e.g., rreeppoo..ggiitt in hhttttppss::////eexxaammppllee..ccoomm//rreeppoo..ggiitt). The path field of the config key must match the
               path field of the URL either exactly or as a prefix of slash-delimited path elements. This means a
               config key with path ffoooo// matches URL path ffoooo//bbaarr. A prefix can only match on a slash (//) boundary.
               Longer matches take precedence (so a config key with path ffoooo//bbaarr is a better match to URL path ffoooo//bbaarr
               than a config key with just path ffoooo//).

            5. User name (e.g., uusseerr in hhttttppss::////uusseerr@@eexxaammppllee..ccoomm//rreeppoo..ggiitt). If the config key has a user name it must
               match the user name in the URL exactly. If the config key does not have a user name, that config key
               will match a URL with any user name (including none), but at a lower precedence than a config key with a
               user name.

           The list above is ordered by decreasing precedence; a URL that matches a config key’s path is preferred to
           one that matches its user name. For example, if the URL is hhttttppss::////uusseerr@@eexxaammppllee..ccoomm//ffoooo//bbaarr a config key
           match of hhttttppss::////eexxaammppllee..ccoomm//ffoooo will be preferred over a config key match of hhttttppss::////uusseerr@@eexxaammppllee..ccoomm.

           All URLs are normalized before attempting any matching (the password part, if embedded in the URL, is always
           ignored for matching purposes) so that equivalent URLs that are simply spelled differently will match
           properly. Environment variable settings always override any matches. The URLs that are matched against are
           those given directly to Git commands. This means any URLs visited as a result of a redirection do not
           participate in matching.

       i18n.commitEncoding
           Character encoding the commit messages are stored in; Git itself does not care per se, but this information
           is necessary e.g. when importing commits from emails or in the gitk graphical history browser (and possibly
           at other places in the future or in other porcelains). See e.g.  ggiitt--mmaaiilliinnffoo(1). Defaults to _u_t_f_-_8.

       i18n.logOutputEncoding
           Character encoding the commit messages are converted to when running _g_i_t _l_o_g and friends.

       imap.folder
           The folder to drop the mails into, which is typically the Drafts folder. For example: "INBOX.Drafts",
           "INBOX/Drafts" or "[Gmail]/Drafts". Required.

       imap.tunnel
           Command used to setup a tunnel to the IMAP server through which commands will be piped instead of using a
           direct network connection to the server. Required when imap.host is not set.

       imap.host
           A URL identifying the server. Use an iimmaapp:://// prefix for non-secure connections and an iimmaappss:://// prefix for
           secure connections. Ignored when imap.tunnel is set, but required otherwise.

       imap.user
           The username to use when logging in to the server.

       imap.pass
           The password to use when logging in to the server.

       imap.port
           An integer port number to connect to on the server. Defaults to 143 for imap:// hosts and 993 for imaps://
           hosts. Ignored when imap.tunnel is set.

       imap.sslverify
           A boolean to enable/disable verification of the server certificate used by the SSL/TLS connection. Default
           is ttrruuee. Ignored when imap.tunnel is set.

       imap.preformattedHTML
           A boolean to enable/disable the use of html encoding when sending a patch. An html encoded patch will be
           bracketed with <pre> and have a content type of text/html. Ironically, enabling this option causes
           Thunderbird to send the patch as a plain/text, format=fixed email. Default is ffaallssee.

       imap.authMethod
           Specify authenticate method for authentication with IMAP server. If Git was built with the NO_CURL option,
           or if your curl version is older than 7.34.0, or if you’re running git-imap-send with the ----nnoo--ccuurrll option,
           the only supported method is _C_R_A_M_-_M_D_5. If this is not set then _g_i_t _i_m_a_p_-_s_e_n_d uses the basic IMAP plaintext
           LOGIN command.

       index.recordEndOfIndexEntries
           Specifies whether the index file should include an "End Of Index Entry" section. This reduces index load
           time on multiprocessor machines but produces a message "ignoring EOIE extension" when reading the index
           using Git versions before 2.20. Defaults to _t_r_u_e if index.threads has been explicitly enabled, _f_a_l_s_e
           otherwise.

       index.recordOffsetTable
           Specifies whether the index file should include an "Index Entry Offset Table" section. This reduces index
           load time on multiprocessor machines but produces a message "ignoring IEOT extension" when reading the index
           using Git versions before 2.20. Defaults to _t_r_u_e if index.threads has been explicitly enabled, _f_a_l_s_e
           otherwise.

       index.threads
           Specifies the number of threads to spawn when loading the index. This is meant to reduce index load time on
           multiprocessor machines. Specifying 0 or _t_r_u_e will cause Git to auto-detect the number of CPU’s and set the
           number of threads accordingly. Specifying 1 or _f_a_l_s_e will disable multithreading. Defaults to _t_r_u_e.

       index.version
           Specify the version with which new index files should be initialized. This does not affect existing
           repositories. If ffeeaattuurree..mmaannyyFFiilleess is enabled, then the default is 4.

       init.templateDir
           Specify the directory from which templates will be copied. (See the "TEMPLATE DIRECTORY" section of ggiitt--
           iinniitt(1).)

       instaweb.browser
           Specify the program that will be used to browse your working repository in gitweb. See ggiitt--iinnssttaawweebb(1).

       instaweb.httpd
           The HTTP daemon command-line to start gitweb on your working repository. See ggiitt--iinnssttaawweebb(1).

       instaweb.local
           If true the web server started by ggiitt--iinnssttaawweebb(1) will be bound to the local IP (127.0.0.1).

       instaweb.modulePath
           The default module path for ggiitt--iinnssttaawweebb(1) to use instead of /usr/lib/apache2/modules. Only used if httpd
           is Apache.

       instaweb.port
           The port number to bind the gitweb httpd to. See ggiitt--iinnssttaawweebb(1).

       interactive.singleKey
           In interactive commands, allow the user to provide one-letter input with a single key (i.e., without hitting
           enter). Currently this is used by the ----ppaattcchh mode of ggiitt--aadddd(1), ggiitt--cchheecckkoouutt(1), ggiitt--rreessttoorree(1), ggiitt--
           ccoommmmiitt(1), ggiitt--rreesseett(1), and ggiitt--ssttaasshh(1). Note that this setting is silently ignored if portable keystroke
           input is not available; requires the Perl module Term::ReadKey.

       interactive.diffFilter
           When an interactive command (such as ggiitt aadddd ----ppaattcchh) shows a colorized diff, git will pipe the diff through
           the shell command defined by this configuration variable. The command may mark up the diff further for human
           consumption, provided that it retains a one-to-one correspondence with the lines in the original diff.
           Defaults to disabled (no filtering).

       log.abbrevCommit
           If true, makes ggiitt--lloogg(1), ggiitt--sshhooww(1), and ggiitt--wwhhaattcchhaannggeedd(1) assume ----aabbbbrreevv--ccoommmmiitt. You may override this
           option with ----nnoo--aabbbbrreevv--ccoommmmiitt.

       log.date
           Set the default date-time mode for the _l_o_g command. Setting a value for log.date is similar to using _g_i_t
           _l_o_g's ----ddaattee option. See ggiitt--lloogg(1) for details.

       log.decorate
           Print out the ref names of any commits that are shown by the log command. If _s_h_o_r_t is specified, the ref
           name prefixes _r_e_f_s_/_h_e_a_d_s_/, _r_e_f_s_/_t_a_g_s_/ and _r_e_f_s_/_r_e_m_o_t_e_s_/ will not be printed. If _f_u_l_l is specified, the full
           ref name (including prefix) will be printed. If _a_u_t_o is specified, then if the output is going to a
           terminal, the ref names are shown as if _s_h_o_r_t were given, otherwise no ref names are shown. This is the same
           as the ----ddeeccoorraattee option of the ggiitt lloogg.

       log.follow
           If ttrruuee, ggiitt lloogg will act as if the ----ffoollllooww option was used when a single <path> is given. This has the
           same limitations as ----ffoollllooww, i.e. it cannot be used to follow multiple files and does not work well on
           non-linear history.

       log.graphColors
           A list of colors, separated by commas, that can be used to draw history lines in ggiitt lloogg ----ggrraapphh.

       log.showRoot
           If true, the initial commit will be shown as a big creation event. This is equivalent to a diff against an
           empty tree. Tools like ggiitt--lloogg(1) or ggiitt--wwhhaattcchhaannggeedd(1), which normally hide the root commit will now show
           it. True by default.

       log.showSignature
           If true, makes ggiitt--lloogg(1), ggiitt--sshhooww(1), and ggiitt--wwhhaattcchhaannggeedd(1) assume ----sshhooww--ssiiggnnaattuurree.

       log.mailmap
           If true, makes ggiitt--lloogg(1), ggiitt--sshhooww(1), and ggiitt--wwhhaattcchhaannggeedd(1) assume ----uussee--mmaaiillmmaapp, otherwise assume
           ----nnoo--uussee--mmaaiillmmaapp. True by default.

       mailinfo.scissors
           If true, makes ggiitt--mmaaiilliinnffoo(1) (and therefore ggiitt--aamm(1)) act by default as if the --scissors option was
           provided on the command-line. When active, this features removes everything from the message body before a
           scissors line (i.e. consisting mainly of ">8", "8<" and "-").

       mailmap.file
           The location of an augmenting mailmap file. The default mailmap, located in the root of the repository, is
           loaded first, then the mailmap file pointed to by this variable. The location of the mailmap file may be in
           a repository subdirectory, or somewhere outside of the repository itself. See ggiitt--sshhoorrttlloogg(1) and ggiitt--
           bbllaammee(1).

       mailmap.blob
           Like mmaaiillmmaapp..ffiillee, but consider the value as a reference to a blob in the repository. If both mmaaiillmmaapp..ffiillee
           and mmaaiillmmaapp..bblloobb are given, both are parsed, with entries from mmaaiillmmaapp..ffiillee taking precedence. In a bare
           repository, this defaults to HHEEAADD::..mmaaiillmmaapp. In a non-bare repository, it defaults to empty.

       man.viewer
           Specify the programs that may be used to display help in the _m_a_n format. See ggiitt--hheellpp(1).

       man.<tool>.cmd
           Specify the command to invoke the specified man viewer. The specified command is evaluated in shell with the
           man page passed as argument. (See ggiitt--hheellpp(1).)

       man.<tool>.path
           Override the path for the given tool that may be used to display help in the _m_a_n format. See ggiitt--hheellpp(1).

       merge.conflictStyle
           Specify the style in which conflicted hunks are written out to working tree files upon merge. The default is
           "merge", which shows a <<<<<<<<<<<<<< conflict marker, changes made by one side, a ============== marker, changes made by
           the other side, and then a >>>>>>>>>>>>>> marker. An alternate style, "diff3", adds a |||||||||||||| marker and the
           original text before the ============== marker.

       merge.defaultToUpstream
           If merge is called without any commit argument, merge the upstream branches configured for the current
           branch by using their last observed values stored in their remote-tracking branches. The values of the
           bbrraanncchh..<<ccuurrrreenntt bbrraanncchh>>..mmeerrggee that name the branches at the remote named by bbrraanncchh..<<ccuurrrreenntt bbrraanncchh>>..rreemmoottee
           are consulted, and then they are mapped via rreemmoottee..<<rreemmoottee>>..ffeettcchh to their corresponding remote-tracking
           branches, and the tips of these tracking branches are merged.

       merge.ff
           By default, Git does not create an extra merge commit when merging a commit that is a descendant of the
           current commit. Instead, the tip of the current branch is fast-forwarded. When set to ffaallssee, this variable
           tells Git to create an extra merge commit in such a case (equivalent to giving the ----nnoo--ffff option from the
           command line). When set to oonnllyy, only such fast-forward merges are allowed (equivalent to giving the
           ----ffff--oonnllyy option from the command line).

       merge.verifySignatures
           If true, this is equivalent to the --verify-signatures command line option. See ggiitt--mmeerrggee(1) for details.

       merge.branchdesc
           In addition to branch names, populate the log message with the branch description text associated with them.
           Defaults to false.

       merge.log
           In addition to branch names, populate the log message with at most the specified number of one-line
           descriptions from the actual commits that are being merged. Defaults to false, and true is a synonym for 20.

       merge.renameLimit
           The number of files to consider when performing rename detection during a merge; if not specified, defaults
           to the value of diff.renameLimit. This setting has no effect if rename detection is turned off.

       merge.renames
           Whether Git detects renames. If set to "false", rename detection is disabled. If set to "true", basic rename
           detection is enabled. Defaults to the value of diff.renames.

       merge.directoryRenames
           Whether Git detects directory renames, affecting what happens at merge time to new files added to a
           directory on one side of history when that directory was renamed on the other side of history. If
           merge.directoryRenames is set to "false", directory rename detection is disabled, meaning that such new
           files will be left behind in the old directory. If set to "true", directory rename detection is enabled,
           meaning that such new files will be moved into the new directory. If set to "conflict", a conflict will be
           reported for such paths. If merge.renames is false, merge.directoryRenames is ignored and treated as false.
           Defaults to "conflict".

       merge.renormalize
           Tell Git that canonical representation of files in the repository has changed over time (e.g. earlier
           commits record text files with CRLF line endings, but recent ones use LF line endings). In such a
           repository, Git can convert the data recorded in commits to a canonical form before performing a merge to
           reduce unnecessary conflicts. For more information, see section "Merging branches with differing
           checkin/checkout attributes" in ggiittaattttrriibbuutteess(5).

       merge.stat
           Whether to print the diffstat between ORIG_HEAD and the merge result at the end of the merge. True by
           default.

       merge.tool
           Controls which merge tool is used by ggiitt--mmeerrggeettooooll(1). The list below shows the valid built-in values. Any
           other value is treated as a custom merge tool and requires that a corresponding mergetool.<tool>.cmd
           variable is defined.

       merge.guitool
           Controls which merge tool is used by ggiitt--mmeerrggeettooooll(1) when the -g/--gui flag is specified. The list below
           shows the valid built-in values. Any other value is treated as a custom merge tool and requires that a
           corresponding mergetool.<guitool>.cmd variable is defined.

           •   araxis

           •   bc

           •   bc3

           •   codecompare

           •   deltawalker

           •   diffmerge

           •   diffuse

           •   ecmerge

           •   emerge

           •   examdiff

           •   guiffy

           •   gvimdiff

           •   gvimdiff2

           •   gvimdiff3

           •   kdiff3

           •   meld

           •   opendiff

           •   p4merge

           •   smerge

           •   tkdiff

           •   tortoisemerge

           •   vimdiff

           •   vimdiff2

           •   vimdiff3

           •   winmerge

           •   xxdiff

       merge.verbosity
           Controls the amount of output shown by the recursive merge strategy. Level 0 outputs nothing except a final
           error message if conflicts were detected. Level 1 outputs only conflicts, 2 outputs conflicts and file
           changes. Level 5 and above outputs debugging information. The default is level 2. Can be overridden by the
           GGIITT__MMEERRGGEE__VVEERRBBOOSSIITTYY environment variable.

       merge.<driver>.name
           Defines a human-readable name for a custom low-level merge driver. See ggiittaattttrriibbuutteess(5) for details.

       merge.<driver>.driver
           Defines the command that implements a custom low-level merge driver. See ggiittaattttrriibbuutteess(5) for details.

       merge.<driver>.recursive
           Names a low-level merge driver to be used when performing an internal merge between common ancestors. See
           ggiittaattttrriibbuutteess(5) for details.

       mergetool.<tool>.path
           Override the path for the given tool. This is useful in case your tool is not in the PATH.

       mergetool.<tool>.cmd
           Specify the command to invoke the specified merge tool. The specified command is evaluated in shell with the
           following variables available: _B_A_S_E is the name of a temporary file containing the common base of the files
           to be merged, if available; _L_O_C_A_L is the name of a temporary file containing the contents of the file on the
           current branch; _R_E_M_O_T_E is the name of a temporary file containing the contents of the file from the branch
           being merged; _M_E_R_G_E_D contains the name of the file to which the merge tool should write the results of a
           successful merge.

       mergetool.<tool>.trustExitCode
           For a custom merge command, specify whether the exit code of the merge command can be used to determine
           whether the merge was successful. If this is not set to true then the merge target file timestamp is checked
           and the merge assumed to have been successful if the file has been updated, otherwise the user is prompted
           to indicate the success of the merge.

       mergetool.meld.hasOutput
           Older versions of mmeelldd do not support the ----oouuttppuutt option. Git will attempt to detect whether mmeelldd supports
           ----oouuttppuutt by inspecting the output of mmeelldd ----hheellpp. Configuring mmeerrggeettooooll..mmeelldd..hhaassOOuuttppuutt will make Git skip
           these checks and use the configured value instead. Setting mmeerrggeettooooll..mmeelldd..hhaassOOuuttppuutt to ttrruuee tells Git to
           unconditionally use the ----oouuttppuutt option, and ffaallssee avoids using ----oouuttppuutt.

       mergetool.keepBackup
           After performing a merge, the original file with conflict markers can be saved as a file with a ..oorriigg
           extension. If this variable is set to ffaallssee then this file is not preserved. Defaults to ttrruuee (i.e. keep the
           backup files).

       mergetool.keepTemporaries
           When invoking a custom merge tool, Git uses a set of temporary files to pass to the tool. If the tool
           returns an error and this variable is set to ttrruuee, then these temporary files will be preserved, otherwise
           they will be removed after the tool has exited. Defaults to ffaallssee.

       mergetool.writeToTemp
           Git writes temporary _B_A_S_E, _L_O_C_A_L, and _R_E_M_O_T_E versions of conflicting files in the worktree by default. Git
           will attempt to use a temporary directory for these files when set ttrruuee. Defaults to ffaallssee.

       mergetool.prompt
           Prompt before each invocation of the merge resolution program.

       notes.mergeStrategy
           Which merge strategy to choose by default when resolving notes conflicts. Must be one of mmaannuuaall, oouurrss,
           tthheeiirrss, uunniioonn, or ccaatt__ssoorrtt__uunniiqq. Defaults to mmaannuuaall. See "NOTES MERGE STRATEGIES" section of ggiitt--nnootteess(1)
           for more information on each strategy.

       notes.<name>.mergeStrategy
           Which merge strategy to choose when doing a notes merge into refs/notes/<name>. This overrides the more
           general "notes.mergeStrategy". See the "NOTES MERGE STRATEGIES" section in ggiitt--nnootteess(1) for more information
           on the available strategies.

       notes.displayRef
           The (fully qualified) refname from which to show notes when showing commit messages. The value of this
           variable can be set to a glob, in which case notes from all matching refs will be shown. You may also
           specify this configuration variable several times. A warning will be issued for refs that do not exist, but
           a glob that does not match any refs is silently ignored.

           This setting can be overridden with the GGIITT__NNOOTTEESS__DDIISSPPLLAAYY__RREEFF environment variable, which must be a colon
           separated list of refs or globs.

           The effective value of "core.notesRef" (possibly overridden by GIT_NOTES_REF) is also implicitly added to
           the list of refs to be displayed.

       notes.rewrite.<command>
           When rewriting commits with <command> (currently aammeenndd or rreebbaassee) and this variable is set to ttrruuee, Git
           automatically copies your notes from the original to the rewritten commit. Defaults to ttrruuee, but see
           "notes.rewriteRef" below.

       notes.rewriteMode
           When copying notes during a rewrite (see the "notes.rewrite.<command>" option), determines what to do if the
           target commit already has a note. Must be one of oovveerrwwrriittee, ccoonnccaatteennaattee, ccaatt__ssoorrtt__uunniiqq, or iiggnnoorree. Defaults
           to ccoonnccaatteennaattee.

           This setting can be overridden with the GGIITT__NNOOTTEESS__RREEWWRRIITTEE__MMOODDEE environment variable.

       notes.rewriteRef
           When copying notes during a rewrite, specifies the (fully qualified) ref whose notes should be copied. The
           ref may be a glob, in which case notes in all matching refs will be copied. You may also specify this
           configuration several times.

           Does not have a default value; you must configure this variable to enable note rewriting. Set it to
           rreeffss//nnootteess//ccoommmmiittss to enable rewriting for the default commit notes.

           This setting can be overridden with the GGIITT__NNOOTTEESS__RREEWWRRIITTEE__RREEFF environment variable, which must be a colon
           separated list of refs or globs.

       pack.window
           The size of the window used by ggiitt--ppaacckk--oobbjjeeccttss(1) when no window size is given on the command line.
           Defaults to 10.

       pack.depth
           The maximum delta depth used by ggiitt--ppaacckk--oobbjjeeccttss(1) when no maximum depth is given on the command line.
           Defaults to 50. Maximum value is 4095.

       pack.windowMemory
           The maximum size of memory that is consumed by each thread in ggiitt--ppaacckk--oobbjjeeccttss(1) for pack window memory
           when no limit is given on the command line. The value can be suffixed with "k", "m", or "g". When left
           unconfigured (or set explicitly to 0), there will be no limit.

       pack.compression
           An integer -1..9, indicating the compression level for objects in a pack file. -1 is the zlib default. 0
           means no compression, and 1..9 are various speed/size tradeoffs, 9 being slowest. If not set, defaults to
           core.compression. If that is not set, defaults to -1, the zlib default, which is "a default compromise
           between speed and compression (currently equivalent to level 6)."

           Note that changing the compression level will not automatically recompress all existing objects. You can
           force recompression by passing the -F option to ggiitt--rreeppaacckk(1).

       pack.island
           An extended regular expression configuring a set of delta islands. See "DELTA ISLANDS" in ggiitt--ppaacckk--
           oobbjjeeccttss(1) for details.

       pack.islandCore
           Specify an island name which gets to have its objects be packed first. This creates a kind of pseudo-pack at
           the front of one pack, so that the objects from the specified island are hopefully faster to copy into any
           pack that should be served to a user requesting these objects. In practice this means that the island
           specified should likely correspond to what is the most commonly cloned in the repo. See also "DELTA ISLANDS"
           in ggiitt--ppaacckk--oobbjjeeccttss(1).

       pack.deltaCacheSize
           The maximum memory in bytes used for caching deltas in ggiitt--ppaacckk--oobbjjeeccttss(1) before writing them out to a
           pack. This cache is used to speed up the writing object phase by not having to recompute the final delta
           result once the best match for all objects is found. Repacking large repositories on machines which are
           tight with memory might be badly impacted by this though, especially if this cache pushes the system into
           swapping. A value of 0 means no limit. The smallest size of 1 byte may be used to virtually disable this
           cache. Defaults to 256 MiB.

       pack.deltaCacheLimit
           The maximum size of a delta, that is cached in ggiitt--ppaacckk--oobbjjeeccttss(1). This cache is used to speed up the
           writing object phase by not having to recompute the final delta result once the best match for all objects
           is found. Defaults to 1000. Maximum value is 65535.

       pack.threads
           Specifies the number of threads to spawn when searching for best delta matches. This requires that ggiitt--ppaacckk--
           oobbjjeeccttss(1) be compiled with pthreads otherwise this option is ignored with a warning. This is meant to
           reduce packing time on multiprocessor machines. The required amount of memory for the delta search window is
           however multiplied by the number of threads. Specifying 0 will cause Git to auto-detect the number of CPU’s
           and set the number of threads accordingly.

       pack.indexVersion
           Specify the default pack index version. Valid values are 1 for legacy pack index used by Git versions prior
           to 1.5.2, and 2 for the new pack index with capabilities for packs larger than 4 GB as well as proper
           protection against the repacking of corrupted packs. Version 2 is the default. Note that version 2 is
           enforced and this config option ignored whenever the corresponding pack is larger than 2 GB.

           If you have an old Git that does not understand the version 2 **..iiddxx file, cloning or fetching over a non
           native protocol (e.g. "http") that will copy both **..ppaacckk file and corresponding **..iiddxx file from the other
           side may give you a repository that cannot be accessed with your older version of Git. If the **..ppaacckk file is
           smaller than 2 GB, however, you can use ggiitt--iinnddeexx--ppaacckk(1) on the *.pack file to regenerate the **..iiddxx file.

       pack.packSizeLimit
           The maximum size of a pack. This setting only affects packing to a file when repacking, i.e. the git://
           protocol is unaffected. It can be overridden by the ----mmaaxx--ppaacckk--ssiizzee option of ggiitt--rreeppaacckk(1). Reaching this
           limit results in the creation of multiple packfiles; which in turn prevents bitmaps from being created. The
           minimum size allowed is limited to 1 MiB. The default is unlimited. Common unit suffixes of _k, _m, or _g are
           supported.

       pack.useBitmaps
           When true, git will use pack bitmaps (if available) when packing to stdout (e.g., during the server side of
           a fetch). Defaults to true. You should not generally need to turn this off unless you are debugging pack
           bitmaps.

       pack.useSparse
           When true, git will default to using the _-_-_s_p_a_r_s_e option in _g_i_t _p_a_c_k_-_o_b_j_e_c_t_s when the _-_-_r_e_v_s option is
           present. This algorithm only walks trees that appear in paths that introduce new objects. This can have
           significant performance benefits when computing a pack to send a small change. However, it is possible that
           extra objects are added to the pack-file if the included commits contain certain types of direct renames.
           Default is ffaallssee unless ffeeaattuurree..eexxppeerriimmeennttaall is enabled.

       pack.writeBitmaps (deprecated)
           This is a deprecated synonym for rreeppaacckk..wwrriitteeBBiittmmaappss.

       pack.writeBitmapHashCache
           When true, git will include a "hash cache" section in the bitmap index (if one is written). This cache can
           be used to feed git’s delta heuristics, potentially leading to better deltas between bitmapped and
           non-bitmapped objects (e.g., when serving a fetch between an older, bitmapped pack and objects that have
           been pushed since the last gc). The downside is that it consumes 4 bytes per object of disk space. Defaults
           to true.

       pager.<cmd>
           If the value is boolean, turns on or off pagination of the output of a particular Git subcommand when
           writing to a tty. Otherwise, turns on pagination for the subcommand using the pager specified by the value
           of ppaaggeerr..<<ccmmdd>>. If ----ppaaggiinnaattee or ----nnoo--ppaaggeerr is specified on the command line, it takes precedence over this
           option. To disable pagination for all commands, set ccoorree..ppaaggeerr or GGIITT__PPAAGGEERR to ccaatt.

       pretty.<name>
           Alias for a --pretty= format string, as specified in ggiitt--lloogg(1). Any aliases defined here can be used just
           as the built-in pretty formats could. For example, running ggiitt ccoonnffiigg pprreettttyy..cchhaannggeelloogg ""ffoorrmmaatt::** %%HH %%ss""
           would cause the invocation ggiitt lloogg ----pprreettttyy==cchhaannggeelloogg to be equivalent to running ggiitt lloogg ""----pprreettttyy==ffoorrmmaatt::**
           %%HH %%ss"". Note that an alias with the same name as a built-in format will be silently ignored.

       protocol.allow
           If set, provide a user defined default policy for all protocols which don’t explicitly have a policy
           (pprroottooccooll..<<nnaammee>>..aallllooww). By default, if unset, known-safe protocols (http, https, git, ssh, file) have a
           default policy of aallwwaayyss, known-dangerous protocols (ext) have a default policy of nneevveerr, and all other
           protocols have a default policy of uusseerr. Supported policies:

           •   aallwwaayyss - protocol is always able to be used.

           •   nneevveerr - protocol is never able to be used.

           •   uusseerr - protocol is only able to be used when GGIITT__PPRROOTTOOCCOOLL__FFRROOMM__UUSSEERR is either unset or has a value of 1.
               This policy should be used when you want a protocol to be directly usable by the user but don’t want it
               used by commands which execute clone/fetch/push commands without user input, e.g. recursive submodule
               initialization.

       protocol.<name>.allow
           Set a policy to be used by protocol <<nnaammee>> with clone/fetch/push commands. See pprroottooccooll..aallllooww above for the
           available policies.

           The protocol names currently used by git are:

           •   ffiillee: any local file-based path (including ffiillee:://// URLs, or local paths)

           •   ggiitt: the anonymous git protocol over a direct TCP connection (or proxy, if configured)

           •   sssshh: git over ssh (including hhoosstt::ppaatthh syntax, sssshh::////, etc).

           •   hhttttpp: git over http, both "smart http" and "dumb http". Note that this does _n_o_t include hhttttppss; if you
               want to configure both, you must do so individually.

           •   any external helpers are named by their protocol (e.g., use hhgg to allow the ggiitt--rreemmoottee--hhgg helper)

       protocol.version
           Experimental. If set, clients will attempt to communicate with a server using the specified protocol
           version. If unset, no attempt will be made by the client to communicate using a particular protocol version,
           this results in protocol version 0 being used. Supported versions:

           •   00 - the original wire protocol.

           •   11 - the original wire protocol with the addition of a version string in the initial response from the
               server.

           •   22 - wwiirree pprroottooccooll vveerrssiioonn 22[2].

       pull.ff
           By default, Git does not create an extra merge commit when merging a commit that is a descendant of the
           current commit. Instead, the tip of the current branch is fast-forwarded. When set to ffaallssee, this variable
           tells Git to create an extra merge commit in such a case (equivalent to giving the ----nnoo--ffff option from the
           command line). When set to oonnllyy, only such fast-forward merges are allowed (equivalent to giving the
           ----ffff--oonnllyy option from the command line). This setting overrides mmeerrggee..ffff when pulling.

       pull.rebase
           When true, rebase branches on top of the fetched branch, instead of merging the default branch from the
           default remote when "git pull" is run. See "branch.<name>.rebase" for setting this on a per-branch basis.

           When mmeerrggeess, pass the ----rreebbaassee--mmeerrggeess option to _g_i_t _r_e_b_a_s_e so that the local merge commits are included in
           the rebase (see ggiitt--rreebbaassee(1) for details).

           When pprreesseerrvvee (deprecated in favor of mmeerrggeess), also pass ----pprreesseerrvvee--mmeerrggeess along to _g_i_t _r_e_b_a_s_e so that
           locally committed merge commits will not be flattened by running _g_i_t _p_u_l_l.

           When the value is iinntteerraaccttiivvee, the rebase is run in interactive mode.

           NNOOTTEE: this is a possibly dangerous operation; do nnoott use it unless you understand the implications (see ggiitt--
           rreebbaassee(1) for details).

       pull.octopus
           The default merge strategy to use when pulling multiple branches at once.

       pull.twohead
           The default merge strategy to use when pulling a single branch.

       push.default
           Defines the action ggiitt ppuusshh should take if no refspec is explicitly given. Different values are well-suited
           for specific workflows; for instance, in a purely central workflow (i.e. the fetch source is equal to the
           push destination), uuppssttrreeaamm is probably what you want. Possible values are:

           •   nnootthhiinngg - do not push anything (error out) unless a refspec is explicitly given. This is primarily meant
               for people who want to avoid mistakes by always being explicit.

           •   ccuurrrreenntt - push the current branch to update a branch with the same name on the receiving end. Works in
               both central and non-central workflows.

           •   uuppssttrreeaamm - push the current branch back to the branch whose changes are usually integrated into the
               current branch (which is called @@{{uuppssttrreeaamm}}). This mode only makes sense if you are pushing to the same
               repository you would normally pull from (i.e. central workflow).

           •   ttrraacckkiinngg - This is a deprecated synonym for uuppssttrreeaamm.

           •   ssiimmppllee - in centralized workflow, work like uuppssttrreeaamm with an added safety to refuse to push if the
               upstream branch’s name is different from the local one.

               When pushing to a remote that is different from the remote you normally pull from, work as ccuurrrreenntt. This
               is the safest option and is suited for beginners.

               This mode has become the default in Git 2.0.

           •   mmaattcchhiinngg - push all branches having the same name on both ends. This makes the repository you are
               pushing to remember the set of branches that will be pushed out (e.g. if you always push _m_a_i_n_t and
               _m_a_s_t_e_r there and no other branches, the repository you push to will have these two branches, and your
               local _m_a_i_n_t and _m_a_s_t_e_r will be pushed there).

               To use this mode effectively, you have to make sure _a_l_l the branches you would push out are ready to be
               pushed out before running _g_i_t _p_u_s_h, as the whole point of this mode is to allow you to push all of the
               branches in one go. If you usually finish work on only one branch and push out the result, while other
               branches are unfinished, this mode is not for you. Also this mode is not suitable for pushing into a
               shared central repository, as other people may add new branches there, or update the tip of existing
               branches outside your control.

               This used to be the default, but not since Git 2.0 (ssiimmppllee is the new default).

       push.followTags
           If set to true enable ----ffoollllooww--ttaaggss option by default. You may override this configuration at time of push
           by specifying ----nnoo--ffoollllooww--ttaaggss.

       push.gpgSign
           May be set to a boolean value, or the string _i_f_-_a_s_k_e_d. A true value causes all pushes to be GPG signed, as
           if ----ssiiggnneedd is passed to ggiitt--ppuusshh(1). The string _i_f_-_a_s_k_e_d causes pushes to be signed if the server supports
           it, as if ----ssiiggnneedd==iiff--aasskkeedd is passed to _g_i_t _p_u_s_h. A false value may override a value from a lower-priority
           config file. An explicit command-line flag always overrides this config option.

       push.pushOption
           When no ----ppuusshh--ooppttiioonn==<<ooppttiioonn>> argument is given from the command line, ggiitt ppuusshh behaves as if each <value>
           of this variable is given as ----ppuusshh--ooppttiioonn==<<vvaalluuee>>.

           This is a multi-valued variable, and an empty value can be used in a higher priority configuration file
           (e.g.  ..ggiitt//ccoonnffiigg in a repository) to clear the values inherited from a lower priority configuration files
           (e.g.  $$HHOOMMEE//..ggiittccoonnffiigg).

           Example:

           /etc/gitconfig push.pushoption = a push.pushoption = b

           ~/.gitconfig push.pushoption = c

           repo/.git/config push.pushoption = push.pushoption = b

           This will result in only b (a and c are cleared).

       push.recurseSubmodules
           Make sure all submodule commits used by the revisions to be pushed are available on a remote-tracking
           branch. If the value is _c_h_e_c_k then Git will verify that all submodule commits that changed in the revisions
           to be pushed are available on at least one remote of the submodule. If any commits are missing, the push
           will be aborted and exit with non-zero status. If the value is _o_n_-_d_e_m_a_n_d then all submodules that changed in
           the revisions to be pushed will be pushed. If on-demand was not able to push all necessary revisions it will
           also be aborted and exit with non-zero status. If the value is _n_o then default behavior of ignoring
           submodules when pushing is retained. You may override this configuration at time of push by specifying
           _-_-_r_e_c_u_r_s_e_-_s_u_b_m_o_d_u_l_e_s_=_c_h_e_c_k_|_o_n_-_d_e_m_a_n_d_|_n_o.

       rebase.useBuiltin
           Unused configuration variable. Used in Git versions 2.20 and 2.21 as an escape hatch to enable the legacy
           shellscript implementation of rebase. Now the built-in rewrite of it in C is always used. Setting this will
           emit a warning, to alert any remaining users that setting this now does nothing.

       rebase.stat
           Whether to show a diffstat of what changed upstream since the last rebase. False by default.

       rebase.autoSquash
           If set to true enable ----aauuttoossqquuaasshh option by default.

       rebase.autoStash
           When set to true, automatically create a temporary stash entry before the operation begins, and apply it
           after the operation ends. This means that you can run rebase on a dirty worktree. However, use with care:
           the final stash application after a successful rebase might result in non-trivial conflicts. This option can
           be overridden by the ----nnoo--aauuttoossttaasshh and ----aauuttoossttaasshh options of ggiitt--rreebbaassee(1). Defaults to false.

       rebase.missingCommitsCheck
           If set to "warn", git rebase -i will print a warning if some commits are removed (e.g. a line was deleted),
           however the rebase will still proceed. If set to "error", it will print the previous warning and stop the
           rebase, _g_i_t _r_e_b_a_s_e _-_-_e_d_i_t_-_t_o_d_o can then be used to correct the error. If set to "ignore", no checking is
           done. To drop a commit without warning or error, use the ddrroopp command in the todo list. Defaults to
           "ignore".

       rebase.instructionFormat
           A format string, as specified in ggiitt--lloogg(1), to be used for the todo list during an interactive rebase. The
           format will automatically have the long commit hash prepended to the format.

       rebase.abbreviateCommands
           If set to true, ggiitt rreebbaassee will use abbreviated command names in the todo list resulting in something like
           this:

                       p deadbee The oneline of the commit
                       p fa1afe1 The oneline of the next commit
                       ...

           instead of:

                       pick deadbee The oneline of the commit
                       pick fa1afe1 The oneline of the next commit
                       ...

           Defaults to false.

       rebase.rescheduleFailedExec
           Automatically reschedule eexxeecc commands that failed. This only makes sense in interactive mode (or when an
           ----eexxeecc option was provided). This is the same as specifying the ----rreesscchheedduullee--ffaaiilleedd--eexxeecc option.

       receive.advertiseAtomic
           By default, git-receive-pack will advertise the atomic push capability to its clients. If you don’t want to
           advertise this capability, set this variable to false.

       receive.advertisePushOptions
           When set to true, git-receive-pack will advertise the push options capability to its clients. False by
           default.

       receive.autogc
           By default, git-receive-pack will run "git-gc --auto" after receiving data from git-push and updating refs.
           You can stop it by setting this variable to false.

       receive.certNonceSeed
           By setting this variable to a string, ggiitt rreecceeiivvee--ppaacckk will accept a ggiitt ppuusshh ----ssiiggnneedd and verifies it by
           using a "nonce" protected by HMAC using this string as a secret key.

       receive.certNonceSlop
           When a ggiitt ppuusshh ----ssiiggnneedd sent a push certificate with a "nonce" that was issued by a receive-pack serving
           the same repository within this many seconds, export the "nonce" found in the certificate to
           GGIITT__PPUUSSHH__CCEERRTT__NNOONNCCEE to the hooks (instead of what the receive-pack asked the sending side to include). This
           may allow writing checks in pprree--rreecceeiivvee and ppoosstt--rreecceeiivvee a bit easier. Instead of checking
           GGIITT__PPUUSSHH__CCEERRTT__NNOONNCCEE__SSLLOOPP environment variable that records by how many seconds the nonce is stale to decide
           if they want to accept the certificate, they only can check GGIITT__PPUUSSHH__CCEERRTT__NNOONNCCEE__SSTTAATTUUSS is OOKK.

       receive.fsckObjects
           If it is set to true, git-receive-pack will check all received objects. See ttrraannssffeerr..ffsscckkOObbjjeeccttss for what’s
           checked. Defaults to false. If not set, the value of ttrraannssffeerr..ffsscckkOObbjjeeccttss is used instead.

       receive.fsck.<msg-id>
           Acts like ffsscckk..<<mmssgg--iidd>>, but is used by ggiitt--rreecceeiivvee--ppaacckk(1) instead of ggiitt--ffsscckk(1). See the ffsscckk..<<mmssgg--iidd>>
           documentation for details.

       receive.fsck.skipList
           Acts like ffsscckk..sskkiippLLiisstt, but is used by ggiitt--rreecceeiivvee--ppaacckk(1) instead of ggiitt--ffsscckk(1). See the ffsscckk..sskkiippLLiisstt
           documentation for details.

       receive.keepAlive
           After receiving the pack from the client, rreecceeiivvee--ppaacckk may produce no output (if ----qquuiieett was specified)
           while processing the pack, causing some networks to drop the TCP connection. With this option set, if
           rreecceeiivvee--ppaacckk does not transmit any data in this phase for rreecceeiivvee..kkeeeeppAAlliivvee seconds, it will send a short
           keepalive packet. The default is 5 seconds; set to 0 to disable keepalives entirely.

       receive.unpackLimit
           If the number of objects received in a push is below this limit then the objects will be unpacked into loose
           object files. However if the number of received objects equals or exceeds this limit then the received pack
           will be stored as a pack, after adding any missing delta bases. Storing the pack from a push can make the
           push operation complete faster, especially on slow filesystems. If not set, the value of
           ttrraannssffeerr..uunnppaacckkLLiimmiitt is used instead.

       receive.maxInputSize
           If the size of the incoming pack stream is larger than this limit, then git-receive-pack will error out,
           instead of accepting the pack file. If not set or set to 0, then the size is unlimited.

       receive.denyDeletes
           If set to true, git-receive-pack will deny a ref update that deletes the ref. Use this to prevent such a ref
           deletion via a push.

       receive.denyDeleteCurrent
           If set to true, git-receive-pack will deny a ref update that deletes the currently checked out branch of a
           non-bare repository.

       receive.denyCurrentBranch
           If set to true or "refuse", git-receive-pack will deny a ref update to the currently checked out branch of a
           non-bare repository. Such a push is potentially dangerous because it brings the HEAD out of sync with the
           index and working tree. If set to "warn", print a warning of such a push to stderr, but allow the push to
           proceed. If set to false or "ignore", allow such pushes with no message. Defaults to "refuse".

           Another option is "updateInstead" which will update the working tree if pushing into the current branch.
           This option is intended for synchronizing working directories when one side is not easily accessible via
           interactive ssh (e.g. a live web site, hence the requirement that the working directory be clean). This mode
           also comes in handy when developing inside a VM to test and fix code on different Operating Systems.

           By default, "updateInstead" will refuse the push if the working tree or the index have any difference from
           the HEAD, but the ppuusshh--ttoo--cchheecckkoouutt hook can be used to customize this. See ggiitthhooookkss(5).

       receive.denyNonFastForwards
           If set to true, git-receive-pack will deny a ref update which is not a fast-forward. Use this to prevent
           such an update via a push, even if that push is forced. This configuration variable is set when initializing
           a shared repository.

       receive.hideRefs
           This variable is the same as ttrraannssffeerr..hhiiddeeRReeffss, but applies only to rreecceeiivvee--ppaacckk (and so affects pushes, but
           not fetches). An attempt to update or delete a hidden ref by ggiitt ppuusshh is rejected.

       receive.updateServerInfo
           If set to true, git-receive-pack will run git-update-server-info after receiving data from git-push and
           updating refs.

       receive.shallowUpdate
           If set to true, .git/shallow can be updated when new refs require new shallow roots. Otherwise those refs
           are rejected.

       remote.pushDefault
           The remote to push to by default. Overrides bbrraanncchh..<<nnaammee>>..rreemmoottee for all branches, and is overridden by
           bbrraanncchh..<<nnaammee>>..ppuusshhRReemmoottee for specific branches.

       remote.<name>.url
           The URL of a remote repository. See ggiitt--ffeettcchh(1) or ggiitt--ppuusshh(1).

       remote.<name>.pushurl
           The push URL of a remote repository. See ggiitt--ppuusshh(1).

       remote.<name>.proxy
           For remotes that require curl (http, https and ftp), the URL to the proxy to use for that remote. Set to the
           empty string to disable proxying for that remote.

       remote.<name>.proxyAuthMethod
           For remotes that require curl (http, https and ftp), the method to use for authenticating against the proxy
           in use (probably set in rreemmoottee..<<nnaammee>>..pprrooxxyy). See hhttttpp..pprrooxxyyAAuutthhMMeetthhoodd.

       remote.<name>.fetch
           The default set of "refspec" for ggiitt--ffeettcchh(1). See ggiitt--ffeettcchh(1).

       remote.<name>.push
           The default set of "refspec" for ggiitt--ppuusshh(1). See ggiitt--ppuusshh(1).

       remote.<name>.mirror
           If true, pushing to this remote will automatically behave as if the ----mmiirrrroorr option was given on the command
           line.

       remote.<name>.skipDefaultUpdate
           If true, this remote will be skipped by default when updating using ggiitt--ffeettcchh(1) or the uuppddaattee subcommand of
           ggiitt--rreemmoottee(1).

       remote.<name>.skipFetchAll
           If true, this remote will be skipped by default when updating using ggiitt--ffeettcchh(1) or the uuppddaattee subcommand of
           ggiitt--rreemmoottee(1).

       remote.<name>.receivepack
           The default program to execute on the remote side when pushing. See option --receive-pack of ggiitt--ppuusshh(1).

       remote.<name>.uploadpack
           The default program to execute on the remote side when fetching. See option --upload-pack of ggiitt--ffeettcchh--
           ppaacckk(1).

       remote.<name>.tagOpt
           Setting this value to --no-tags disables automatic tag following when fetching from remote <name>. Setting
           it to --tags will fetch every tag from remote <name>, even if they are not reachable from remote branch
           heads. Passing these flags directly to ggiitt--ffeettcchh(1) can override this setting. See options --tags and
           --no-tags of ggiitt--ffeettcchh(1).

       remote.<name>.vcs
           Setting this to a value <vcs> will cause Git to interact with the remote with the git-remote-<vcs> helper.

       remote.<name>.prune
           When set to true, fetching from this remote by default will also remove any remote-tracking references that
           no longer exist on the remote (as if the ----pprruunnee option was given on the command line). Overrides
           ffeettcchh..pprruunnee settings, if any.

       remote.<name>.pruneTags
           When set to true, fetching from this remote by default will also remove any local tags that no longer exist
           on the remote if pruning is activated in general via rreemmoottee..<<nnaammee>>..pprruunnee, ffeettcchh..pprruunnee or ----pprruunnee. Overrides
           ffeettcchh..pprruunneeTTaaggss settings, if any.

           See also rreemmoottee..<<nnaammee>>..pprruunnee and the PRUNING section of ggiitt--ffeettcchh(1).

       remote.<name>.promisor
           When set to true, this remote will be used to fetch promisor objects.

       remote.<name>.partialclonefilter
           The filter that will be applied when fetching from this promisor remote.

       remotes.<group>
           The list of remotes which are fetched by "git remote update <group>". See ggiitt--rreemmoottee(1).

       repack.useDeltaBaseOffset
           By default, ggiitt--rreeppaacckk(1) creates packs that use delta-base offset. If you need to share your repository
           with Git older than version 1.4.4, either directly or via a dumb protocol such as http, then you need to set
           this option to "false" and repack. Access from old Git versions over the native protocol are unaffected by
           this option.

       repack.packKeptObjects
           If set to true, makes ggiitt rreeppaacckk act as if ----ppaacckk--kkeepptt--oobbjjeeccttss was passed. See ggiitt--rreeppaacckk(1) for details.
           Defaults to ffaallssee normally, but ttrruuee if a bitmap index is being written (either via ----wwrriittee--bbiittmmaapp--iinnddeexx or
           rreeppaacckk..wwrriitteeBBiittmmaappss).

       repack.useDeltaIslands
           If set to true, makes ggiitt rreeppaacckk act as if ----ddeellttaa--iissllaannddss was passed. Defaults to ffaallssee.

       repack.writeBitmaps
           When true, git will write a bitmap index when packing all objects to disk (e.g., when ggiitt rreeppaacckk --aa is run).
           This index can speed up the "counting objects" phase of subsequent packs created for clones and fetches, at
           the cost of some disk space and extra time spent on the initial repack. This has no effect if multiple
           packfiles are created. Defaults to true on bare repos, false otherwise.

       rerere.autoUpdate
           When set to true, ggiitt--rreerreerree updates the index with the resulting contents after it cleanly resolves
           conflicts using previously recorded resolution. Defaults to false.

       rerere.enabled
           Activate recording of resolved conflicts, so that identical conflict hunks can be resolved automatically,
           should they be encountered again. By default, ggiitt--rreerreerree(1) is enabled if there is an rrrr--ccaacchhee directory
           under the $$GGIITT__DDIIRR, e.g. if "rerere" was previously used in the repository.

       reset.quiet
           When set to true, _g_i_t _r_e_s_e_t will default to the _-_-_q_u_i_e_t option.

       sendemail.identity
           A configuration identity. When given, causes values in the _s_e_n_d_e_m_a_i_l_._<_i_d_e_n_t_i_t_y_> subsection to take
           precedence over values in the _s_e_n_d_e_m_a_i_l section. The default identity is the value of sseennddeemmaaiill..iiddeennttiittyy.

       sendemail.smtpEncryption
           See ggiitt--sseenndd--eemmaaiill(1) for description. Note that this setting is not subject to the _i_d_e_n_t_i_t_y mechanism.

       sendemail.smtpssl (deprecated)
           Deprecated alias for _s_e_n_d_e_m_a_i_l_._s_m_t_p_E_n_c_r_y_p_t_i_o_n _= _s_s_l.

       sendemail.smtpsslcertpath
           Path to ca-certificates (either a directory or a single file). Set it to an empty string to disable
           certificate verification.

       sendemail.<identity>.*
           Identity-specific versions of the _s_e_n_d_e_m_a_i_l_._*  parameters found below, taking precedence over those when
           this identity is selected, through either the command-line or sseennddeemmaaiill..iiddeennttiittyy.

       sendemail.aliasesFile, sendemail.aliasFileType, sendemail.annotate, sendemail.bcc, sendemail.cc,
       sendemail.ccCmd, sendemail.chainReplyTo, sendemail.confirm, sendemail.envelopeSender, sendemail.from,
       sendemail.multiEdit, sendemail.signedoffbycc, sendemail.smtpPass, sendemail.suppresscc, sendemail.suppressFrom,
       sendemail.to, sendemail.tocmd, sendemail.smtpDomain, sendemail.smtpServer, sendemail.smtpServerPort,
       sendemail.smtpServerOption, sendemail.smtpUser, sendemail.thread, sendemail.transferEncoding,
       sendemail.validate, sendemail.xmailer
           See ggiitt--sseenndd--eemmaaiill(1) for description.

       sendemail.signedoffcc (deprecated)
           Deprecated alias for sseennddeemmaaiill..ssiiggnneeddooffffbbyycccc.

       sendemail.smtpBatchSize
           Number of messages to be sent per connection, after that a relogin will happen. If the value is 0 or
           undefined, send all messages in one connection. See also the ----bbaattcchh--ssiizzee option of ggiitt--sseenndd--eemmaaiill(1).

       sendemail.smtpReloginDelay
           Seconds wait before reconnecting to smtp server. See also the ----rreellooggiinn--ddeellaayy option of ggiitt--sseenndd--eemmaaiill(1).

       sequence.editor
           Text editor used by ggiitt rreebbaassee --ii for editing the rebase instruction file. The value is meant to be
           interpreted by the shell when it is used. It can be overridden by the GGIITT__SSEEQQUUEENNCCEE__EEDDIITTOORR environment
           variable. When not configured the default commit message editor is used instead.

       showBranch.default
           The default set of branches for ggiitt--sshhooww--bbrraanncchh(1). See ggiitt--sshhooww--bbrraanncchh(1).

       splitIndex.maxPercentChange
           When the split index feature is used, this specifies the percent of entries the split index can contain
           compared to the total number of entries in both the split index and the shared index before a new shared
           index is written. The value should be between 0 and 100. If the value is 0 then a new shared index is always
           written, if it is 100 a new shared index is never written. By default the value is 20, so a new shared index
           is written if the number of entries in the split index would be greater than 20 percent of the total number
           of entries. See ggiitt--uuppddaattee--iinnddeexx(1).

       splitIndex.sharedIndexExpire
           When the split index feature is used, shared index files that were not modified since the time this variable
           specifies will be removed when a new shared index file is created. The value "now" expires all entries
           immediately, and "never" suppresses expiration altogether. The default value is "2.weeks.ago". Note that a
           shared index file is considered modified (for the purpose of expiration) each time a new split-index file is
           either created based on it or read from it. See ggiitt--uuppddaattee--iinnddeexx(1).

       ssh.variant
           By default, Git determines the command line arguments to use based on the basename of the configured SSH
           command (configured using the environment variable GGIITT__SSSSHH or GGIITT__SSSSHH__CCOOMMMMAANNDD or the config setting
           ccoorree..sssshhCCoommmmaanndd). If the basename is unrecognized, Git will attempt to detect support of OpenSSH options by
           first invoking the configured SSH command with the --GG (print configuration) option and will subsequently use
           OpenSSH options (if that is successful) or no options besides the host and remote command (if it fails).

           The config variable sssshh..vvaarriiaanntt can be set to override this detection. Valid values are sssshh (to use OpenSSH
           options), pplliinnkk, ppuuttttyy, ttoorrttooiisseepplliinnkk, ssiimmppllee (no options except the host and remote command). The default
           auto-detection can be explicitly requested using the value aauuttoo. Any other value is treated as sssshh. This
           setting can also be overridden via the environment variable GGIITT__SSSSHH__VVAARRIIAANNTT.

           The current command-line parameters used for each variant are as follows:

           •   sssshh - [-p port] [-4] [-6] [-o option] [username@]host command

           •   ssiimmppllee - [username@]host command

           •   pplliinnkk or ppuuttttyy - [-P port] [-4] [-6] [username@]host command

           •   ttoorrttooiisseepplliinnkk - [-P port] [-4] [-6] -batch [username@]host command

           Except for the ssiimmppllee variant, command-line parameters are likely to change as git gains new features.

       status.relativePaths
           By default, ggiitt--ssttaattuuss(1) shows paths relative to the current directory. Setting this variable to ffaallssee
           shows paths relative to the repository root (this was the default for Git prior to v1.5.4).

       status.short
           Set to true to enable --short by default in ggiitt--ssttaattuuss(1). The option --no-short takes precedence over this
           variable.

       status.branch
           Set to true to enable --branch by default in ggiitt--ssttaattuuss(1). The option --no-branch takes precedence over
           this variable.

       status.aheadBehind
           Set to true to enable ----aahheeaadd--bbeehhiinndd and false to enable ----nnoo--aahheeaadd--bbeehhiinndd by default in ggiitt--ssttaattuuss(1) for
           non-porcelain status formats. Defaults to true.

       status.displayCommentPrefix
           If set to true, ggiitt--ssttaattuuss(1) will insert a comment prefix before each output line (starting with
           ccoorree..ccoommmmeennttCChhaarr, i.e.  ## by default). This was the behavior of ggiitt--ssttaattuuss(1) in Git 1.8.4 and previous.
           Defaults to false.

       status.renameLimit
           The number of files to consider when performing rename detection in ggiitt--ssttaattuuss(1) and ggiitt--ccoommmmiitt(1).
           Defaults to the value of diff.renameLimit.

       status.renames
           Whether and how Git detects renames in ggiitt--ssttaattuuss(1) and ggiitt--ccoommmmiitt(1) . If set to "false", rename detection
           is disabled. If set to "true", basic rename detection is enabled. If set to "copies" or "copy", Git will
           detect copies, as well. Defaults to the value of diff.renames.

       status.showStash
           If set to true, ggiitt--ssttaattuuss(1) will display the number of entries currently stashed away. Defaults to false.

       status.showUntrackedFiles
           By default, ggiitt--ssttaattuuss(1) and ggiitt--ccoommmmiitt(1) show files which are not currently tracked by Git. Directories
           which contain only untracked files, are shown with the directory name only. Showing untracked files means
           that Git needs to lstat() all the files in the whole repository, which might be slow on some systems. So,
           this variable controls how the commands displays the untracked files. Possible values are:

           •   nnoo - Show no untracked files.

           •   nnoorrmmaall - Show untracked files and directories.

           •   aallll - Show also individual files in untracked directories.

           If this variable is not specified, it defaults to _n_o_r_m_a_l. This variable can be overridden with the
           -u|--untracked-files option of ggiitt--ssttaattuuss(1) and ggiitt--ccoommmmiitt(1).

       status.submoduleSummary
           Defaults to false. If this is set to a non zero number or true (identical to -1 or an unlimited number), the
           submodule summary will be enabled and a summary of commits for modified submodules will be shown (see
           --summary-limit option of ggiitt--ssuubbmmoodduullee(1)). Please note that the summary output command will be suppressed
           for all submodules when ddiiffff..iiggnnoorreeSSuubbmmoodduulleess is set to _a_l_l or only for those submodules where
           ssuubbmmoodduullee..<<nnaammee>>..iiggnnoorree==aallll. The only exception to that rule is that status and commit will show staged
           submodule changes. To also view the summary for ignored submodules you can either use the
           --ignore-submodules=dirty command-line option or the _g_i_t _s_u_b_m_o_d_u_l_e _s_u_m_m_a_r_y command, which shows a similar
           output but does not honor these settings.

       stash.useBuiltin
           Set to ffaallssee to use the legacy shell script implementation of ggiitt--ssttaasshh(1). Is ttrruuee by default, which means
           use the built-in rewrite of it in C.

           The C rewrite is first included with Git version 2.22 (and Git for Windows version 2.19). This option serves
           as an escape hatch to re-enable the legacy version in case any bugs are found in the rewrite. This option
           and the shell script version of ggiitt--ssttaasshh(1) will be removed in some future release.

           If you find some reason to set this option to ffaallssee, other than one-off testing, you should report the
           behavior difference as a bug in Git (see hhttttppss::////ggiitt--ssccmm..ccoomm//ccoommmmuunniittyy for details).

       stash.showPatch
           If this is set to true, the ggiitt ssttaasshh sshhooww command without an option will show the stash entry in patch
           form. Defaults to false. See description of _s_h_o_w command in ggiitt--ssttaasshh(1).

       stash.showStat
           If this is set to true, the ggiitt ssttaasshh sshhooww command without an option will show diffstat of the stash entry.
           Defaults to true. See description of _s_h_o_w command in ggiitt--ssttaasshh(1).

       submodule.<name>.url
           The URL for a submodule. This variable is copied from the .gitmodules file to the git config via _g_i_t
           _s_u_b_m_o_d_u_l_e _i_n_i_t. The user can change the configured URL before obtaining the submodule via _g_i_t _s_u_b_m_o_d_u_l_e
           _u_p_d_a_t_e. If neither submodule.<name>.active or submodule.active are set, the presence of this variable is
           used as a fallback to indicate whether the submodule is of interest to git commands. See ggiitt--ssuubbmmoodduullee(1)
           and ggiittmmoodduulleess(5) for details.

       submodule.<name>.update
           The method by which a submodule is updated by _g_i_t _s_u_b_m_o_d_u_l_e _u_p_d_a_t_e, which is the only affected command,
           others such as _g_i_t _c_h_e_c_k_o_u_t _-_-_r_e_c_u_r_s_e_-_s_u_b_m_o_d_u_l_e_s are unaffected. It exists for historical reasons, when _g_i_t
           _s_u_b_m_o_d_u_l_e was the only command to interact with submodules; settings like ssuubbmmoodduullee..aaccttiivvee and ppuullll..rreebbaassee
           are more specific. It is populated by ggiitt ssuubbmmoodduullee iinniitt from the ggiittmmoodduulleess(5) file. See description of
           _u_p_d_a_t_e command in ggiitt--ssuubbmmoodduullee(1).

       submodule.<name>.branch
           The remote branch name for a submodule, used by ggiitt ssuubbmmoodduullee uuppddaattee ----rreemmoottee. Set this option to override
           the value found in the ..ggiittmmoodduulleess file. See ggiitt--ssuubbmmoodduullee(1) and ggiittmmoodduulleess(5) for details.

       submodule.<name>.fetchRecurseSubmodules
           This option can be used to control recursive fetching of this submodule. It can be overridden by using the
           --[no-]recurse-submodules command-line option to "git fetch" and "git pull". This setting will override that
           from in the ggiittmmoodduulleess(5) file.

       submodule.<name>.ignore
           Defines under what circumstances "git status" and the diff family show a submodule as modified. When set to
           "all", it will never be considered modified (but it will nonetheless show up in the output of status and
           commit when it has been staged), "dirty" will ignore all changes to the submodules work tree and takes only
           differences between the HEAD of the submodule and the commit recorded in the superproject into account.
           "untracked" will additionally let submodules with modified tracked files in their work tree show up. Using
           "none" (the default when this option is not set) also shows submodules that have untracked files in their
           work tree as changed. This setting overrides any setting made in .gitmodules for this submodule, both
           settings can be overridden on the command line by using the "--ignore-submodules" option. The _g_i_t _s_u_b_m_o_d_u_l_e
           commands are not affected by this setting.

       submodule.<name>.active
           Boolean value indicating if the submodule is of interest to git commands. This config option takes
           precedence over the submodule.active config option. See ggiittssuubbmmoodduulleess(7) for details.

       submodule.active
           A repeated field which contains a pathspec used to match against a submodule’s path to determine if the
           submodule is of interest to git commands. See ggiittssuubbmmoodduulleess(7) for details.

       submodule.recurse
           Specifies if commands recurse into submodules by default. This applies to all commands that have a
           ----rreeccuurrssee--ssuubbmmoodduulleess option, except cclloonnee. Defaults to false.

       submodule.fetchJobs
           Specifies how many submodules are fetched/cloned at the same time. A positive integer allows up to that
           number of submodules fetched in parallel. A value of 0 will give some reasonable default. If unset, it
           defaults to 1.

       submodule.alternateLocation
           Specifies how the submodules obtain alternates when submodules are cloned. Possible values are nnoo,
           ssuuppeerrpprroojjeecctt. By default nnoo is assumed, which doesn’t add references. When the value is set to ssuuppeerrpprroojjeecctt
           the submodule to be cloned computes its alternates location relative to the superprojects alternate.

       submodule.alternateErrorStrategy
           Specifies how to treat errors with the alternates for a submodule as computed via
           ssuubbmmoodduullee..aalltteerrnnaatteeLLooccaattiioonn. Possible values are iiggnnoorree, iinnffoo, ddiiee. Default is ddiiee. Note that if set to
           iiggnnoorree or iinnffoo, and if there is an error with the computed alternate, the clone proceeds as if no alternate
           was specified.

       tag.forceSignAnnotated
           A boolean to specify whether annotated tags created should be GPG signed. If ----aannnnoottaattee is specified on the
           command line, it takes precedence over this option.

       tag.sort
           This variable controls the sort ordering of tags when displayed by ggiitt--ttaagg(1). Without the "--sort=<value>"
           option provided, the value of this variable will be used as the default.

       tag.gpgSign
           A boolean to specify whether all tags should be GPG signed. Use of this option when running in an automated
           script can result in a large number of tags being signed. It is therefore convenient to use an agent to
           avoid typing your gpg passphrase several times. Note that this option doesn’t affect tag signing behavior
           enabled by "-u <keyid>" or "--local-user=<keyid>" options.

       tar.umask
           This variable can be used to restrict the permission bits of tar archive entries. The default is 0002, which
           turns off the world write bit. The special value "user" indicates that the archiving user’s umask will be
           used instead. See umask(2) and ggiitt--aarrcchhiivvee(1).

       Trace2 config settings are only read from the system and global config files; repository local and worktree
       config files and --cc command line arguments are not respected.

       trace2.normalTarget
           This variable controls the normal target destination. It may be overridden by the GGIITT__TTRRAACCEE22 environment
           variable. The following table shows possible values.

       trace2.perfTarget
           This variable controls the performance target destination. It may be overridden by the GGIITT__TTRRAACCEE22__PPEERRFF
           environment variable. The following table shows possible values.

       trace2.eventTarget
           This variable controls the event target destination. It may be overridden by the GGIITT__TTRRAACCEE22__EEVVEENNTT
           environment variable. The following table shows possible values.

           •   00 or ffaallssee - Disables the target.

           •   11 or ttrruuee - Writes to SSTTDDEERRRR.

           •   [[22--99]] - Writes to the already opened file descriptor.

           •   <<aabbssoolluuttee--ppaatthhnnaammee>> - Writes to the file in append mode. If the target already exists and is a
               directory, the traces will be written to files (one per process) underneath the given directory.

           •   aaff__uunniixx::[[<<ssoocckkeett__ttyyppee>>::]]<<aabbssoolluuttee--ppaatthhnnaammee>> - Write to a Unix DomainSocket (on platforms that support
               them). Socket type can be either ssttrreeaamm or ddggrraamm; if omitted Git will try both.

       trace2.normalBrief
           Boolean. When true ttiimmee, ffiilleennaammee, and lliinnee fields are omitted from normal output. May be overridden by the
           GGIITT__TTRRAACCEE22__BBRRIIEEFF environment variable. Defaults to false.

       trace2.perfBrief
           Boolean. When true ttiimmee, ffiilleennaammee, and lliinnee fields are omitted from PERF output. May be overridden by the
           GGIITT__TTRRAACCEE22__PPEERRFF__BBRRIIEEFF environment variable. Defaults to false.

       trace2.eventBrief
           Boolean. When true ttiimmee, ffiilleennaammee, and lliinnee fields are omitted from event output. May be overridden by the
           GGIITT__TTRRAACCEE22__EEVVEENNTT__BBRRIIEEFF environment variable. Defaults to false.

       trace2.eventNesting
           Integer. Specifies desired depth of nested regions in the event output. Regions deeper than this value will
           be omitted. May be overridden by the GGIITT__TTRRAACCEE22__EEVVEENNTT__NNEESSTTIINNGG environment variable. Defaults to 2.

       trace2.configParams
           A comma-separated list of patterns of "important" config settings that should be recorded in the trace2
           output. For example, ccoorree..**,,rreemmoottee..**..uurrll would cause the trace2 output to contain events listing each
           configured remote. May be overridden by the GGIITT__TTRRAACCEE22__CCOONNFFIIGG__PPAARRAAMMSS environment variable. Unset by default.

       trace2.destinationDebug
           Boolean. When true Git will print error messages when a trace target destination cannot be opened for
           writing. By default, these errors are suppressed and tracing is silently disabled. May be overridden by the
           GGIITT__TTRRAACCEE22__DDSSTT__DDEEBBUUGG environment variable.

       trace2.maxFiles
           Integer. When writing trace files to a target directory, do not write additional traces if we would exceed
           this many files. Instead, write a sentinel file that will block further tracing to this directory. Defaults
           to 0, which disables this check.

       transfer.fsckObjects
           When ffeettcchh..ffsscckkOObbjjeeccttss or rreecceeiivvee..ffsscckkOObbjjeeccttss are not set, the value of this variable is used instead.
           Defaults to false.

           When set, the fetch or receive will abort in the case of a malformed object or a link to a nonexistent
           object. In addition, various other issues are checked for, including legacy issues (see ffsscckk..<<mmssgg--iidd>>), and
           potential security issues like the existence of a ..GGIITT directory or a malicious ..ggiittmmoodduulleess file (see the
           release notes for v2.2.1 and v2.17.1 for details). Other sanity and security checks may be added in future
           releases.

           On the receiving side, failing fsckObjects will make those objects unreachable, see "QUARANTINE ENVIRONMENT"
           in ggiitt--rreecceeiivvee--ppaacckk(1). On the fetch side, malformed objects will instead be left unreferenced in the
           repository.

           Due to the non-quarantine nature of the ffeettcchh..ffsscckkOObbjjeeccttss implementation it cannot be relied upon to leave
           the object store clean like rreecceeiivvee..ffsscckkOObbjjeeccttss can.

           As objects are unpacked they’re written to the object store, so there can be cases where malicious objects
           get introduced even though the "fetch" failed, only to have a subsequent "fetch" succeed because only new
           incoming objects are checked, not those that have already been written to the object store. That difference
           in behavior should not be relied upon. In the future, such objects may be quarantined for "fetch" as well.

           For now, the paranoid need to find some way to emulate the quarantine environment if they’d like the same
           protection as "push". E.g. in the case of an internal mirror do the mirroring in two steps, one to fetch the
           untrusted objects, and then do a second "push" (which will use the quarantine) to another internal repo, and
           have internal clients consume this pushed-to repository, or embargo internal fetches and only allow them
           once a full "fsck" has run (and no new fetches have happened in the meantime).

       transfer.hideRefs
           String(s) rreecceeiivvee--ppaacckk and uuppllooaadd--ppaacckk use to decide which refs to omit from their initial advertisements.
           Use more than one definition to specify multiple prefix strings. A ref that is under the hierarchies listed
           in the value of this variable is excluded, and is hidden when responding to ggiitt ppuusshh or ggiitt ffeettcchh. See
           rreecceeiivvee..hhiiddeeRReeffss and uuppllooaaddppaacckk..hhiiddeeRReeffss for program-specific versions of this config.

           You may also include a !!  in front of the ref name to negate the entry, explicitly exposing it, even if an
           earlier entry marked it as hidden. If you have multiple hideRefs values, later entries override earlier ones
           (and entries in more-specific config files override less-specific ones).

           If a namespace is in use, the namespace prefix is stripped from each reference before it is matched against
           ttrraannssffeerr..hhiiddeerreeffss patterns. For example, if rreeffss//hheeaaddss//mmaasstteerr is specified in ttrraannssffeerr..hhiiddeeRReeffss and the
           current namespace is ffoooo, then rreeffss//nnaammeessppaacceess//ffoooo//rreeffss//hheeaaddss//mmaasstteerr is omitted from the advertisements but
           rreeffss//hheeaaddss//mmaasstteerr and rreeffss//nnaammeessppaacceess//bbaarr//rreeffss//hheeaaddss//mmaasstteerr are still advertised as so-called "have" lines.
           In order to match refs before stripping, add a ^^ in front of the ref name. If you combine !!  and ^^, !!  must
           be specified first.

           Even if you hide refs, a client may still be able to steal the target objects via the techniques described
           in the "SECURITY" section of the ggiittnnaammeessppaacceess(7) man page; it’s best to keep private data in a separate
           repository.

       transfer.unpackLimit
           When ffeettcchh..uunnppaacckkLLiimmiitt or rreecceeiivvee..uunnppaacckkLLiimmiitt are not set, the value of this variable is used instead. The
           default value is 100.

       uploadarchive.allowUnreachable
           If true, allow clients to use ggiitt aarrcchhiivvee ----rreemmoottee to request any tree, whether reachable from the ref tips
           or not. See the discussion in the "SECURITY" section of ggiitt--uuppllooaadd--aarrcchhiivvee(1) for more details. Defaults to
           ffaallssee.

       uploadpack.hideRefs
           This variable is the same as ttrraannssffeerr..hhiiddeeRReeffss, but applies only to uuppllooaadd--ppaacckk (and so affects only
           fetches, not pushes). An attempt to fetch a hidden ref by ggiitt ffeettcchh will fail. See also
           uuppllooaaddppaacckk..aalllloowwTTiippSSHHAA11IInnWWaanntt.

       uploadpack.allowTipSHA1InWant
           When uuppllooaaddppaacckk..hhiiddeeRReeffss is in effect, allow uuppllooaadd--ppaacckk to accept a fetch request that asks for an object
           at the tip of a hidden ref (by default, such a request is rejected). See also uuppllooaaddppaacckk..hhiiddeeRReeffss. Even if
           this is false, a client may be able to steal objects via the techniques described in the "SECURITY" section
           of the ggiittnnaammeessppaacceess(7) man page; it’s best to keep private data in a separate repository.

       uploadpack.allowReachableSHA1InWant
           Allow uuppllooaadd--ppaacckk to accept a fetch request that asks for an object that is reachable from any ref tip.
           However, note that calculating object reachability is computationally expensive. Defaults to ffaallssee. Even if
           this is false, a client may be able to steal objects via the techniques described in the "SECURITY" section
           of the ggiittnnaammeessppaacceess(7) man page; it’s best to keep private data in a separate repository.

       uploadpack.allowAnySHA1InWant
           Allow uuppllooaadd--ppaacckk to accept a fetch request that asks for any object at all. Defaults to ffaallssee.

       uploadpack.keepAlive
           When uuppllooaadd--ppaacckk has started ppaacckk--oobbjjeeccttss, there may be a quiet period while ppaacckk--oobbjjeeccttss prepares the pack.
           Normally it would output progress information, but if ----qquuiieett was used for the fetch, ppaacckk--oobbjjeeccttss will
           output nothing at all until the pack data begins. Some clients and networks may consider the server to be
           hung and give up. Setting this option instructs uuppllooaadd--ppaacckk to send an empty keepalive packet every
           uuppllooaaddppaacckk..kkeeeeppAAlliivvee seconds. Setting this option to 0 disables keepalive packets entirely. The default is 5
           seconds.

       uploadpack.packObjectsHook
           If this option is set, when uuppllooaadd--ppaacckk would run ggiitt ppaacckk--oobbjjeeccttss to create a packfile for a client, it
           will run this shell command instead. The ppaacckk--oobbjjeeccttss command and arguments it _w_o_u_l_d have run (including the
           ggiitt ppaacckk--oobbjjeeccttss at the beginning) are appended to the shell command. The stdin and stdout of the hook are
           treated as if ppaacckk--oobbjjeeccttss itself was run. I.e., uuppllooaadd--ppaacckk will feed input intended for ppaacckk--oobbjjeeccttss to
           the hook, and expects a completed packfile on stdout.

           Note that this configuration variable is ignored if it is seen in the repository-level config (this is a
           safety measure against fetching from untrusted repositories).

       uploadpack.allowFilter
           If this option is set, uuppllooaadd--ppaacckk will support partial clone and partial fetch object filtering.

       uploadpack.allowRefInWant
           If this option is set, uuppllooaadd--ppaacckk will support the rreeff--iinn--wwaanntt feature of the protocol version 2 ffeettcchh
           command. This feature is intended for the benefit of load-balanced servers which may not have the same view
           of what OIDs their refs point to due to replication delay.

       url.<base>.insteadOf
           Any URL that starts with this value will be rewritten to start, instead, with <base>. In cases where some
           site serves a large number of repositories, and serves them with multiple access methods, and some users
           need to use different access methods, this feature allows people to specify any of the equivalent URLs and
           have Git automatically rewrite the URL to the best alternative for the particular user, even for a
           never-before-seen repository on the site. When more than one insteadOf strings match a given URL, the
           longest match is used.

           Note that any protocol restrictions will be applied to the rewritten URL. If the rewrite changes the URL to
           use a custom protocol or remote helper, you may need to adjust the pprroottooccooll..**..aallllooww config to permit the
           request. In particular, protocols you expect to use for submodules must be set to aallwwaayyss rather than the
           default of uusseerr. See the description of pprroottooccooll..aallllooww above.

       url.<base>.pushInsteadOf
           Any URL that starts with this value will not be pushed to; instead, it will be rewritten to start with
           <base>, and the resulting URL will be pushed to. In cases where some site serves a large number of
           repositories, and serves them with multiple access methods, some of which do not allow push, this feature
           allows people to specify a pull-only URL and have Git automatically use an appropriate URL to push, even for
           a never-before-seen repository on the site. When more than one pushInsteadOf strings match a given URL, the
           longest match is used. If a remote has an explicit pushurl, Git will ignore this setting for that remote.

       user.name, user.email, author.name, author.email, committer.name, committer.email
           The uusseerr..nnaammee and uusseerr..eemmaaiill variables determine what ends up in the aauutthhoorr and ccoommmmiitttteerr field of commit
           objects. If you need the aauutthhoorr or ccoommmmiitttteerr to be different, the aauutthhoorr..nnaammee, aauutthhoorr..eemmaaiill, ccoommmmiitttteerr..nnaammee
           or ccoommmmiitttteerr..eemmaaiill variables can be set. Also, all of these can be overridden by the GGIITT__AAUUTTHHOORR__NNAAMMEE,
           GGIITT__AAUUTTHHOORR__EEMMAAIILL, GGIITT__CCOOMMMMIITTTTEERR__NNAAMMEE, GGIITT__CCOOMMMMIITTTTEERR__EEMMAAIILL and EEMMAAIILL environment variables.

           Note that the nnaammee forms of these variables conventionally refer to some form of a personal name. See ggiitt--
           ccoommmmiitt(1) and the environment variables section of ggiitt(1) for more information on these settings and the
           ccrreeddeennttiiaall..uusseerrnnaammee option if you’re looking for authentication credentials instead.

       user.useConfigOnly
           Instruct Git to avoid trying to guess defaults for uusseerr..eemmaaiill and uusseerr..nnaammee, and instead retrieve the values
           only from the configuration. For example, if you have multiple email addresses and would like to use a
           different one for each repository, then with this configuration option set to ttrruuee in the global config
           along with a name, Git will prompt you to set up an email before making new commits in a newly cloned
           repository. Defaults to ffaallssee.

       user.signingKey
           If ggiitt--ttaagg(1) or ggiitt--ccoommmmiitt(1) is not selecting the key you want it to automatically when creating a signed
           tag or commit, you can override the default selection with this variable. This option is passed unchanged to
           gpg’s --local-user parameter, so you may specify a key using any method that gpg supports.

       versionsort.prereleaseSuffix (deprecated)
           Deprecated alias for vveerrssiioonnssoorrtt..ssuuffffiixx. Ignored if vveerrssiioonnssoorrtt..ssuuffffiixx is set.

       versionsort.suffix
           Even when version sort is used in ggiitt--ttaagg(1), tagnames with the same base version but different suffixes are
           still sorted lexicographically, resulting e.g. in prerelease tags appearing after the main release (e.g.
           "1.0-rc1" after "1.0"). This variable can be specified to determine the sorting order of tags with different
           suffixes.

           By specifying a single suffix in this variable, any tagname containing that suffix will appear before the
           corresponding main release. E.g. if the variable is set to "-rc", then all "1.0-rcX" tags will appear before
           "1.0". If specified multiple times, once per suffix, then the order of suffixes in the configuration will
           determine the sorting order of tagnames with those suffixes. E.g. if "-pre" appears before "-rc" in the
           configuration, then all "1.0-preX" tags will be listed before any "1.0-rcX" tags. The placement of the main
           release tag relative to tags with various suffixes can be determined by specifying the empty suffix among
           those other suffixes. E.g. if the suffixes "-rc", "", "-ck" and "-bfs" appear in the configuration in this
           order, then all "v4.8-rcX" tags are listed first, followed by "v4.8", then "v4.8-ckX" and finally
           "v4.8-bfsX".

           If more than one suffixes match the same tagname, then that tagname will be sorted according to the suffix
           which starts at the earliest position in the tagname. If more than one different matching suffixes start at
           that earliest position, then that tagname will be sorted according to the longest of those suffixes. The
           sorting order between different suffixes is undefined if they are in multiple config files.

       web.browser
           Specify a web browser that may be used by some commands. Currently only ggiitt--iinnssttaawweebb(1) and ggiitt--hheellpp(1) may
           use it.

       worktree.guessRemote
           If no branch is specified and neither --bb nor --BB nor ----ddeettaacchh is used, then ggiitt wwoorrkkttrreeee aadddd defaults to
           creating a new branch from HEAD. If wwoorrkkttrreeee..gguueessssRReemmoottee is set to true, wwoorrkkttrreeee aadddd tries to find a
           remote-tracking branch whose name uniquely matches the new branch name. If such a branch exists, it is
           checked out and set as "upstream" for the new branch. If no such match can be found, it falls back to
           creating a new branch from the current HEAD.

BBUUGGSS
       When using the deprecated [[sseeccttiioonn..ssuubbsseeccttiioonn]] syntax, changing a value will result in adding a multi-line key
       instead of a change, if the subsection is given with at least one uppercase character. For example when the
       config looks like

             [section.subsection]
               key = value1

       and running ggiitt ccoonnffiigg sseeccttiioonn..SSuubbsseeccttiioonn..kkeeyy vvaalluuee22 will result in

             [section.subsection]
               key = value1
               key = value2

GGIITT
       Part of the ggiitt(1) suite

NNOOTTEESS
        1. the multi-pack-index design document
           file:///usr/share/doc/git/html/technical/multi-pack-index.html

        2. wire protocol version 2
           file:///usr/share/doc/git/html/technical/protocol-v2.html

Git 2.25.1                                             03/04/2021                                         GIT-CONFIG(1)
