ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require_relative './support/scroll_helper'

class ActiveSupport::TestCase
  fixtures :all
end
