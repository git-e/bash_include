#!/bin/bash
#

for testcase in include test assert testcase err var msg opt path; do
	"./test-$testcase.sh" || exit
done

printf '\n* all test passed *\n'