class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:edit, :update, :destroy]


  def index
    @properties = Property.all

    if params[:type].present?
      @properties = @properties.where(type: params[:type])
    end

    if params[:city].present?
      @properties = @properties.where(city: params[:city])
    end

    if params[:district].present?
      @properties = @properties.where(district: params[:district])
    end

    if params[:net_size].present?
      @properties = @properties.where(net_size: params[:net_size])
    end

    if params[:rent_per_month].present?
      @properties = @properties.where(rent_per_month: params[:rent_per_month])
    end

    @properties = @properties.paginate(page: params[:page], per_page: 5)

    render "index"
  end


  def edit
    @property = Property.find(params[:id])
  end

  
  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      if params[:property][:image].present?
        @property.image.attach(params[:property][:image])
      end
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_path, notice: 'Property was successfully deleted.'
  end


  private
    def property_params
      params.require(:property).permit(:title, :city, :district, :bedrooms, :rent, :mrt_line, :image)
    end

    def set_property
      @property = Property.find(params[:id])
    end

    def authenticate_admin!
      redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.user_type == "admin"
    end
end