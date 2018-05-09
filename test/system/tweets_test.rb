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
end
