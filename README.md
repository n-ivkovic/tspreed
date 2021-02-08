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

Replace github.com with gitlab.com if using GitLab
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

The values provided in the command options take precidence over the values of the user-specific config file `~/.config/tspreed/tspreed.rc` (if defined, `$XDG_CONFIG_HOME/tspreed/tspreed.rc` is used instead), which takes precidence over the values of the system-wide config file `/etc/tspreed/tspreed.rc`.

The default values are stored in [`./default.rc`](./default.rc), which is used as the system-wide config file after installation.

| Option     | Configuration file   | Default value | Description |
| ---        | ---                  | ---           | ---         |
| -w `wpm`   | wpm=`wpm`            | 300           | Speed words are presented at in words per minute. Required to be set. Minimum value of 1, maximum value of 60000 |
| -n `num`   | numstart=`num`       |               | Start presenting from the nth word. Minimum value of 1. |
| -l         | lengthvary=`bool`    |               | Vary the speed words are presented at based on their length. |
| -q         | quietexit=`bool`     |               | Do not pass presentation progress to stdout if tspreed is terminated before the presentation has finished. |
| -h         | hidecursor=`bool`    | true          | Hide the cursor during the presentation. |
| -i         | proginfo=`bool`      |               | Display progress information during the presentation. |
| -f         | focus=`bool`         |               | Highlight the focus letter (also known as the pivot or optimal recognition point) of the word being presented. |
| -p `style` | focuspointer=`style` | line          | Display pointers in a given style pointing towards the focus letter. Only takes effect if focus letter highlighting is enabled. Styles: `none`, `line`, `point`. |
| -b         | focusbold=`bool`     | true          | Display the focus letter in bold. Only takes effect if focus letter highlighting is enabled. |
| -c `color` | focuscolor=`color`   | 1             | Display the focus letter in a given color. Only takes effect if focus letter highlighting is enabled. Values are ANSI 8-bit standard color values, ranging from 0 to 255. |
| -B         | breakposix=`bool`    |               | Break POSIX compliance in order to improve performance. Discussed further in the 'Breaking POSIX compliance' section. |
| -v         |                      |               | Print tspreed version and exit. |


## Breaking POSIX compliance

tspreed is intended to be a POSIX-compliant shell script to ensure portability across Unix-like systems as much as possible. In order to accomodate this, less efficiant solutions are utilized in the script. More efficiant, but non-compliant, solutions can be utilized instead by enabling the 'breakposix' option listed in the Configuration section. This option can safely be enabled if your system supports the following functionality:

* `sleep(1)` is able to use a floating point number for the time operand. This functionality is present in GNU sleep, used by GNU/Linux, and in BSD sleep, used by macOS and BSD.

If tspreed was installed via a package manager and your system supports the required functionality, the package maintainter may have chosen to enable the 'breakposix' option in the default configuration.

## Contributing

Please attempt to adhere to the following when creating a pull request:

* Ensure all shell script written is POSIX-compliant. This can be checked using [ShellCheck](https://www.shellcheck.net/). Ensure ShellCheck gives no addtional warnings when the changes made are checked compared to any warnings given when the `develop` branch is checked. If there are additional warnings please provide a justificaition.
* Ensure all indentation is done with a single tab per indent.
* Ensure the [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) branching model is (somewhat) adhered to. Ensure changes are branched from `develop` and the pull request merges back into `develop`. Note that before the PR is accepted the target branch may be changed to a new branch named either `feature/[branch-name]` or `fix/[branch-name]`.

## License

Copyright © 2021 Nicholas Ivkovic.

Licensed under the GNU General Public License version 3 or later. See [`./LICENSE`](./LICENSE), or [https://gnu.org/licenses/gpl.html](https://gnu.org/licenses/gpl.html) if more recent, for details.

This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
