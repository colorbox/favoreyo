class DatesController < ApplicationController
  def index
    @selected_user = User.find_by(screen_name: params[:user_screen_name])
    @dates = @selected_user.tweets.select('date(tweets.created_at) as created_on')
               .group(:created_on)
               .order('created_on')
               .map {|tweet|tweet.created_on }
  end
end
