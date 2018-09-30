require 'application_system_test_case'

OmniAuth.config.test_mode = true

class UserPublishTImelineTest < ApplicationSystemTestCase
  test 'cannot access user timeline except its own user' do
    visit user_tweets_path(user_screen_name: users(:user2).screen_name)

    assert_equal(0, all('.tweet').count)

    response_params = {
      uid: users(:user2).twitter_uid,
      info: {
        nickname: users(:user2).screen_name
      },
      credentials: {
        token: users(:user2).access_token,
        secret: users(:user2).access_token_secret
      }
    }
    OmniAuth.config.add_mock(:twitter, response_params)

    visit users_path

    click_link('twitter login')
    click_link('mypage')
    click_link('timeline')

    assert_equal(5, all('.tweet').count)
  end

  test 'user publish timeline and anyone can see it' do
    visit users_path

    assert_no_text(users(:user2).screen_name)

    assert_equal(0, all('.tweet').count)

    response_params = {
      uid: users(:user2).twitter_uid,
      info: {
        nickname: users(:user2).screen_name
      },
      credentials: {
        token: users(:user2).access_token,
        secret: users(:user2).access_token_secret
      }
    }
    OmniAuth.config.add_mock(:twitter, response_params)

    visit users_path

    click_link('twitter login')
    click_link('mypage')
    click_button('publish timeline')
    click_link('logout')
    visit users_path

    click_link(users(:user2).screen_name)

    assert_equal(5, all('.tweet').count)
  end
end
