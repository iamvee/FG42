#  Future Gadgets 42 <img src="https://github.com/FG42/FG42/raw/master/share/icons/hicolor/64x64/apps/fg42.png" alt="FG42" align="right" />
If you love **GNU/Emacs**, If you love to program in an editor instead of big slow IDE but still enjoy to
have a handy code editor then **FG42** is the right choice for you.

If you need help, or even want to just say hello, try our **IRC** channel on freenode: **#5hit**.

## Dependencies

In order to run **FG42** you need **GNU Emacs >= 25**. FG42 uses several extensions internally
which each of the has different external dependencies. To gain more information about external
dependencies ( If we failed to tell you inside the **FG42** ) just run the `describe-extension`
command.

## Installation

In order to install **FG42**, issue the following commands:

```bash
# clonse the FG42 repository in ~/.fg42 directory
$ git clone git://github.com/FG42/FG42.git ~/.fg42/
# You can clone it where ever your want
$ cd ~/.fg42/
$ make install
```
Since the installer script uses `sudo`, during the installation process,
you'll have to enter your password. Make sure that you're user account has
a `sudo` access.

Enjoy using **FG42** ;)

## Configuration

After installation there would be a file at `~/.fg42.el` which is the user specific
configuration of **FG42**. You can configure your copy of **FG42** using this file.
Also you can generally use this file to configure Emacs as well.

## Documentation

If you're familiar with **GNU/Emacs** you're not going to have a problem with getting
help. But just to clrearify here is a list of keybindings that may guide you during
your experience:


| Key bindings | Description      |
|:------------:|------------------|
| `C-?`          | Quick cheatsheet |
| `C-h m`        | All the information and keybindings of your current modes. e.g open of a `ruby` file and use the this keybinding to take a look at all the keybinding of ruby extension |


## what's with the name?

I'm a huge fan of [Steins Gate](https://en.wikipedia.org/wiki/Steins;Gate) anime and I follow its
naming convensions on **Future Gadgets 42**.


# License

  FG42 is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
any later version.

  FG42 is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

  All the documents of FG42 that locate in 'doc' directories release
under the term of GNU FDL.

Copyright (C) 2010-2015  Sameer Rahmani <lxsameer@gnu.org>
