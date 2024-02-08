class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favorite, only: [:destroy]

  def create
    @favorite = current_user.favorites.new(property_id: params[:property_id])
    if @favorite.save
      redirect_to favorites_path, notice: 'Property added to favorites.'
    else
      redirect_to root_path, alert: 'Failed to add property to favorites.'
    end
  end

  def destroy
    if @favorite
      if @favorite.destroy
        redirect_to root_path, notice: 'Property removed from favorites.'
      else
        redirect_to root_path, alert: 'Failed to remove property from favorites.'
      end
    else
      redirect_to favorites_path, alert: 'Favorite not found.'
    end
  end

  def index
    @favorites = current_user.favorites
  end

  private

  def set_favorite
    @favorite = current_user.favorites.find_by(property_id: params[:property_id])
  end
end

