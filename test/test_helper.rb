ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # This supposedly will force an arbitrary order of fixture loading...
  # fixtures %w[users groups bookmarks]

  # Add more helper methods to be used by all tests here...
end
