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

#### https://github.com/theAkito/akito-libbash
function white_printf { printf "\033[1;37m$@\033[0m"; }
function red_printf { printf "\033[31m$@\033[0m"; }
function green_printf  { printf "\033[32m$@\033[0m";    }    
function white_brackets { local args="$@"; white_printf "["; printf "${args}"; white_printf "]"; }
function echoError { local args="$@"; white_brackets "$(red_printf "ERROR")" && echo " ${args}" 1>&2; }
function echoInfo { local args="$@"; white_brackets "$(green_printf "INFO" )" && echo " ${args}"; }
function truncEmptyLines {
  ## Remove redundant newlines before EOF.
  ## Leave only a single one.
  local file="$1";
  if [ -s ${file} ]; then
    while [[ $(tail -n 1 ${file}) == "" ]] && [[ -s ${file} ]]; do
      truncate -cs -1 ${file};
    done;
  else
    return 1;
  fi;
}
#### https://github.com/theAkito/akito-libbash

function prepareHack {
  local compiler="./lib/compile-isatty-hack.sh"
  chmod +x "${compiler}"
  "${compiler}"
  echoInfo "A shared library has been compiled and needs to be moved to a globally accessible location. To be able to do that, we need root permissions..."
  sudo mv isatty.so /var/lib/isatty.so
}

function prepareAutosudoExecutable {
  local compiler="./lib/compile-autosudo-executable.sh"
  chmod +x "${compiler}"
  "${compiler}"
  echoInfo "The Autosudo executable has been compiled and needs to be moved to a globally accessible location. To be able to do that, we need root permissions..."
  sudo mv autosudo /usr/bin/autosudo
}

function setupAutosudo {
  local bashrcFile="$1"
  [[ -z "${bashrcFile}" ]] && echoError 'No ".bashrc" or "/etc/bash.bashrc" file provided. Try again.' && return 1
  if [[ $(grep -q '###startpjKiGCPIHbdatOXedrfoHKdJePpBDpcbjGCUKsBiiXFDshOTaaFZrrQIaEXDBeCfw###' "$bashrcFile")$? == 0 ]]; then
    sed -i '/###startpjKiGCPIHbdatOXedrfoHKdJePpBDpcbjGCUKsBiiXFDshOTaaFZrrQIaEXDBeCfw###/,/###endCMKLEVnrlRNwvjeXMuWxiJQhhLdQaIhDMYJWigoyJGdjlqeTItYpFxnNCoRnMQlOa###/{//!d}' "${bashrcFile}"
    sed -i '/###startpjKiGCPIHbdatOXedrfoHKdJePpBDpcbjGCUKsBiiXFDshOTaaFZrrQIaEXDBeCfw###/d' "${bashrcFile}"
    sed -i '/###endCMKLEVnrlRNwvjeXMuWxiJQhhLdQaIhDMYJWigoyJGdjlqeTItYpFxnNCoRnMQlOa###/d'   "${bashrcFile}"
  fi
  printf "\n\n\n\n" >> "${bashrcFile}"
  truncEmptyLines "${bashrcFile}"
  # Appendix copied from ./lib/bashrc-appendix.sh
  cat >> ${bashrcFile} <<"EOF"

###startpjKiGCPIHbdatOXedrfoHKdJePpBDpcbjGCUKsBiiXFDshOTaaFZrrQIaEXDBeCfw###
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
###endCMKLEVnrlRNwvjeXMuWxiJQhhLdQaIhDMYJWigoyJGdjlqeTItYpFxnNCoRnMQlOa###
EOF
}

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -o errexit
set -o nounset
set -o pipefail

setupAutosudo "$1"
prepareHack
prepareAutosudoExecutable