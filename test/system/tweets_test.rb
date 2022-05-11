require 'application_system_test_case'

class TweetsTest < ApplicationSystemTestCase
  include ScrollHelper

  setup do
    stub_request(:get, /https:\/\/api.twitter.com\/1.1\/statuses\/oembed.json\?id=.*/).to_return(
      body: File.read(File.join("test", "fixtures", "oembed.json")),
      headers: {content_type: 'application/json; charset=utf-8'})
  end

  test 'visiting the tweets index and check loading additional tweets with scrol' do
    travel_to Time.zone.local(2018, 3, 5, 0, 00, 0)
    visit user_tweets_path(users(:user1).screen_name)

    assert_equal 5, all('.tweet').count

    last_tweet = all('.tweet').last

    sleep(3)

    scroll_to(last_tweet)

    sleep(3)

    assert_equal 9, all('.tweet').count

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
    visit user_tweets_path(users(:user1).screen_name)

    page.assert_no_selector(:button, 'ふぁぼる')
  end

  test 'ふぁぼる button get change ふぁぼらない when user click on it' do
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

    click_link('all tweets')

    add_favorite_button = first(:button, value: 'ふぁぼる')

    assert_not_nil(add_favorite_button)

    add_favorite_button.click

    delete_favorite_button = first(:button, value: 'ふぁぼらない')
    assert_not_nil(delete_favorite_button)
  end

  test 'scroll load will load also ふぁぼる buttons' do
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

    click_link('all tweets')

    assert_equal(5, all(:button, value: 'ふぁぼる').count)

    last_tweet = all('.tweet').last
    sleep(3)
    scroll_to(last_tweet)

    last_tweet = timeline_logs(:timeline1_7).tweet

    sleep(10)

    assert_not_nil(find("div.fav-button[id='#{last_tweet.id}']"))

    assert_equal(7, all(:button, value: 'ふぁぼる').count)
  end
end
