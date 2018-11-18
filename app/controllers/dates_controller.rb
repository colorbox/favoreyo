class DatesController < ApplicationController
  before_action :set_user

  def index
    @dates = @user.tweets.select('date(tweets.created_at) as created_on')
               .group(:created_on)
               .order('created_on')
               .map {|tweet|tweet.created_on }
  end
end
