require "bundler/gem_tasks"
require "open-uri"

namespace :bats do
  version = ENV.fetch("BATS_VERSION", "v0.4.0")
  url = "https://github.com/sstephenson/bats/archive/#{version}.tar.gz"
  tarball = "tmp/bats-#{version}.tar.gz"
  vendor = "vendor/bats"

  desc "Vendors bats #{version} source code into gem codebase"
  task vendor: "#{vendor}/VERSION.txt"

  directory File.dirname(tarball)
  directory vendor

  file tarball => File.dirname(tarball) do |t|
    src = open(url).binmode
    dst = open(t.name, "wb")
    IO.copy_stream(src, dst)
  ensure
    src.close
    dst.close
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

require "rake/testtask"
Rake::TestTask.new(:unit) do |t|
  t.libs.push "lib"
  t.test_files = FileList["spec/**/*_spec.rb"]
  t.verbose = true
end

require "cucumber/rake/task"
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = ["features", "--format progress", "--fail-fast"]
end

# yard lives in the :development group, which CI omits when it runs the tests.
# Requiring it unconditionally would make `rake test` fail there, so the real
# task is only defined when yard is installed and a stub explains its absence
# otherwise. Nothing in CI gates on documentation.
begin
  require "yard"

  YARD::Rake::YardocTask.new(:doc) do |t|
    t.files = ["lib/**/*.rb"]
    t.options = ["--output-dir", "doc", "--markup", "markdown"]
  end
rescue LoadError
  desc "Generate YARD documentation (install the development group first)"
  task :doc do
    abort "yard is not available. Run `bundle install --with development` first."
  end
end

desc "Run all test suites"
task test: %i{unit features}

task default: %i{test}
