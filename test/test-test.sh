#!./tester
#
testcase_begin "$@"
test_runTest() {
	true
}

teststage_proceed
test_testFails() {
	_test_runTest "" false
	test $? != 0
}

teststage_proceed
test_testEnvironmentIndepdency_1_set_value() {
	value=1;
}

test_testEnvironmentIndepdency_2_assert_value_is_unset() {
	! test "${value+set}"
}

teststage_proceed
test_testIOIndepdency_1_open_fd() {
	exec 3>/dev/null
}

test_testIOIndepdency_2_write_to_fd_fails() {
	! echo x 1>&3
}

testx_dontRunMe() {
	false
}

teststage_proceed
testdata "testdata_is_passed_to_test_function" <<-EOF
	1 "a"
	2 "b"
EOF

test_testdata_is_passed_to_test_function() {
    if (( $# != 2 )); then
        echo "wrong parameter count: $#"
        false
    fi
    case "$1:$2" in
        1:a|2:b) ;;
        *)
            echo "bad test data: $1:$2"
            return 1
        ;;
    esac
}

test_function_is_called_once_for_each_line_in_test_data() {
	testcase_begin
	testdata "with_testdata" <<<$'1\n2\n3'
	test_with_testdata() {
		:
	}
	testcase_end

	if (( _test_runCount != 3 )); then
		echo 3 != "$_test_runCount"
		return 1
	fi
}

teststage_proceed
test_testdata_fails_fast_if_data_can_not_be_parsed() {
	! (
		testdata "it's broken" <<-EOF
			1 ; 2
		EOF
	)
}

testcase_end "$@"
