#
# Author:: Fletcher Nichol (<fnichol@nichol.ca>)
#
# Copyright (C) 2013, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "pathname" unless defined?(Pathname)
require "shellwords" unless defined?(Shellwords)

require "busser/runner_plugin"

# A Busser runner plugin for Bats.
#
# @author Fletcher Nichol <fnichol@nichol.ca>
#
class Busser::RunnerPlugin::Bats < Busser::RunnerPlugin::Base

  postinstall do
    inside(Pathname.new(__FILE__).dirname.join("../../../vendor/bats")) do
      FileUtils.ln_sf("../libexec/bats", "bin/bats")
      run!(%{./install.sh #{vendor_path("bats")}})
    end
  end

  # Builds the bats invocation.
  #
  # Both paths are quoted: the Busser root is user supplied through
  # BUSSER_ROOT, and an unquoted path containing a space would be split into
  # two arguments by the shell and silently run the wrong thing.
  #
  # @param bats_bin [String, Pathname] the vendored bats executable
  # @param suite [String, Pathname] the suite directory holding the .bats files
  # @return [String] the command to run
  def self.command_for(bats_bin, suite)
    %{#{Shellwords.escape(bats_bin.to_s)} #{Shellwords.escape(suite.to_s)}}
  end

  # Runs the suite's .bats files through the vendored bats.
  #
  # @return [void]
  def test
    run!(self.class.command_for(vendor_path("bats").join("bin/bats"), suite_path("bats")))
  end
end
