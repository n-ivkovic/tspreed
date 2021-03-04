# tspreed

tspreed is a terminal RSVP speed reader with Spritz-like functionality written in POSIX shell. It reads plain text from `stdin` and presents it one word at time.

If tspreed is terminated before the presentation has finished, the progress of the presentation is passed to `stdout`.

![tspreed demo gif](.img/tspreed.gif)

## Installation

### Packages

| Distro | Package | Maintainer |
| ---    | ---     | ---        |
| Arch Linux, Manjaro | [tspreed (AUR)](https://aur.archlinux.org/packages/tspreed/) | Nicholas Ivkovic |
| Void Linux          | WIP, see [here](https://github.com/void-linux/void-packages/pull/27113) | KawaiiAmber |

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
# make uninstall
$ git pull origin
# make install
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

The values provided in the command options take precedence over the values of the local config file `~/.config/tspreed/tspreed.rc` (if defined, `$XDG_CONFIG_HOME/tspreed/tspreed.rc` is used instead), which takes precedence over the values of the global config file `/etc/tspreed/tspreed.rc`.

The default values are stored in [`./default.rc`](./default.rc), which is installed as the global config during installation.

| Option     | Configuration file   | Default value | Description |
| ---        | ---                  | ---           | ---         |
| -w `wpm`   | wpm=`wpm`            | 300           | Speed words are presented at in words per minute. Required to be set. Minimum value of 1, maximum value of 60000 |
| -n `num`   | numstart=`num`       |               | Start presenting from the *n*th word. Minimum value of 1. |
| -l         | lengthvary=`bool`    |               | Vary the speed words are presented at based on their length. |
| -q         | quietexit=`bool`     |               | Do not pass presentation progress to stdout if tspreed is terminated before the presentation has finished. |
| -h         | hidecursor=`bool`    | true          | Hide the cursor during the presentation. |
| -i         | proginfo=`bool`      |               | Display progress information during the presentation. |
| -f         | focus=`bool`         |               | Highlight the focus letter (also known as the pivot or optimal recognition point) of the word being presented. |
| -p `style` | focuspointer=`style` | line          | Display pointers in a given style pointing towards the focus letter. Only takes effect if focus letter highlighting is enabled. Styles: `none`, `line`, `point`. |
| -b         | focusbold=`bool`     | true          | Display the focus letter in bold. Only takes effect if focus letter highlighting is enabled. |
| -c `color` | focuscolor=`color`   | 1             | Display the focus letter in a given color. Only takes effect if focus letter highlighting is enabled. Values are [ANSI X3.64](https://en.wikipedia.org/wiki/ANSI_escape_code) color values, ranging from 0 to 255. Note that color values above 7 mostly only work on featured terminal emulators i.e. xterm |
| -v         |                      |               | Print tspreed version and exit. |

## Portability

tspreed 'officially' supports GNU-based systems and BSD-based systems only (i.e. GNU/Linux, macOS, BSD). This does not mean the script will not work on other Unix-like systems or portability is not treated as a priority, however this does mean compatibility is not guaranteed on unsupported systems.

### POSIX

tspreed attempts to adhere to [IEEE Std 1003.1-2001 (a.k.a. SUSv3 or POSIX.1-2001)](https://pubs.opengroup.org/onlinepubs/000095399/) in order to be portable across Unix-like systems. However, non-compliant functionalities have been utilized to either overcome limitations of the standard or improve performance where possible. The script will determine at runtime which non-compliant functionalities the system supports and either exit with an error or adjust its behavior accordingly.

The script must utilize at least one of the non-compliant functionalities listed below. The script will exit with an error if neither functionality is supported by the system.

* The '%N' format in `date(1)`.
* The use of floating point values for the time operand in `sleep(1)`.

### Terminal capabilities

tspreed utilizes terminal capabilities via `tput(1)` that are supported by terminals/terminal emulators that support [ANSI X3.64](https://en.wikipedia.org/wiki/ANSI_escape_code) escape codes, which have been well-supported since the 1980s. The script will determine at runtime which capabilities the terminal supports and either exit with an error or adjust its behavior accordingly.

The script utilizes the terminal capabilities `cnorm` and `civis` if the -h/hidecursor option is enabled. These capabilities are not guaranteed to be supported by terminals/terminal emulators that support ANSI X3.64, however are well-supported on modern terminals.

## Todo

* Pause/resume and forward/back as suggested [here](https://github.com/n-ivkovic/tspreed/issues/3).

## Contributing

Please attempt to adhere to the following when creating a pull request:

* Ensure [ShellCheck](https://www.shellcheck.net/) returns no errors/warnings. This can be checked by either running `make test` with ShellCheck installed or by checking [./tspreed](./tspreed) and [./default.rc](./default.rc) via the online checker (note: SC2148 and SC2034 will be thrown when checking ./default.rc via the online checker, this is expected and ok). If the changes made create errors/warnings please provide a justification.
* Ensure all changes conform to [IEEE Std 1003.1-2001 (a.k.a. SUSv3 or POSIX.1-2001)](https://pubs.opengroup.org/onlinepubs/000095399/) as much as possible.
* Ensure all indentation is done with a single tab per indent.
* Ensure the [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) branching model is (somewhat) adhered to. Ensure changes are branched from `develop` and the pull request merges back into `develop`. Note that before the PR is accepted the target branch may be changed to a new branch named either `feature/[branch-name]` or `fix/[branch-name]`.

## License

Copyright © 2021 Nicholas Ivkovic.

Licensed under the GNU General Public License version 3 or later. See [`./LICENSE`](./LICENSE), or [https://gnu.org/licenses/gpl.html](https://gnu.org/licenses/gpl.html) if more recent, for details.

This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
