class ListTweetsController < ApplicationController
  before_action :set_user

  def index
    list = @user.lists.find(params[:list_id])
    @tweets = list.tweets.order(id: :asc).page(params[:page])

    respond_to :html
  end
end
