#!/bin/bash
#########################################################################
# Copyright (C) 2021 Akito <the@akito.ooo>                              #
#                                                                       #
# This program is free software: you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation, either version 3 of the License, or     #
# (at your option) any later version.                                   #
#                                                                       #
# This program is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          #
# GNU General Public License for more details.                          #
#                                                                       #
# You should have received a copy of the GNU General Public License     #
# along with this program.  If not, see <http://www.gnu.org/licenses/>. #
#########################################################################

## Compiles shared library, that tricks any executable into assuming, it is being run inside a TTY.
## To make it work, you need to preload this library on running the executable.
## Example:
##   ./autosudo < <(LD_PRELOAD=/var/lib/isatty.so ls -alh1 --color=auto nopermdir 2>&1)
## Where `LD_PRELOAD=/var/lib/isatty.so` preloads the library on execution.

gcc -O2 -fpic -shared -ldl -o isatty.so -xc - < <(echo "int isatty(int fd) { return 1; }")