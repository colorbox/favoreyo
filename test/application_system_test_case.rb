require 'test_helper'
require 'support/capybara'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400], options: {url: "http://chrome:4444/wd/hub"}
end
