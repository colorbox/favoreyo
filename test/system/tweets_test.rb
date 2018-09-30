require 'application_system_test_case'

class TweetsTest < ApplicationSystemTestCase
  include ScrolHelper

  setup do
    stub_request(:get, /https:\/\/api.twitter.com\/1.1\/statuses\/oembed.json.*/).to_return(
      body: File.read(File.join("test", "fixtures", "oembed.json")),
      headers: {content_type: 'application/json; charset=utf-8'})

    stub_request(:get, /https:\/\/api.twitter.com\/1.1\/statuses\/oembed.json\?id=977828032156024832/).to_return(
      body: File.read(File.join("test", "fixtures", "fetch_last_embed_tweet.json")),
      headers: {content_type: 'application/json; charset=utf-8'})
  end

  test 'visiting the tweets index and check loading additional tweets with scrol' do
    travel_to Time.zone.local(2018, 3, 5, 0, 00, 0)
    visit user_tweets_path(users(:user1).screen_name)
    last_tweet = all('.tweet').last

    assert_text 'Powerful cartoon'

    scroll_to(last_tweet)

    assert_text 'Unker Tweet'

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

    assert_equal(5, all(:button, value: 'ふぁぼる').count)

    last_tweet = all('.tweet').last
    scroll_to(last_tweet)

    last_tweet = timeline_logs(:timeline1_7).tweet
    find("div.fav-button[id='#{last_tweet.id}']")

    assert_equal(7, all(:button, value: 'ふぁぼる').count)
  end
end
