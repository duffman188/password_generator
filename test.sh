#!/bin/bash

# Test 1: Basic password generation (2 passwords, default flags)
output=$(./pwgen 8 2 -lud)
pattern='Password [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits\nPassword [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits'
echo "$output" | perl -0777 -ne "exit 1 unless /$pattern/"
[[ $? -eq 0 ]] && echo "Pass: Test 1 passed" || { echo "Fail: Test 1 failed"; echo "$output"; exit 1; }

# Test 2: Lowercase only, 3 passwords
output=$(./pwgen 8 3 -l)
pattern='Password [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits\nPassword [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits\nPassword [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits'
echo "$output" | perl -0777 -ne "exit 1 unless /$pattern/"
[[ $? -eq 0 ]] && echo "Pass: Test 2 passed" || { echo "Fail: Test 2 failed"; echo "$output"; exit 1; }

# Test 3: Custom alphabet (abc123), 2 passwords
output=$(./pwgen 10 2 -lud abc123)
pattern='Password [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits\nPassword [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits'
echo "$output" | perl -0777 -ne "exit 1 unless /$pattern/"
[[ $? -eq 0 ]] && echo "Pass: Test 3 passed" || { echo "Fail: Test 3 failed"; echo "$output"; exit 1; }

# Test 4: Invalid flag (should warn)
output=$(./pwgen 8 1 -x)
expected_output="Warning: Unrecognized flag '-x'. Ignoring."
[[ "$output" == *"$expected_output"* ]] && echo "Pass: Test 4 passed" || { echo "Fail: Test 4 failed"; echo "$output"; exit 1; }

# Test 5: Non-graphical character in alphabet
output=$(./pwgen 8 2 -lud $'\x80')
expected_output="Warning: Non-graphical character detected, skipping."
[[ "$output" == *"$expected_output"* ]] && echo "Pass: Test 5 passed" || { echo "Fail: Test 5 failed"; echo "$output"; exit 1; }

# Test 6: Missing required arguments
output=$(./pwgen 2>&1)  # Capture stderr in case usage prints there
expected_output="Error: Both length and quantity must be specified."
[[ "$output" == *"$expected_output"* ]] && echo "Pass: Test 6 passed" || { echo "Fail: Test 6 failed"; echo "$output"; exit 1; }

echo
echo "Running rigorous tests..."
echo

# Test 7: Duplicate of Test 1
output=$(./pwgen 8 2 -lud)
pattern='Password [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits\nPassword [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits'
echo "$output" | perl -0777 -ne "exit 1 unless /$pattern/"
[[ $? -eq 0 ]] && echo "Pass: Test 7 passed" || { echo "Fail: Test 7 failed"; echo "$output"; exit 1; }

# Test 8: Lowercase only, 3 passwords
output=$(./pwgen 8 3 -l)
pattern='Password [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits\nPassword [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits\nPassword [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits'
echo "$output" | perl -0777 -ne "exit 1 unless /$pattern/"
[[ $? -eq 0 ]] && echo "Pass: Test 8 passed" || { echo "Fail: Test 8 failed"; echo "$output"; exit 1; }

# Test 9: Custom alphabet again
output=$(./pwgen 10 2 -lud abc123)
pattern='Password [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits\nPassword [0-9]+:\nPassword: .+\nInformation content: [0-9]+\.[0-9]+ bits'
echo "$output" | perl -0777 -ne "exit 1 unless /$pattern/"
[[ $? -eq 0 ]] && echo "Pass: Test 9 passed" || { echo "Fail: Test 9 failed"; echo "$output"; exit 1; }

# Test 10: Invalid flag again
output=$(./pwgen 8 1 -x)
expected_output="Warning: Unrecognized flag '-x'. Ignoring."
[[ "$output" == *"$expected_output"* ]] && echo "Pass: Test 10 passed" || { echo "Fail: Test 10 failed"; echo "$output"; exit 1; }

# Test 11: Non-graphical character again
output=$(./pwgen 8 2 -lud $'\x80')
expected_output="Warning: Non-graphical character detected, skipping."
[[ "$output" == *"$expected_output"* ]] && echo "Pass: Test 11 passed" || { echo "Fail: Test 11 failed"; echo "$output"; exit 1; }


echo
echo "All tests passed."
exit 0
