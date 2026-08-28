Feature: Test command
  In order to run tests written with bats
  As a user of Busser
  I want my tests to run when the bats runner plugin is installed

  Background:
    Given a test BUSSER_ROOT directory named "busser-bats-test"
    When I successfully run `busser plugin install busser-bats --force-postinstall`
    Given a suite directory named "bats"

  Scenario: A passing test suite
    Given a file in suite "bats" named "default.bats" with:
    """
    @test "runs something" {
      run echo "hello"
      [ "$status" -eq 0 ]
      [ "$output" == "hello" ]
    }

    """
    When I run `busser test bats`
    Then the output should contain:
    """
    1..1
    ok 1 runs something
    """
    And the exit status should be 0

  Scenario: A failing test suite
    Given a file in suite "bats" named "default.bats" with:
    """
    @test "fails something" {
      run which uhoh-whatzit-called
      [ "$status" -eq 0 ]
    }

    """
    When I run `busser test bats`
    Then the output should contain:
    """
    1..1
    not ok 1 fails something
    """
    And the exit status should not be 0
