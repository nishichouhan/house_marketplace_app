# frozen_string_literal: true

class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  before_action :authenticate_admin!, only: %i[edit update destroy]

  def index
    @properties = Property.all
    filter_properties
    @properties = @properties.paginate(page: params[:page], per_page: 10)
    render 'index'
  end

  def update
    if @property.update(property_params)
      attach_image if params[:property][:image].present?
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to properties_path, alert: 'Property not found.'
  rescue StandardError => e
    flash.now[:alert] = "Error updating property: #{e.message}"
    render :edit
  end

  def destroy
    @property.destroy
    redirect_to properties_path, notice: 'Property was successfully deleted.'
  rescue ActiveRecord::RecordNotFound
    redirect_to properties_path, alert: 'Property not found.'
  rescue StandardError => e
    redirect_to properties_path, alert: "Error deleting property: #{e.message}"
  end

  private

  def property_params
    params.require(:property).permit(:property_type, :city, :district, :bedrooms, :rent_per_month, :mrt_line,
                                     :description, :net_size, :image)
  end

  def set_property
    @property = Property.find(params[:id])
  end

  def authenticate_admin!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user&.admin?
  end

  def filter_properties
    conditions = {}
    conditions[:city] = params[:city] if params[:city].present?
    conditions[:district] = params[:district] if params[:district].present?
    conditions[:net_size] = params[:net_size] if params[:net_size].present?
    conditions[:rent_per_month] = params[:rent_per_month] if params[:rent_per_month].present?

    @properties = @properties.where(conditions)
  end

  def attach_image
    @property.image.attach(params[:property][:image])
  end
end
