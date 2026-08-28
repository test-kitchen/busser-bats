source "https://rubygems.org"

gemspec development_group: :test
group :test do
  gem "base64" # cucumber needs it; not a default gem on Ruby 4.0
  gem "cucumber", ">= 11.1"
  gem "rake", ">= 11.0"
  gem "aruba", ">= 2.0"
end

group :development do
  gem "simplecov"
end

group :cookstyle do
  gem "cookstyle", ">= 9.0.0"
end
