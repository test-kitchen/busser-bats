#!/usr/bin/env bats
# Runs on the machine under test through busser-bats, using the vendored bats.

@test "bats reached the machine under test" {
  run echo "hello"
  [ "$status" -eq 0 ]
  [ "$output" = "hello" ]
}

@test "the shell is usable" {
  run bash -c 'echo works'
  [ "$status" -eq 0 ]
  [ "$output" = "works" ]
}
