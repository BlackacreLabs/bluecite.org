require 'rubygems'

namespace :barista do
  task :brew do
    require 'barista'
    Barista.compile_all! true, false
  end
end

unless ENV['RACK_ENV'] == 'production'
  require 'cucumber'
  require 'cucumber/rake/task'
  require 'rspec/core/rake_task'

  Cucumber::Rake::Task.new(:features) 

  RSpec::Core::RakeTask.new(:spec)

  task :default => [:features, :spec]
end

namespace :db do
  desc "remove all records from the database"
  task :clean do
    require_relative 'environment'
    require 'database_cleaner'
    DatabaseCleaner.orm = "mongoid" 
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
end
