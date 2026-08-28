require "bundler/gem_tasks"
namespace :bats do
  # bats moved. sstephenson/bats was archived in 2016 at v0.4.0; bats-core is
  # the maintained fork and where every release since has come from.
  version = ENV.fetch("BATS_VERSION", "v1.14.0")
  url = "https://github.com/bats-core/bats-core/archive/refs/tags/#{version}.tar.gz"
  tarball = "tmp/bats-#{version}.tar.gz"
  vendor = "vendor/bats"

  # install.sh needs bin, libexec, lib and the two man pages. Everything else in
  # the tarball -- the test suite, the docs site, Docker and CI scaffolding --
  # is weight in a gem that gets copied onto every machine under test.
  keep = %w{bin libexec lib man install.sh uninstall.sh LICENSE.md README.md}

  desc "Vendors bats #{version} source code into gem codebase"
  task vendor: "#{vendor}/VERSION.txt"

  directory File.dirname(tarball)
  directory vendor

  file tarball => File.dirname(tarball) do |t|
    sh "curl", "--fail", "--silent", "--location", url, "--output", t.name
  end

  file "#{vendor}/VERSION.txt" => [vendor, tarball] do |t|
    abs_tarball = File.expand_path(tarball)
    Dir.chdir(vendor) do
      sh "tar", "xzf", abs_tarball, "--strip-components=1"
      (Dir.glob("*", File::FNM_DOTMATCH) - [".", "..", *keep]).each { |f| rm_rf(f) }
    end
    File.write(t.name, "#{url}\n")
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
