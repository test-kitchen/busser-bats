require_relative "../../spec_helper"

require "shellwords"
require "busser/runner_plugin/bats"

describe Busser::RunnerPlugin::Bats do
  describe ".command_for" do
    it "puts the bats binary first and the suite second" do
      cmd = Busser::RunnerPlugin::Bats.command_for("/opt/busser/vendor/bats/bin/bats",
        "/opt/busser/suites/bats")

      _(cmd).must_equal "/opt/busser/vendor/bats/bin/bats /opt/busser/suites/bats"
    end

    # BUSSER_ROOT is user supplied, and Windows-style or otherwise spaced paths
    # do turn up. Unquoted, the shell would split the path and bats would be
    # handed arguments nobody intended.
    it "quotes a path containing spaces" do
      cmd = Busser::RunnerPlugin::Bats.command_for("/opt/busser/bin/bats",
        "/tmp/my tests/suites/bats")

      # Shellwords.split is what a shell would do with this string, so this
      # asserts the shell sees exactly two arguments rather than three.
      _(Shellwords.split(cmd)).must_equal ["/opt/busser/bin/bats", "/tmp/my tests/suites/bats"]
    end

    it "neutralises shell metacharacters in a path" do
      cmd = Busser::RunnerPlugin::Bats.command_for("/opt/busser/bin/bats",
        "/tmp/a;rm -rf x/bats")

      _(Shellwords.split(cmd)).must_equal ["/opt/busser/bin/bats", "/tmp/a;rm -rf x/bats"]
    end

    it "accepts Pathname arguments" do
      cmd = Busser::RunnerPlugin::Bats.command_for(Pathname.new("/a/bats"),
        Pathname.new("/b/suites/bats"))

      _(cmd).must_equal "/a/bats /b/suites/bats"
    end
  end
end
