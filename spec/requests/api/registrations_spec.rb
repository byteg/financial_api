require 'rails_helper'

RSpec.describe "Api::Registrations", type: :request do
  describe "POST /api/users" do
    it "creates a user" do
      expect do
        post "/api/users.json", params: { user: attributes_for(:user) }
      end.to change { User.count }.by(1)
      expect(response).to have_http_status(:created)
      expect(response.body).to include("email")
      expect(response.headers['Authorization']).to include("Bearer")
    end

    it 'does not create a user if the email is not valid' do
      expect do
        post "/api/users.json", params: { user: attributes_for(:user, email: "invalid") }
      end.to change { User.count }.by(0)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not create a user if the email is already taken' do
      create(:user, email: "test@example.com")
      expect do
        post "/api/users.json", params: { user: attributes_for(:user, email: "test@example.com") }
      end.to change { User.count }.by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
  end
end
