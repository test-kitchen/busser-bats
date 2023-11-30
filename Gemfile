source "https://rubygems.org"

gemspec

group :guard do
  gem "guard-cucumber"
  gem "guard-cane"
  gem "guard-rubocop"
end

group :test do
  gem "rake", ">= 11.0"
  gem "rspec", "~> 3.2"
end

group :development do
  gem "aruba"
  gem "countloc"
#   gem "rake"
  gem "simplecov"

  # style and complexity libraries are tightly version pinned as newer releases
  # may introduce new and undesireable style choices which would be immediately
  # enforced in CI
  gem "finstyle",  "1.2.0"
  gem "cane",      "2.6.2"
end

# group :chefstyle do
#   gem "chefstyle", "2.2.3"
# end
