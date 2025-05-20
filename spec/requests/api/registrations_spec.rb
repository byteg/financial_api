require 'rails_helper'

RSpec.describe "Api::Registrations", type: :request do
  describe "POST /api/users" do
    it "creates a user" do
      expect do
        post "/api/users.json", params: { user: attributes_for(:user) }
      end.to change { User.count }.by(1)
      expect(response).to have_http_status(:created)
    end
  end
end
