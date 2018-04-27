# term-config
Files for terminal config.

## Requirements
To use this utility and the scripts they backup/restore:
1. [Python 3.x](https://www.python.org/downloads/)
2. [Hyper Terminal](https://hyper.is/)
3. [Bash (>=4.1)](http://ftp.gnu.org/gnu/bash/)
    1. `.bashrc` and `.bash_profile` files to backup
    2. `gawk`

## Use

### Saving

Run `python term-config.py save`.

### Loading

Run `python term-config.py load`. This will put the `.hyper.js`, 
`.bash_profile`, and `.bashrc` files into the `$HOME` directory.
