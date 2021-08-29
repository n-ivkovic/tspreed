# tspreed

tspreed is a terminal RSVP speed reader with Spritz-like functionality written in (almost POSIX-compliant) shell. It reads plain text from `stdin` and presents it one word at time.

If tspreed is terminated before the presentation has finished, the progress of the presentation is passed to `stdout`.

![tspreed demo gif](.img/tspreed.gif)

## Installation

### Packages

| Distro | Package | Maintainer |
| ---    | ---     | ---        |
| Arch Linux | [tspreed (AUR)](https://aur.archlinux.org/packages/tspreed/) | Nicholas Ivkovic |

### Manual

#### Install

Replace github.com with gitlab.com if using GitLab.
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
$ pdftotext document.pdf - | tspreed -w 300 -n 120 -lifb -p line -c 1
```

## Configuration

The values provided in the command options take precedence over the values provided in the local configuration file `~/.config/tspreed/tspreed.rc` (if defined, `$XDG_CONFIG_HOME/tspreed/tspreed.rc` is used instead), which takes precedence over the values provided in the global configuration file `/etc/tspreed/tspreed.rc`.

The default values are provided in [./default.rc](./default.rc), which is installed as the global configuration file.

| Option     | Configuration file   | Default value | Description |
| ---        | ---                  | ---           | ---         |
| -w `wpm`   | wpm=`wpm`            | 300           | Speed words are presented at in WPM (words per minute). Required to be set. Minimum value of 1, maximum value of 60000 |
| -n `num`   | numstart=`num`       |               | Start presenting from the *n*th word. Minimum value of 1. |
| -l         | lengthvary=`bool`    |               | Vary the speed words are presented at based on their length. |
| -q         | quietexit=`bool`     |               | Do not pass presentation progress to stdout if tspreed is terminated before the presentation has finished. |
| -h         | hidecursor=`bool`    | true          | Hide the cursor during the presentation. |
| -i         | proginfo=`bool`      |               | Display progress information during the presentation. |
| -f         | focus=`bool`         |               | Highlight the focus letter (also known as the pivot or optimal recognition point) of the word being presented. |
| -p `style` | focuspointer=`style` | line          | Display pointers in a given style pointing towards the focus letter. Only takes effect if focus letter highlighting is enabled. Styles: `none`, `line`, `point`. |
| -b         | focusbold=`bool`     | true          | Display the focus letter in bold. Only takes effect if focus letter highlighting is enabled. |
| -c `color` | focuscolor=`color`   | 1             | Display the focus letter in a given color. Only takes effect if focus letter highlighting is enabled. Values are [ANSI X3.64](https://en.wikipedia.org/wiki/ANSI_escape_code) 8-bit color values, ranging from 0 to 255. |
| -v         |                      |               | Print tspreed version and exit. |

## Portability

tspreed 'officially' supports GNU-based systems and BSD-based systems only (i.e. GNU/Linux, macOS, BSD) due to POSIX-compliance issues described below. This does not mean the script will not work on other Unix-like systems or portability is not treated as a priority, however this does mean compatibility is not guaranteed on unsupported systems.

tspreed attempts to adhere to [IEEE Std 1003.1-2001](https://pubs.opengroup.org/onlinepubs/000095399/) (a.k.a. SUSv3 or POSIX.1-2001) in order to be portable across Unix-like systems. However, **the script must utilize at least one of the non-compliant functionalities listed below**. The script will exit with an error if neither functionality is supported by the system.

* `date(1)` can return nanoseconds via the '%N' format.
* `sleep(1)` supports the use of floating point values for the time operand to represent units of time less than 1 second.

The script will determine at runtime if it can utilize additional non-compliant features to improve performance.

The script utilizes terminal capabilities via `tput(1)`, but will fall back to [ANSI X3.64](https://en.wikipedia.org/wiki/ANSI_escape_code) escape codes where possible if it determines at runtime that the capabilities are not supported.

## Contributing

Please attempt to adhere to the following when creating a pull request:

* Ensure [ShellCheck](https://www.shellcheck.net/) returns no errors/warnings. This can be checked by either running `make test` with ShellCheck installed or by checking [./tspreed](./tspreed) (and [./default.rc](./default.rc) if changed) via the online checker. Any new errors/warnings and any suppressions of those errors/warnings should be explained.
* Ensure all changes conform to [IEEE Std 1003.1-2001](https://pubs.opengroup.org/onlinepubs/000095399/) (a.k.a. SUSv3 or POSIX.1-2001) as much as possible. Any non-conformant changes should be explained.
* Ensure all indentation is done with a single tab per indent.
* Ensure the [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) branching model is (somewhat) adhered to. Ensure changes are branched from `develop` and the pull request merges back into `develop`. Note that before the PR is accepted the target branch may be changed to a new branch named either `feature/[branch-name]` or `fix/[branch-name]`.

## License

Copyright © 2021 Nicholas Ivkovic.

Licensed under the GNU General Public License version 3 or later. See [./LICENSE](./LICENSE), or [https://gnu.org/licenses/gpl.html](https://gnu.org/licenses/gpl.html) if more recent, for details.

This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
