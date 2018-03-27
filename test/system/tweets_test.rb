require "application_system_test_case"

class TweetsTest < ApplicationSystemTestCase
  test "visiting the tweets index" do
    travel_to Time.zone.local(2018, 3, 5, 0, 00, 0)
    visit tweets_path

    assert_text '使ったことのないgem'
    assert_text '勤怠自動打刻マン'
    travel_back
  end
end
