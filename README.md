# tspreed

tspreed is a shell RSVP speed reader with Spritz-like functionality. It reads plain text from stdin and presents it one word at time.

If tspreed is terminated before the presentation has finished, the progress of the presentation is passed to stdout.

![tspreed demo gif](.img/tspreed.gif)

## Installation

### Install

```
# Replace github.com with gitlab.com if using GitLab
$ git clone https://github.com/n-ivkovic/tspreed
$ cd tspreed
$ sudo make install
```

### Update

```
$ sudo make uninstall
$ git pull origin
$ sudo make install
```

### Additional options

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

| Option     | Configuration file   | Default value | Description |
| ---        | ---                  | ---           | ---         |
| -w `wpm`   | wpm=`wpm`            | 300           | Speed words are presented at in words per minute. Required to be set. Minimum value of `1`. |
| -n `num`   | numstart=`num`       |               | Start presenting from the nth word. Minimum value of `1`. |
| -l         | lengthvary=`bool`    |               | Vary the speed words are presented at based on their length. |
| -q         | quietexit=`bool`     |               | Do not pass presentation progress to stdout if tspreed is terminated before the presentation has finished. |
| -h         | hidecursor=`bool`    | true          | Hide the cursor during the presentation. |
| -i         | proginfo=`bool`      |               | Display progress information during the presentation. |
| -f         | focus=`bool`         |               | Highlight the focus letter (also known as the pivot or optimal recognition point) of the word being presented. |
| -p `style` | focuspointer=`style` | line          | Display pointers in a given style pointing towards the focus letter. Only takes effect if focus letter highlighting is enabled. Styles: `none`, `line`, `point`. |
| -b         | focusbold=`bool`     | true          | Display the focus letter in bold. Only takes effect if focus letter highlighting is enabled. |
| -c `color` | focuscolor=`color`   | 1             | Display the focus letter in a given color. Only takes effect if focus letter highlighting is enabled. Values are ANSI 8-bit standard color values, ranging from `0` to `7`. |

The default values will be stored in the user-specific config file `~/.config/tspreed/tspreed.rc` (`$XDG_CONFIG_HOME/tspreed/tspreed.rc` if defined) after installation.

## Licence

Copyright © 2020 Nicholas Ivkovic.

Licensed under the [GNU GPL v3.0](./LICENSE) or later.
