require 'application_system_test_case'

class DateSeparatedTweetsTest < ApplicationSystemTestCase
  test 'tweets separated with dates' do
    visit users_path

    click_link(users(:user4).screen_name)

    assert_content('2018-03-03')
    assert_content('2018-03-04')
  end
end

