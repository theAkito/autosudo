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

import
  os,
  strutils,
  segfaults,
  sequtils

## Receive stream content from STDIN.
proc fgets(str: cstring, n: int, stream: File): cstring {.importc, header: "<stdio.h>", sideEffect.}

const
  resultTailLen = 200
  patterns = [
    "permission denied",
    "eacces",
    "pkg: insufficient privileges",
    "you cannot perform this operation unless you are root",
    "non-root users cannot",
    "operation not permitted",
    "root privilege",
    "this command has to be run under the root user.",
    "this operation requires root.",
    "requested operation requires superuser privilege",
    "must be run as root",
    "must run as root",
    "must be superuser",
    "must be root",
    "need to be root",
    "need root",
    "needs to be run as root",
    "only root can ",
    "authentication is required",
    "edspermissionerror",
    "you don't have access to the history db.",
    "you don't have write permissions",
    "use `sudo`",
    "sudorequirederror",
    "error: insufficient privileges"
  ]
let
  cmd = commandLineParams()
var
  buffer: cstring = newString(100).cstring

func takeLast(s: string, tailLen: int): string =
  if s.len > tailLen: s[^tailLen..^1] else: s

proc getOutput(noperm = "noperm"): string =
  try:
    while fgets(buffer, buffer.sizeof, stdin).len > 0:
      result &= $buffer
      let
        resultSlice = result.takeLast(resultTailLen).toLowerAscii()
        resultLastLineContainsPermissionDenied = patterns.anyIt(resultSlice.contains(it))
      if resultLastLineContainsPermissionDenied: return noperm
  except:
    result = getCurrentExceptionMsg()

if cmd.len == 0:
  echo getOutput()
else:
  echo getOutput(cmd[0])