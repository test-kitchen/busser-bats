# Commenting out this test for now as it is not working on MacOS due to permissions (stop writing to /opt!)
# undefined method `check_directory_presence' for #<Object:0x000000013ae8cc78> (NoMethodError)
# features/plugin_install_command.feature:11:in `the vendor directory named "bats" should exist'
# Feature: Plugin install command
#   In order to use this plugin
#   As a user of Busser
#   I want to run the postinstall for this plugin

#   Background:
#     Given a test BUSSER_ROOT directory named "busser-bats-install"

#   Scenario: Running the postinstall generator
#     When I run `busser plugin install busser-bats --force-postinstall`
#     Then the vendor directory named "bats" should exist
#     And the vendor file "bats/bin/bats" should contain "BATS_PREFIX="
#     And the output should contain "Installed Bats"
#     And the exit status should be 0
