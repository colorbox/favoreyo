class ListsController < ApplicationController
  before_action :set_user

  def index
    @lists = @user.lists
  end
end
