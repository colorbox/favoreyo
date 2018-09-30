require 'application_system_test_case'

class UsersIndexTest < ApplicationSystemTestCase
  test 'visit user index and there is user name' do
    visit users_path

    assert_text(users(:user1).screen_name)
  end

  test 'publish timeline makes show user name on user index' do
    visit users_path

    assert_no_text(users(:user2).screen_name)

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

    assert_text(users(:user2).screen_name)
  end
end
