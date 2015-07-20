#!/bin/bash
#

cd "$(dirname "$0")"
failed=()
for testcase in assert include err math msg opt path str test testcase var; do
	"./test-$testcase.sh" || failed+=("$testcase")
	echo
done

if (( ${#failed[@]} )); then
	printf 'failed testcases: %s\n' "${failed[*]}"
	exit 1
else
	printf 'all testcases passed.\n'
	exit 0
fi
