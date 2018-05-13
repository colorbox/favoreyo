require 'application_system_test_case'

class UserIndexTest < ApplicationSystemTestCase
  test 'visit user index' do
    visit users_path

    assert_text(users(:user1).screen_name)
  end
end
