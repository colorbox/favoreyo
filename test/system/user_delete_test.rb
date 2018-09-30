require 'application_system_test_case'

OmniAuth.config.test_mode = true

class UserDeleteTest < ApplicationSystemTestCase
  test 'deleting user from user index and deliting not affect other user tweet' do
    response_params = {
      uid: users(:user1).twitter_uid,
      info: {
        nickname: users(:user1).screen_name
      },
      credentials: {
        token: 'access_token',
        secret: 'access_token_secret'
      }
    }

    OmniAuth.config.add_mock(:twitter, response_params)

    visit users_path
    assert_text(users(:user1).screen_name)

    click_link('twitter login')

    click_link('mypage')

    assert_text('logout')

    assert_text('delete account')

    click_link('delete account')

    assert_no_text(users(:user1))
    assert_not_empty(users(:user2).tweets)
  end
end
