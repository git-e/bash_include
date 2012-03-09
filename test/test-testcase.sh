#!./tester
#

testcase_begin "$@"

test_empty_testcase() {
	testcase_begin
	testcase_end
}

test_testcase_fails_if_test_fails() {
	testcase_begin
	test_failingTest() {
		false
	}
	testcase_end
	assertLastCommandFailed
}

test_testcase_passes_with_passing_test() {
	testcase_begin
	test_passingTest() {
		:
	}
	testcase_end
}

teststage_proceed
test_testcase_unsets_previous_test_functions() {
	test_dontRunMe() {
		false
	}
	testcase_begin
	testcase_end
}

teststage_proceed
test_testcase_unsets_previous_test_functions() {
	testcase_begin
	test_failingTest() {
		false
	}
	teststage_proceed
	test_skippedTest() {
		:
	}
	testcase_end
	assertEquals 2 $_test_runCount
	assertEquals 1 $_test_failedCount
	assertEquals 1 $_test_skippedCount
	assertEquals 0 $_test_passedCount
}

teststage_proceed
test_multiline_test_output() {
	output=$(
		testcase_begin
		test_printingTest() {
			printf 'line1\nline2\n'
		}
		testcase_end
	)
	assertEquals "printingTest ${_test_PASSED}:
> line1
> line2" "${output}"
}

testcase_end "$@"