<div align="center"><img src="https://github.com/FG42/FG42/raw/master/share/icons/hicolor/128x128/apps/fg42.png" alt="FG42" align="center" /></div>

<br/><br/>

#  Future Gadgets 42
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

You can also download the tarball from release section and extract the tarball
in your `$HOME` directory. So you're going to end up with `.fg42` directory in
your `$HOME` and all you have to do is to install it using `make install` command.

**NOTE**: please note that the tarball releases are still experimental and might have
some issues since they contain the elisp packages as well. In case of any problem
please report the issue.

Enjoy using **FG42** ;)

## Configuration

After installation there would be a file at `~/.fg42.el` which is the user specific
configuration of **FG42**. You can configure your copy of **FG42** using this file.
Also you can generally use this file to configure Emacs as well.

## Terms & Concepts
FG42 introduced some new features to the Vanilla Gnu/Emacs. So you migh encounter several of these features during your
journey. It's a good idea to at least know what you're dealing with.

### Extensions
FG42 created around the idea of extensions. Each extension extends the FG42 functionality for a certain language or use case.
For example `clojure` extension adds support for a integrated development environment for `clojure` language. All the configuration
related to this environment leave inside that extension. By default, all the extensions which ships with FG42 are enabled. In order
to disable any extension which you might not need, just comment them out in your user configuration file in `~/.fg42.el`. For example
here is my own list:

```lisp
(activate-extensions 'editor
                     'development
                     'web
                     'editor-theme
                     'javascript
                     ;;'ruby
                     'clojure
                     ;;'php
                     'python)
                     ;;'arduino

```

In order to learn more about each extension you can use `M-x describe-extension`.

### Abilities
Abilities are the smallest piece of configuration which add support for a certain functionality to **FG42**. Each extension contains several abilities.
Using abilities you can choose the set of abilities you like and disable those which you don't like. For example `helm` and `ido` are two different
library which conflicts with each other by we have an ability for each of them in the system, so you can choose which one to use and disable the other one.

In order to disable any ability, just add them to your configuration file in `~/.fg42.el`. For example my current disabled abilities are:

```lisp
(disable 'rbenv-global 'helm 'spell 'linum  'ivy 'smart-mode-line 'desktop-mode)

```

In the above list I disabled `helm` because I want to use `ido`. At the moment there is no way to find out about all the enabled abilities at runtime. Or
discover what abilities present in any extension (You can take a look at extension docs using `describe-extension` command) at runtime. But I'll add something
later :P.

## Documentation

If you're familiar with **GNU/Emacs** you're not going to have a problem with getting
help. But just to clrearify here is a list of keybindings that may guide you during
your experience:


| Key bindings | command | Description      |
|:------------:|--------:|------------------|
| `C-?`        | cheatsheet-show | Quick cheatsheet |
|              | describe-extension | It's going to ask you an extension name and show you the documentation of that extension |
| `C-h m`      | describe-mode | All the information and keybindings of your current modes. e.g open of a `ruby` file and use the this keybinding to take a look at all the keybinding of ruby extension |



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

Copyright (C) 2010-2018  Sameer Rahmani <lxsameer@gnu.org>
