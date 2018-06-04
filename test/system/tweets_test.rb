require 'application_system_test_case'

class TweetsTest < ApplicationSystemTestCase
  include ScrolHelper

  test 'visiting the tweets index' do
    travel_to Time.zone.local(2018, 3, 5, 0, 00, 0)
    visit user_tweets_path(User.first.screen_name)
    last_tweet = all('.tweet').last
    scroll_to(last_tweet)

    assert_text '使ったことのないgem'
    assert_text '勤怠自動打刻マン'
    travel_back
  end

  setup do
    stub_request(:post, /https:\/\/api.twitter.com\/1.1\/favorites\/create.json.*/).to_return(
      body: File.read(File.join("test", "fixtures", "status.json")),
      headers: {content_type: 'application/json; charset=utf-8'})

    stub_request(:delete, /https:\/\/api.twitter.com\/1.1\/favorites\/destroy.json.*/).to_return(
      body: File.read(File.join("test", "fixtures", "status.json")),
      headers: {content_type: 'application/json; charset=utf-8'})
  end

  test ' there are no buttons for no login user' do
    visit user_tweets_path(User.first.screen_name)

    page.assert_no_selector(:button, 'ふぁぼる')
  end

  test 'add post create favorite' do
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

    click_link(users(:user1).screen_name)

    add_favorite_button = first(:button, value: 'ふぁぼる')

    assert_not_nil(add_favorite_button)

    add_favorite_button.click

    delete_favorite_button = first(:button, value: 'ふぁぼらない')
    assert_not_nil(delete_favorite_button)
  end
end
