#!/usr/bin/env ./tester
#
include math
include assert

DECIMAL="\
1023
-1023
+1023
+1
-1
0
+0
-0"

HEX="\
0xA0afFb
0x0
+0x1
-0x1"

OCTAL="\
017
00
007
+01
-01"

FLOATS="\
.
.1
1.
1.e1
+.1
-.1
.001
0.1
1.2
1.0
12e21
12e+21
12e-21
1.2e21"

NAN="\
00.0
a1
1a
' 1'
08
0xH
++1
--1
.+1
+
-
''
0.1.2
0..1
..1
1e1.2
1e01
e1
e
''
0X
0.1X
0.1.1X
0X.0
9X0x0"

testcase_begin
test_max_writes_first_parameter_if_only_one_is_passed() {
	assert that math_max 1 writes 1
}
test_max_writes_first_parameter_if_bigger_than_second_parameter() {
	assert that math_max 2 1 writes 2
}
test_max_writes_second_parameter_if_bigger_than_first_parameter() {
	assert that math_max 3 4 writes 4
}
test_max_writes_biggest_parameter_if_more_than_two_parameters_are_passed() {
	assert that math_max 5 6 7 9 8 writes 9
}
test_max_writes_nothing_if_no_parameter_is_passed() {
	assert that math_max writes ''
}

teststage_proceed
testdata is_int_positive_examples <<-EOF
	$DECIMAL
	$HEX
	$OCTAL
EOF

test_is_int_positive_examples() {
	assert math_is_int "$1"
}
test_is_int_0() {
	assert math_is_int 0
}
testdata is_int_negative_examples <<-EOF
	$NAN
	$FLOATS
EOF
test_is_int_negative_examples() {
	assert ! math_is_int "$1"
}

teststage_proceed
testdata is_float_positive_examples <<-EOF
	$DECIMAL
	$FLOATS
EOF
test_is_float_positive_examples() {
	assert math_is_float "$1"
}
testdata is_float_negative_examples <<-EOF
	$NAN
	$HEX
	$OCTAL
EOF
test_is_float_negative_examples() {
	assert ! math_is_float "$1"
}

testcase_end
