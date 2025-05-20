require 'rails_helper'

RSpec.describe "Api::Balances", type: :request do
  describe "GET /show" do
    context "when user is authenticated" do
      let(:user) { create(:user, amount_cents: 100) }
      let(:default_headers) { authenticated_user_header(user) }

      it "returns http success" do
        get "/api/balance.json"
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["amount_cents"]).to eq(100)
      end
    end

    context "when user is not authenticated" do
      it "returns http unauthorized" do
        get "/api/balance.json"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

end
