require 'rails_helper'

RSpec.describe "Api::Balances", type: :request do
  describe "GET /show" do
    let(:user) { create(:user, amount_cents: 100) }
    let(:default_headers) { authenticated_user_header(user) }

    it "returns http success" do
      get "/api/balance"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["amount_cents"]).to eq(100)
    end
  end

end
