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
#### https://github.com/theAkito/akito-libbash

if [[ "$EUID" != 0 ]]; then echoError "Please run me as root."; exit 1; fi;

bashrcFile="$1"
[[ -z "${bashrcFile}" ]] && echoError 'No ".bashrc" or "/etc/bash.bashrc" file provided. Try again.' && return 1

rm /usr/bin/autosudo
rm /var/lib/isatty.so

if [[ $(grep -q '###startpjKiGCPIHbdatOXedrfoHKdJePpBDpcbjGCUKsBiiXFDshOTaaFZrrQIaEXDBeCfw###' "$bashrcFile")$? == 0 ]]; then
  sed -i '/###startpjKiGCPIHbdatOXedrfoHKdJePpBDpcbjGCUKsBiiXFDshOTaaFZrrQIaEXDBeCfw###/,/###endCMKLEVnrlRNwvjeXMuWxiJQhhLdQaIhDMYJWigoyJGdjlqeTItYpFxnNCoRnMQlOa###/{//!d}' "${bashrcFile}"
  sed -i '/###startpjKiGCPIHbdatOXedrfoHKdJePpBDpcbjGCUKsBiiXFDshOTaaFZrrQIaEXDBeCfw###/d' "${bashrcFile}"
  sed -i '/###endCMKLEVnrlRNwvjeXMuWxiJQhhLdQaIhDMYJWigoyJGdjlqeTItYpFxnNCoRnMQlOa###/d'   "${bashrcFile}"
fi