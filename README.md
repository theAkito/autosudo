[![Source](https://img.shields.io/badge/project-source-2a2f33?style=plastic)](https://github.com/theAkito/autosudo)
[![Language](https://img.shields.io/badge/language-Nim-orange.svg?style=plastic)](https://nim-lang.org/)

![Last Commit](https://img.shields.io/github/last-commit/theAkito/autosudo?style=plastic)

[![GitHub](https://img.shields.io/badge/license-GPL--3.0-informational?style=plastic)](https://www.gnu.org/licenses/gpl-3.0.txt)
[![Liberapay patrons](https://img.shields.io/liberapay/patrons/Akito?style=plastic)](https://liberapay.com/Akito/)

## What
This is an alternative to Deckweiss' [auto-root](https://github.com/Deckweiss/auto-root) project.

## Why
It is interesting to push the limits of Bash and other Linux components. Even though, it is very easy to push the extremely low limits of UX and design on Linux.

A big problem with Linux operating systems is, that too many of their users have this elitist mindset, that does not see how important UX and proper design is. After all, computers are made for humans, not the other way around.
This is a tiny step into the direction of having a more human friendly Linux operating system at your hands. It is definitely not a real solution, perhaps not even a fully working workaround, but this project is more about the spirit and what it stands for. It's about showing that things can be different and that you do not need to serve Linux, if you do not have to.

If you do not understand, how big of a difference it is to not re-type the last command and manually prepending `sudo` before it, you likely are part of the problem, as described above. Such a little UX improvement is in reality a huge step forward for the user experience and therefore a big improvement for the majority of Linux OS users.

## How
The following approach shows how to make this project work from source.

1. We need dependencies.
2. We compile a shared library.
3. We compile a binary.
4. We set up your `.bashrc`, so it is able to autosudo executables in your interactive Bash shell.

### Dependencies
* [Nim](https://nim-lang.org/install_unix.html)
* [Bash](https://www.gnu.org/software/bash/)
* [GNU Compiler Collection](https://www.ubuntupit.com/how-to-install-and-use-gcc-compiler-on-linux-system/)

### Installation
```bash
bash setup.sh ~/.bashrc
```

### De-Installation
```bash
bash uninstall.sh ~/.bashrc
```

Run both scripts without root permissions. They will ask you for your `sudo` password in the middle of the process, to make `autosudo` work globally, for all users, by moving those tools to global locations in your operating system, where you are only allowed to move things, if you have root permissions, i.e. use `sudo`.

## Where
* Debian
* Ubuntu
* Artix

Other Linux operating systems might be a hit or miss.
As it is now, it does not work on macOS.

However, macOS support may probably be added.

## Goals
Bring a bit of humanity into the Linux world.

## Project Status
Works, but it needs much more testing. Interactive shell usage edge cases probably aren't handled well and some user interaction might result in undefined behaviour.

If you want a working solution, which covers a lot of edge cases and is tested a lot more and better, then use the [original project's product](https://github.com/Deckweiss/auto-root).

## TODO
* Testing

## License
Copyright (C) 2021  Akito <the@akito.ooo>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.