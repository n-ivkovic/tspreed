# tspreed

tspreed is a terminal RSVP speed reader with Spritz-like functionality written in POSIX shell. It reads plain text from `stdin` and presents it one word at time.

If tspreed is terminated before the presentation has finished, the progress of the presentation is passed to `stdout`.

![tspreed demo gif](.img/tspreed.gif)

## Installation

### Packages

| Distro | Package | Maintainer |
| ---    | ---     | ---        |
| Arch Linux, Manjaro | [tspreed (AUR)](https://aur.archlinux.org/packages/tspreed/) | Caltlgin Stsodaat |
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
| -w `wpm`   | wpm=`wpm`            | 300           | Speed words are presented at in words per minute. Required to be set. Minimum value of 1. |
| -n `num`   | numstart=`num`       |               | Start presenting from the nth word. Minimum value of 1. |
| -l         | lengthvary=`bool`    |               | Vary the speed words are presented at based on their length. |
| -q         | quietexit=`bool`     |               | Do not pass presentation progress to stdout if tspreed is terminated before the presentation has finished. |
| -h         | hidecursor=`bool`    | true          | Hide the cursor during the presentation. |
| -i         | proginfo=`bool`      |               | Display progress information during the presentation. |
| -f         | focus=`bool`         |               | Highlight the focus letter (also known as the pivot or optimal recognition point) of the word being presented. |
| -p `style` | focuspointer=`style` | line          | Display pointers in a given style pointing towards the focus letter. Only takes effect if focus letter highlighting is enabled. Styles: `none`, `line`, `point`. |
| -b         | focusbold=`bool`     | true          | Display the focus letter in bold. Only takes effect if focus letter highlighting is enabled. |
| -c `color` | focuscolor=`color`   | 1             | Display the focus letter in a given color. Only takes effect if focus letter highlighting is enabled. Values are ANSI 8-bit standard color values, ranging from 0 to 255. |
| -v         |                      |               | Print tspreed version and exit. |

## Contributing

Please attempt to adhere to the following when creating a pull request:

* Ensure all shell script written is POSIX-compliant. This can be checked using [ShellCheck](https://www.shellcheck.net/). Ensure ShellCheck gives no addtional warnings when the changes made are checked compared to any warnings given when the `develop` branch is checked. If there are additional warnings please provide a justificaition.
* Ensure all indentation is done with a single tab per indent.
* Ensure the [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) branching model is (somewhat) adhered to. Ensure changes are branched from `develop` and the pull request merges back into `develop`. Note that before the PR is accepted the target branch may be changed to a new branch named either `feature/[branch-name]` or `fix/[branch-name]`.

## License

Copyright © 2020 Nicholas Ivkovic.

Licensed under the GNU General Public License version 3 or later, see [`./LICENSE`](./LICENSE) or [https://gnu.org/licenses/gpl.html](https://gnu.org/licenses/gpl.html) for details.
