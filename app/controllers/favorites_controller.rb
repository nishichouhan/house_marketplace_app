class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorites.new(property_id: params[:property_id])
    if @favorite.save
      redirect_to favorites_path, notice: 'Property added to favorites.'
    else
      redirect_to root_path, alert: 'Failed to add property to favorites.'
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(property_id: params[:property_id])
    @favorite.destroy
    redirect_to favorites_path, notice: 'Property removed from favorites.'
  end

  def index
    @favorites = current_user.favorites
  end
end