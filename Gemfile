source 'https://ruby.taobao.org'
#source 'http://ruby.taobao.org'
gem 'rails', '3.2.16'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'mysql2', '0.3.18'
# gem 'unicorn'
gem 'passenger'
gem "cancan"
gem 'kaminari'
# gem "therubyracer"

gem 'client_side_validations'
gem 'jquery-rails', '~> 2.0.0'
gem 'bcrypt-ruby', '~> 3.0.0'
# Refinery CMS
gem 'refinerycms', '~> 2.0.0', :git => 'git://github.com/refinery/refinerycms.git', :branch => '2-0-stable'
# Specify additional Refinery CMS Extensions here (all optional):
gem 'refinerycms-i18n', '~> 2.0.0'
#  gem 'refinerycms-blog', '~> 2.0.0'
#  gem 'refinerycms-inquiries', '~> 2.0.0'
#  gem 'refinerycms-search', '~> 2.0.0'
#  gem 'refinerycms-page-images', '~> 2.0.0'
gem 'refinerycms-members', :path => 'vendor/extensions'
gem 'refinerycms-wines', :path => 'vendor/extensions'
gem 'refinerycms-wine_groups', :path => 'vendor/extensions'
gem 'refinerycms-user_groups', :path => 'vendor/extensions'
gem 'refinerycms-test_papers', :path => 'vendor/extensions'

# export exel
gem 'axlsx'
gem 'acts_as_xlsx'
gem 'axlsx_rails'
gem 'memcache-client'

group :assets, :production do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git', :tag => 'v2.2.7'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platforms => :ruby
  gem "less-rails"
end

group :development, :test do
  gem 'pry'  # "binding.pry" in action
  gem 'sextant'
end

group :development do
  gem 'capistrano', '3.4.0'
  gem 'capistrano-rails'
  gem 'capistrano3-puma'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
end

group :production do
  gem 'rack-cache', :require => 'rack/cache'
  # gem 'puma'
end