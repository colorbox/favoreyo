require 'application_system_test_case'

class DeliverersTest < ApplicationSystemTestCase
  setup do
    response_params = {
      uid: users(:user1).twitter_uid,
      info: {
        nickname: users(:user1).screen_name
      },
      credentials: {
        token: users(:user1).access_token,
        secret: users(:user1).access_token_secret
      }
    }
    OmniAuth.config.add_mock(:twitter, response_params)
    visit users_path

    click_link('twitter login')

    click_link('mypage')

    click_link('deliverers')
  end

  test 'index deliveres' do
    assert_text('the first deliverer')
  end

  test 'delete deliverer' do
    click_button('delete')

    assert_no_text('the first deliverer')
  end

  test 'add deliverer' do
    click_link('Add deliverer')

    fill_in('deliverer_name', with: 'added deliverer')
    fill_in('deliverer_discord_token', with: 'token')
    fill_in('deliverer_discord_channel_identifier', with: 'ch')
    click_button('Create Deliverer')
  end
end
