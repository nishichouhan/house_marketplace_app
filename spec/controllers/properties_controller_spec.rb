require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
include Devise::Test::ControllerHelpers
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:property) { FactoryBot.create(:property) }

  describe "GET #index" do

    context "when user is signed in" do
      before do
        sign_in user
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "PATCH #update" do
    context "when an unexpected error occurs" do
      before do
        sign_in admin
        allow_any_instance_of(Property).to receive(:update).and_raise(StandardError, "Unexpected error")
      end

      it "renders the edit template with an alert" do
        patch :update, params: { id: property.id, property: { title: "Fail Update" } }
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to include("Error updating property: Unexpected error")
      end
    end
  end


  describe "DELETE #destroy" do
    context "as an admin user" do
      before { sign_in admin }

      it "deletes the property and redirects" do
        delete :destroy, params: { id: property.id }
        expect(response).to redirect_to(properties_path)
        expect(flash[:notice]).to eq('Property was successfully deleted.')
        expect { property.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "PATCH #update" do
    context "as an admin user" do
      before do
        sign_in admin
      file = fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test_image.jpg'), 'image/jpg')
      property.image.attach(file)
      end

      it "updates the property and redirects" do
        patch :update, params: { id: property.id, property: { property_type: "residential" } }
        property.reload
        expect(property.property_type).to eq("residential")
        expect(response).to redirect_to(property_path(property))
      end
    end

    context "when an unexpected error occurs" do
      before do
        sign_in admin
        allow_any_instance_of(Property).to receive(:update).and_raise(StandardError, "Unexpected error")
      end

      it "renders the edit template with an alert" do
        patch :update, params: { id: property.id, property: { title: "Fail Update" } }
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to include("Error updating property: Unexpected error")
      end
    end

    context "as a non-admin user" do
      before do
        sign_in user
      end

      it "does not allow updating the property" do
        patch :update, params: { id: property.id, property: { title: "Updated Title" } }
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
      end
    end
  end
end
