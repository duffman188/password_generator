#!/bin/bash

echo "Running tests..."
echo

# Test 1: Check basic password generation with default alphabet flags (-lud) and length 8, quantity 2
output=$(./pwgen 8 2 -lud)
expected_output="Password 1:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 2:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits"
if [[ "$output" =~ $expected_output ]]; then
    echo "Pass: Test 1 passed"
else
    echo "Fail: Test 1 failed"
    echo "$output"
    exit 1
fi

# Test 2: Check password generation with only lowercase letters (-l) and length 8, quantity 3
output=$(./pwgen 8 3 -l)
expected_output="Password 1:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 2:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 3:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits"
if [[ "$output" =~ $expected_output ]]; then
    echo "Pass: Test 2 passed"
else
    echo "Fail: Test 2 failed"
    echo "$output"
    exit 1
fi

# Test 3: Check password generation with a custom alphabet and length 10, quantity 2
output=$(./pwgen 10 2 -lud abc123)
expected_output="Password 1:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 2:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits"
if [[ "$output" =~ $expected_output ]]; then
    echo "Pass: Test 3 passed"
else
    echo "Fail: Test 3 failed"
    echo "$output"
    exit 1
fi

# Test 4: Check for invalid flag (should ignore or print a warning)
output=$(./pwgen 8 1 -x)
expected_output="Warning: Unrecognized flag '-x'. Ignoring."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 4 passed"
else
    echo "Fail: Test 4 failed"
    echo "$output"
    exit 1
fi

# Test 5: Check for non-graphical characters in the alphabet (should be skipped)
output=$(./pwgen 8 2 -lud $'\x80')
expected_output="Warning: Non-graphical character detected, skipping."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 5 passed"
else
    echo "Fail: Test 5 failed"
    echo "$output"
    exit 1
fi

# Test 6: Check for missing required arguments (should exit with error)
output=$(./pwgen)
expected_output="Error: Both length and quantity must be specified."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 6 passed"
else
    echo "Fail: Test 6 failed"
    echo "$output"
    exit 1
fi

echo
echo "Running rigorous tests..."
echo

# Test 1: Check basic password generation with default alphabet flags (-lud) and length 8, quantity 2
output=$(./pwgen 8 2 -lud)
expected_output="Password 1:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 2:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits"
if [[ "$output" =~ $expected_output ]]; then
    echo "Pass: Test 7 passed"
else
    echo "Fail: Test 7 failed"
    echo "$output"
    exit 1
fi

# Test 2: Check password generation with only lowercase letters (-l) and length 8, quantity 3
output=$(./pwgen 8 3 -l)
expected_output="Password 1:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 2:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 3:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits"
if [[ "$output" =~ $expected_output ]]; then
    echo "Pass: Test 8 passed"
else
    echo "Fail: Test 8 failed"
    echo "$output"
    exit 1
fi

# Test 3: Check password generation with a custom alphabet (lowercase letters + digits) and length 10, quantity 2
output=$(./pwgen 10 2 -lud abc123)
expected_output="Password 1:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 2:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits"
if [[ "$output" =~ $expected_output ]]; then
    echo "Pass: Test 9 passed"
else
    echo "Fail: Test 9 failed"
    echo "$output"
    exit 1
fi

# Test 4: Check for invalid flag (should ignore or print a warning)
output=$(./pwgen 8 1 -x)
expected_output="Warning: Unrecognized flag '-x'. Ignoring."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 10 passed"
else
    echo "Fail: Test 10 failed"
    echo "$output"
    exit 1
fi

# Test 5: Check for non-graphical characters in the alphabet (should be skipped)
output=$(./pwgen 8 2 -lud $'\x80')
expected_output="Warning: Non-graphical character detected, skipping."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 11 passed"
else
    echo "Fail: Test 11 failed"
    echo "$output"
    exit 1
fi

# Test 6: Test password generation with a very large password length (e.g., 1000)
output=$(./pwgen 1000 1 -lud)
if [[ ${#output} -gt 1000 ]]; then
    echo "Fail: Test 12 failed, password exceeds length limit"
    echo "$output"
    exit 1
else
    echo "Pass: Test 12 passed"
fi

# Test 7: Test password generation with a large quantity (e.g., 100 passwords)
output=$(./pwgen 8 100 -lud)
if [[ $(echo "$output" | grep -c "Password") -eq 100 ]]; then
    echo "Pass: Test 13 passed"
else
    echo "Fail: Test 13 failed"
    echo "$output"
    exit 1
fi

# Test 8: Test with no -lud flags and a custom alphabet (should default to all luds)
output=$(./pwgen 8 2 abc123)
expected_output="Password 1:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 2:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits"
if [[ "$output" =~ $expected_output ]]; then
    echo "Pass: Test 14 passed"
else
    echo "Fail: Test 14 failed"
    echo "$output"
    exit 1
fi

# Test 9: Test for alphabet with mixed custom input (symbols, upper, lower, digits)
output=$(./pwgen 10 2 -lud @#$%abcd1234XYZ)
expected_output="Password 1:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits\n\nPassword 2:.*\nPassword:.*\nInformation content: [0-9]+\.[0-9]+ bits"
if [[ "$output" =~ $expected_output ]]; then
    echo "Pass: Test 15 passed"
else
    echo "Fail: Test 15 failed"
    echo "$output"
    exit 1
fi

# Test 10: Test with empty alphabet (should result in an error or no passwords generated)
output=$(./pwgen 8 1 "")
expected_output="Error: No valid characters in alphabet."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 16 passed"
else
    echo "Fail: Test 16 failed"
    echo "$output"
    exit 1
fi

# Test 11: Test with non-ASCII characters in the alphabet
output=$(./pwgen 8 2 -lud "abc\x80")
expected_output="Warning: Non-graphical character detected, skipping."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 17 passed"
else
    echo "Fail: Test 17 failed"
    echo "$output"
    exit 1
fi

# Test 12: Test invalid command (missing arguments, should show error)
output=$(./pwgen)
expected_output="Error: Both length and quantity must be specified."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 18 passed"
else
    echo "Fail: Test 18 failed"
    echo "$output"
    exit 1
fi

# Test 13: Test with large password length (1000 characters)
output=$(./pwgen 1000 1 -lud)
if [[ ${#output} -gt 1000 ]]; then
    echo "Fail: Test 13 failed, password exceeds length limit"
    echo "$output"
    exit 1
else
    echo "Pass: Test 13 passed"
fi

# Test 14: Large quantity of passwords (100 passwords)
output=$(./pwgen 8 100 -lud)
if [[ $(echo "$output" | grep -c "Password") -eq 100 ]]; then
    echo "Pass: Test 14 passed"
else
    echo "Fail: Test 14 failed"
    echo "$output"
    exit 1
fi

# Test 15: Test with empty alphabet (should show an error)
output=$(./pwgen 8 1 "")
expected_output="Error: No valid characters in alphabet."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 15 passed"
else
    echo "Fail: Test 15 failed"
    echo "$output"
    exit 1
fi

# Test 16: Non-ASCII characters in the alphabet (should trigger a warning)
output=$(./pwgen 8 2 -lud "abc\x80")
expected_output="Warning: Non-graphical character detected, skipping."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 16 passed"
else
    echo "Fail: Test 16 failed"
    echo "$output"
    exit 1
fi

# Test 17: Invalid command (missing arguments)
output=$(./pwgen)
expected_output="Error: Both length and quantity must be specified."
if [[ "$output" == *"$expected_output"* ]]; then
    echo "Pass: Test 17 passed"
else
    echo "Fail: Test 17 failed"
    echo "$output"
    exit 1
fi

echo
echo "All tests passed."
exit 0
