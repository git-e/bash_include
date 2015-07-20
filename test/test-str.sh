#!./tester
#
include str
include assert

testcase_begin
test_str_escape() {
	assert that str_escape "'" writes "''\'''"
}

teststage_proceed
test_str_is_empty() {
	assert str_is_empty ""
	assert ! str_is_empty "x"
	assert str "" is empty
	assert ! str "x" is empty
	assert ! str "" is not empty
	assert str "x" is not empty
}

teststage_proceed
test_str_contains_returns_true_for_equal_parameters() {
	assert str_contains a a
}

test_str_contains_returns_false_for_different_characters() {
	assert that str_contains a b returns 1
}

test_str_contains_returns_true_if_second_parameter_is_substring_of_first_parameter() {
	assert str_contains aba b
}

test_str_contains_returns_false_if_second_parameter_is_substring_of_second_parameter() {
	assert ! str_contains b aba
}
test_str_contains_returns_true_for_star() {
	assert str_contains a '*'
}

test_str_begins_with() {
	assert str_begins_with "ab" "a"
	assert ! str_begins_with "ab" "b"
	assert str "ab" begins with "a"
	assert str "ab" begins not with "b"
}
test_str_ends_with() {
	assert str_ends_with "ab" "b"
	assert ! str_ends_with "ab" "a"
	assert str "ab" ends with "b"
	assert str "ab" ends not with "a"
}

teststage_proceed
test_str_quoted_not() {
	assert str "not false" contains {not}
	assert str "true" contains not {not}
	assert str "{not}" equals not {not}
	assert str "{not}" equals {{not}}
}

test_str_connected_queries() {
	assert str "ab" contains "a" and contains "b"
	assert str "ac" contains "a" and contains not "b"
	assert ! str "ab" contains "a" and contains not "b"
	assert ! str "bc" contains "a" and contains not "b"
}
teststage_proceed
test_str_syntax_errors() {
	assert ! str ab c
	assert ! str ab is c
	assert ! str ab is not c
	assert ! str ab is not not
	assert ! str ab is not empty c
	assert ! str ab begins a
	assert ! str ab begins not b
}
testcase_end
