require 'application_system_test_case'

class UsersSetFavoritesThresholdTest < ApplicationSystemTestCase
  test 'user can set their favorite_threshold' do

    visit users_path

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

    fill_in('user_favorite_threshold', with: '20')
    click_button('Update User')
    assert_equal(20, users(:user2).reload.favorite_threshold)
  end
end
