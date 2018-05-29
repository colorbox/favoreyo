require 'application_system_test_case'

OmniAuth.config.test_mode = true

class UserIndexTest < ApplicationSystemTestCase
  setup do
    stub_request(:get, 'https://api.twitter.com/1.1/statuses/home_timeline.json?count=200').to_return(
      body: File.read(File.join("test", "fixtures", "statuses.json")),
      headers: {content_type: 'application/json; charset=utf-8'})

    stub_request(:get, 'https://api.twitter.com/1.1/statuses/home_timeline.json?count=200&max_id=244111636544225280').to_return(
      body: File.read(File.join("test", "fixtures", "statuses.json")),
      headers: {content_type: 'application/json; charset=utf-8'})


  end

  test 'user login triggers tweet fetching user3 tweets count up 1' do
    response_params = {
      uid: users(:user3).twitter_uid,
      info: {
        nickname: users(:user3).screen_name
      },
      credentials: {
        token: 'access_token',
        secret: 'access_token_secret'
      }
    }
    OmniAuth.config.add_mock(:twitter, response_params)

    visit users_path

    assert(users(:user3).tweets, 0)

    click_link('twitter login')

    assert_text('logout')

    assert(users(:user3).tweets, 1)
  end
end
