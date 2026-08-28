require "aruba/cucumber"
require "busser/cucumber"

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.command_name "features"
end

# aruba 2 dropped @aruba_timeout_seconds; setting it in a Before hook is a
# no-op, which quietly left these commands on aruba's 15 second default.
# Installing a plugin and its gems into a cold sandbox does not always fit.
Aruba.configure do |config|
  config.exit_timeout = 60
end

After do |s|
  # Tell Cucumber to quit after this scenario is done - if it failed.
  # This is useful to inspect the 'tmp/aruba' directory before any other
  # steps are executed and clear it out.
  Cucumber.wants_to_quit = true if s.failed?
end
