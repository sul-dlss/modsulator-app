source "https://rubygems.org"

gem "grape"
gem 'modsulator'
gem "bundler"

group :test do
  gem "equivalent-xml", '>= 0.6.0'   # For ignoring_attr_values() with arguments
  gem "rake"
  gem "rspec", '>= 3.0'
  gem "rack-test", :require => "rack/test"
  gem 'coveralls', require: false
end

group :deploy do
  gem "capistrano", '~> 3.0'
  gem 'capistrano-bundler', '~> 1.1'
  gem "lyberteam-capistrano-devel"
end
