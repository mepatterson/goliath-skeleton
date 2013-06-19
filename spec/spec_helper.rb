ENV["RACK_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start do
  add_filter '/config/'
  add_filter '/db/'
  add_filter '/spec/'
  add_filter '/app.rb'
  add_group 'Endpoints', 'app/api*'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Views', 'app/views'
end


require "rack/test"
require 'goliath/test_helper'
require './app'
require 'multi_json'
require 'oj'
require "shoulda/matchers"

require "./config/application.rb"


Goliath.env = :test
RSpec.configure do |c|
  c.include Goliath::TestHelper, example_group: { file_path: /spec\// }
end


puts "Running specs in #{ENV['RACK_ENV'].capitalize} environment..."

require 'database_cleaner'
RSpec.configure do |config|
  config.before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    # make sure we reset back to default locale in case a test left us set otherwise
    I18n.locale = :en
    DatabaseCleaner.clean
  end
end



# some helper methods for testing stuff
def hash_response
  MultiJson.load(last_response.body)
end

def response_data
  hash_response["data"]
end


