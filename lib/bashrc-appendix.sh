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

trap 'function trapExecutable {
  cmd=("${BASH_COMMAND}");
  cmd_artifact=( ${cmd[0]} );
  declare isExec;
  if [[ -x "$(type -P "${cmd_artifact[0]}")" ]]; then
    isExec=true
    output="$(/usr/bin/autosudo < <(LD_PRELOAD=/var/lib/isatty.so ${cmd[@]} 2>&1))";
    if [[ "${output}" == "noperm" ]]; then
      echo "$(sudo -k LD_PRELOAD=/var/lib/isatty.so ${cmd[@]} 2>&1)";
    elif [[ isExec != true ]]; then
      echo "$output";
    fi;
  fi;
  if [[ $isExec == true ]]; then
    return 1;
  else
    return 0;
  fi;
};
trapExecutable;' DEBUG
set -T
shopt -s extdebug
