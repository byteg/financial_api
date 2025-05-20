require 'rails_helper'

RSpec.describe "Api::Balances", type: :request do
  describe "#show" do
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

  describe "#deposit" do
    context "when user is authenticated" do
      let(:user) { create(:user, amount_cents: 100) }
      let(:default_headers) { authenticated_user_header(user) }

      it "returns http success" do
        expect {
          post "/api/balance/deposit.json", params: { amount_cents: 100 }, headers: default_headers
        }.to change { user.reload.amount_cents }.by(100)
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["amount_cents"]).to eq(200)
      end
    end

    context "when user is not authenticated" do
      it "returns http unauthorized" do
        post "/api/balance/deposit.json", params: { amount_cents: 100 }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "#withdraw" do
    context "when user is authenticated" do
      let(:user) { create(:user, amount_cents: 100) }
      let(:default_headers) { authenticated_user_header(user) }

      it "returns http success" do
        expect {
          post "/api/balance/withdraw.json", params: { amount_cents: 100 }, headers: default_headers
        }.to change { user.reload.amount_cents }.by(-100)
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["amount_cents"]).to eq(0)
      end
    end

    context "when user is not authenticated" do
      it "returns http unauthorized" do
        post "/api/balance/withdraw.json", params: { amount_cents: 100 }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
