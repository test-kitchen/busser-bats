require "aruba/cucumber"
require "busser/cucumber"

# aruba 2 dropped @aruba_timeout_seconds; setting it in a Before hook is a
# no-op, which quietly left these commands on aruba's 15 second default.
# Installing a plugin and its gems into a cold sandbox does not always fit.
Aruba.configure do |config|
  config.exit_timeout = 60
end
