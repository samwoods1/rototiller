source 'https://rubygems.org'
require 'rubygems'
# place all development, system_test, etc dependencies here

def location_for(place, fake_version = nil)
  if place =~ /^(git:[^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

# in the Rakefile, so we require it in all groups
rake_version = '>= 0.9.0'
if ENV['RAKE_VER']
  rake_version = "~> #{ENV['RAKE_VER']}"
end
gem 'rake'                 , "#{rake_version}"
gem "rototiller", *location_for(ENV['TILLER_VERSION'] || '~> 0.1.0')
gem 'rspec'                ,'~> 3.4.0'

group :system_tests do
  #gem 'beaker', :path => "../../beaker/"
  gem 'beaker'               ,'~> 2.22'
  gem 'beaker-hostgenerator'
  gem 'public_suffix', '<= 1.4.6'
end

group :development do
  gem 'simplecov'
  #Documentation dependencies
  gem 'yard'                 ,'~> 0'
  gem 'markdown'             ,'~> 0'
  # restrict version to enable ruby 1.9.3
  gem 'mime-types'           ,'~> 2.0'
  gem 'google-api-client'    ,'<= 0.9.4'
  gem 'activesupport'        ,'< 5.0.0'
  # restrict version to enable ruby 1.9.3 <-> 2.0.0
  if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('2.0.0')
    gem 'public_suffix'      ,'<= 1.4.6'
  end
end

local_gemfile = "#{__FILE__}.local"
if File.exists? local_gemfile
  eval(File.read(local_gemfile), binding)
end

user_gemfile = File.join(Dir.home,'.Gemfile')
if File.exists? user_gemfile
  eval(File.read(user_gemfile), binding)
end
