require "bundler/gem_tasks"

namespace :bats do
  desc "Vendor bats into gem codebase"
  task :vendor do
    version = ENV.fetch("BATS_VERSION", "v1.10.0")
    url = "https://github.com/bats-core/bats-core/archive/refs/tags/#{version}.tar.gz"
    tarball = "tmp/bats-#{version}.tar.gz"
    vendor = "vendor/bats"

    desc "Vendors bats #{version} source code into gem codebase"
    task vendor: "#{vendor}/VERSION.txt"

    directory File.dirname(tarball)
    directory vendor

    sh "curl -s -L #{url} -o #{tarball}"

    file "#{vendor}/VERSION.txt" => [vendor, tarball] do |t|
      abs_tarball = File.expand_path(tarball)
      Dir.chdir(vendor) { sh "tar xzf #{abs_tarball} --strip-components=1" }
      rm_rf "#{vendor}/test"
      IO.write(t.name, url + "\n")
    end
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
task test: [:features]

desc "Display LOC stats"
task :stats do
  puts "\n## Production Code Stats"
  sh "countloc -r lib"
  puts "\n## Test Code Stats"
  sh "countloc -r features"
end

task default: %i{test}
