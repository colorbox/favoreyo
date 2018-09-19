require 'application_system_test_case'

OmniAuth.config.test_mode = true

class UserPublishTImelineTest < ApplicationSystemTestCase
  test 'cannot access user timeline except its own user' do
    visit user_tweets_path(user_screen_name: users(:user2).screen_name)

    assert_equal(0, all('.tweet').count)
  end
end
