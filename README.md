# tspreed

tspreed is a terminal RSVP speed reader with Spritz-like functionality written in POSIX-compliant shell. It reads plain text from `stdin` and presents it one word at time.

If tspreed is terminated before the presentation has finished, the progress of the presentation is passed to `stdout`.

![tspreed demo gif](.img/tspreed.gif)

## Installation

### Packages

| Distro | Package | Maintainer |
| ---    | ---     | ---        |
| Arch Linux | [tspreed (AUR)](https://aur.archlinux.org/packages/tspreed/) | Nicholas Ivkovic |

### Manual

#### Install

Replace `github.com` with `gitlab.com` if using GitLab.
```
$ git clone https://github.com/n-ivkovic/tspreed
$ cd tspreed
# make install
```

#### Update

```
$ git pull origin
# make update
```

#### Additional options

```
$ make help
```

## Usage

To use, pipe plain text into tspreed.

```
$ tspreed < textfile
```
```
$ tspreed --wpm 300 --hide-cursor < textfile
```
```	
$ pdftotext document.pdf - | tspreed -w 300 -n 120 -s '\r\f' -lqihfb -p line -c 1
```

## Configuration

The values provided in the command options take precedence over the values provided in the local configuration file **`$XDG_CONFIG_HOME`/tspreed/tspreed.rc** (**~/.config/tspreed/tspreed.rc** if not defined), which takes precedence over the values provided in the global configuration file **/etc/tspreed/tspreed.rc**.

The default values are provided in [**./default.rc**](./default.rc), which is installed as the global configuration file.

| Option                      | Configuration file   | Default value | Description |
| ---                         | ---                  | ---           | ---         |
| -w, --wpm `wpm`             | wpm=`wpm`            | 300           | Present words at the given WPM (words per minute). Required to be set. Minimum value of 1, maximum value of 60000 |
| -n, --num-start `num`       | numstart=`num`       |               | Start presenting from the given *n*th word. Minimum value of 1. |
| -s, --separators `chars`    | separators=`chars`   | \r\f          | Use the given characters to separate words in addition to the characters set in `$IFS`. Backslash escapes are interpreted. |
| -l, --length-vary           | lengthvary=`bool`    |               | Vary the speed words are presented at based on their length. |
| -q, --quiet-exit            | quietexit=`bool`     |               | Do not output the presentation progress if tspreed is terminated before the presentation has finished. |
| -h, --hide-cursor           | hidecursor=`bool`    | true          | Hide the cursor during the presentation. |
| -i, --progress-info         | proginfo=`bool`      |               | Display progress information during the presentation. |
| -f, --focus                 | focus=`bool`         |               | Highlight the focus letter (also known as the pivot or optimal recognition point) of the word being presented. |
| -p, --focus-pointer `style` | focuspointer=`style` | line          | Display pointers in a given style pointing towards the focus letter. Only takes effect if focus letter highlighting is enabled. Styles: `none`, `line`, `point`. |
| -b, --focus-bold            | focusbold=`bool`     | true          | Display the focus letter in bold. Only takes effect if focus letter highlighting is enabled. |
| -c, --focus-color `color`   | focuscolor=`color`   | 1             | Display the focus letter in the given color. Only takes effect if focus letter highlighting is enabled. Color values are [ANSI X3.64 8-bit color values](https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit), ranging from 0 to 255. |
| -v, -V, --version           |                      |               | Print tspreed version and exit. |

## Portability

tspreed 'officially' supports GNU-based, BSD-based, and BusyBox-based systems only due to POSIX-compliance issues described below. This does not mean the script is guaranteed to not work on other Unix-like systems or issues specific to those systems will not be addressed, merely it is unknown how well supported the script is on other Unix-like systems.

tspreed attempts to comply with [POSIX.1-2001](https://pubs.opengroup.org/onlinepubs/000095399/) through to [POSIX.1-2008](https://pubs.opengroup.org/onlinepubs/9699919799/) in order to maintain portability across Unix-like systems. However, **the script must utilize at least one of the below non-compliant features or commands** and will exit with an error if none are supported:

* `date(1)` - Can return nanoseconds via the '%N' format.
* `sleep(1)` - Supports the use of fractional values for the time operand to represent units of time less than 1 second, e.g. 0.05.
* `sleep(1)` - Supports the use of E notation for the time operand to represent units of time less than 1 second, e.g. 5e-2.
* `usleep(1)`

The script utilizes terminal capabilities via `tput(1)`, but will fall back to the following where possible if those capabilities fail:

* [ANSI X3.64](https://en.wikipedia.org/wiki/ANSI_escape_code) escape codes for terminal styling and cursor movement.
* `$COLUMNS` and `$LINES` environment variables for determining terminal size. Will fall back to 80 columns and/or 24 lines if one or both of the environmental variables are not set.

## Contributing

Please adhere to the following when creating a pull request:

* Ensure changes do not cause [ShellCheck](https://www.shellcheck.net/) to return any errors or warnings. This can be checked by either running `make test` with ShellCheck installed, or by checking [**./tspreed**](./tspreed) (and [**./default.rc**](./default.rc) if changed) via the online checker. If changes include new warning suppressions please provide an explanation.
* Ensure changes comply with [POSIX.1-2001](https://pubs.opengroup.org/onlinepubs/000095399/), but does not include any features that are removed from or marked as obsolete in [POSIX.1-2008](https://pubs.opengroup.org/onlinepubs/9699919799/). If non-compliant changes are required please provide an explanation.
* Ensure changes match the general coding style of the project.
* Ensure changes are branched from `develop` and the pull request merges back into `develop`.

## License

Copyright © 2022 Nicholas Ivkovic.

Licensed under the GNU General Public License version 3 or later. See [**./LICENSE**](./LICENSE), or [https://gnu.org/licenses/gpl.html](https://gnu.org/licenses/gpl.html) if more recent, for details.

This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
