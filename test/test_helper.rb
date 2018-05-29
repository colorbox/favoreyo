ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'
require_relative './support/scroll_helper'

WebMock.allow_net_connect!

class ActiveSupport::TestCase
  fixtures :all
end
