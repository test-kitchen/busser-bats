# -*- encoding: utf-8 -*-
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

require 'pathname'
require 'tmpdir'

require 'busser/runner_plugin'

# A Busser runner plugin for Bats.
#
# @author Fletcher Nichol <fnichol@nichol.ca>
#
class Busser::RunnerPlugin::Bats < Busser::RunnerPlugin::Base

  postinstall do
    tmp_root      = Pathname.new(Dir.mktmpdir("bats"))
    tarball_url   = "https://github.com/sstephenson/bats/archive/master.tar.gz"
    tarball_file  = tmp_root.join("bats.tar.gz")
    extract_root  = tmp_root.join("bats")
    dest_path     = vendor_path("bats")

    empty_directory(extract_root)
    get(tarball_url, tarball_file)
    inside(extract_root) do
      run!(%{gunzip -c "#{tarball_file}" | tar xf - --strip-components=1})
      run!(%{./install.sh #{dest_path}})
    end
    remove_dir(tmp_root)
  end

  def test
    run!("#{vendor_path('bats').join("bin/bats")} #{suite_path('bats')}")
  end
end
