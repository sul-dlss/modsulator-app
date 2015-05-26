source "https://rubygems.org"

gem "grape", "0.11.0"
gem 'modsulator', '~> 0.0.5'
gem "rack-test", :require => "rack/test"
gem "bundler"
gem 'coveralls', require: false

group :test do
  gem "equivalent-xml", '>= 0.6.0'   # For ignoring_attr_values() with arguments
  gem "rake"
  gem "rspec", '>= 3.0'
end

group :deploy do
  gem "capistrano", '~> 3.0'
  gem 'capistrano-bundler', '~> 1.1'
  gem "lyberteam-capistrano-devel"
end
