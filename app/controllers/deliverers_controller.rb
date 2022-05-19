class DeliverersController < ApplicationController
  before_action :set_user

  def new
    @deliverer = @user.deliverers.new
  end

  def index
    @deliverers = @user.deliverers
  end

  def edit
    @deliverer = @user.deliverers.build
  end

  def create
    @user.deliverers.create!(deliverer_params)
    redirect_to deliverers_path
  rescue
    render :new
  end

  def destroy
    target_deliverer = @user.deliverers.find(destroy_params[:id])
    target_deliverer.destroy!
    redirect_to deliverers_path
  end

  private

  def deliverer_params
    params.require(:deliverer).permit(:id, :name, :discord_token, :discord_channel_identifier)
  end

  def destroy_params
    params.permit(:id)
  end
end
