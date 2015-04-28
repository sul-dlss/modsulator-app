source "https://rubygems.org"

gem "grape", "0.11.0"
gem "modsulator", :git => 'https://github.com/sul-dlss/modsulator'
gem "rack-test", :require => "rack/test"

group :test do
  gem "equivalent-xml", '>= 0.6.0'   # For ignoring_attr_values() with arguments
  gem "rspec"
end

group :deploy do
  gem "capistrano", '~> 3.0'
  gem 'capistrano-bundler', '~> 1.1'
  gem "lyberteam-capistrano-devel"
end
