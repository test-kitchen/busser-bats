source "https://rubygems.org"

gemspec development_group: :test
group :test do
  gem "base64" # cucumber 9.x needs it; not a default gem on Ruby 4.0
  gem "cucumber", "~> 9.0"
  gem "rake", ">= 11.0"
  gem "rspec", "~> 3.2"
  gem "aruba"
end

group :development do
  gem "simplecov"
end

group :cookstyle do
  gem "cookstyle"
end
