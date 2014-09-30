# -*- encoding: utf-8 -*-

require "bundler/gem_tasks"
require "open-uri"

namespace :bats do

  version = ENV.fetch("BATS_VERSION", "v0.3.1")
  url = "https://github.com/sstephenson/bats/archive/#{version}.tar.gz"
  tarball = "tmp/bats-#{version}.tar.gz"
  vendor = "vendor/bats"

  desc "Vendors bats #{version} source code into gem codebase"
  task :vendor => "#{vendor}/VERSION.txt"

  directory File.dirname(tarball)
  directory vendor

  file tarball => File.dirname(tarball) do |t|
    begin
      src = open(url).binmode
      dst = open(t.name, "wb")
      IO.copy_stream(src, dst)
    ensure
      src.close
      dst.close
    end
  end

  file "#{vendor}/VERSION.txt" => [vendor, tarball] do |t|
    abs_tarball = File.expand_path(tarball)
    Dir.chdir(vendor) { sh "tar xzf #{abs_tarball} --strip-components=1" }
    rm_rf "#{vendor}/test"
    IO.write(t.name, url + "\n")
  end

  desc "Clean up a vendored bats in preparation for a new vendored version"
  task :clean do
    rm_rf [vendor, tarball]
  end
end

require "cucumber/rake/task"
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = ["features", "-x", "--format progress"]
end

desc "Run all test suites"
task :test => [:features]

require "finstyle"
require "rubocop/rake_task"
RuboCop::RakeTask.new(:style) do |task|
  task.options << "--display-cop-names"
end

require "cane/rake_task"
desc "Run cane to check quality metrics"
Cane::RakeTask.new do |cane|
  cane.canefile = "./.cane"
end

desc "Display LOC stats"
task :stats do
  puts "\n## Production Code Stats"
  sh "countloc -r lib"
  puts "\n## Test Code Stats"
  sh "countloc -r features"
end

desc "Run all quality tasks"
task :quality => [:cane, :style, :stats]

task :default => [:test, :quality]
