#!/bin/bash
BASH_INCLUDE_PATH=${PWD}/../src
test -z "${BASH_INCLUDE_INCLUDED}" || exit
source ${BASH_INCLUDE_PATH}/bash_include
include basic
test "basic" == "${BASH_INCLUDE_INCLUDED[0]}"
