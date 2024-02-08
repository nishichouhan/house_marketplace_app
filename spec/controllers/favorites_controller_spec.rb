require 'rails_helper'
RSpec.describe FavoritesController, type: :controller do
include Devise::Test::ControllerHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:property) { FactoryBot.create(:property) }
  before do
    sign_in user
  end
  describe "POST #create" do
    it "creates a new favorite for the current user" do
        post :create, params: { property_id: property.id }
      expect(response).to redirect_to(favorites_path)
      expect(flash[:notice]).to eq('Property added to favorites.')
    end
  end
  describe "DELETE #destroy" do
    it "removes a favorite from the current user" do
      favorite = FactoryBot.create(:favorite, user: user, property: property)
      delete :destroy, params: { property_id: property.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Property removed from favorites.')
    end
    it "redirects to favorites path with an alert" do
      favorite = FactoryBot.create(:favorite, user: user, property: property)
      allow_any_instance_of(Favorite).to receive(:destroy).and_return(false)
      delete :destroy, params: { property_id: property.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Failed to remove property from favorites.')
    end
    it "redirects to favorites path with an alert" do
      delete :destroy, params: { property_id: 9999 }
      expect(response).to redirect_to(favorites_path)
      expect(flash[:alert]).to eq('Favorite not found.')
    end
  end
  describe "GET #index" do
    it "assigns all favorites of the current user to @favorites" do
      favorite = FactoryBot.create(:favorite, user: user, property: property)
      get :index
      expect(assigns(:favorites)).to eq([favorite])
    end
  end
end
