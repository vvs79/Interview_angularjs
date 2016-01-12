ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'devise'
require "minitest/reporters"
Minitest::Reporters.use!

module ActiveSupport
  class TestCase
    fixtures :all
    include FactoryGirl::Syntax::Methods
  end
end

module ActionController
  class TestCase
    include Devise::TestHelpers
  end
end
