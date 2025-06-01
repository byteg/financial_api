require 'rails_helper'

RSpec.describe "Api::Balances", type: :request do
  describe "#show" do
    context "when user is authenticated" do
      let(:user) { create(:user, amount_cents: 100) }
      let(:default_headers) { authenticated_user_header(user) }

      it "returns http success" do
        get "/api/v1/balance.json"
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["amount_cents"]).to eq(100)
      end
    end

    context "when user is not authenticated" do
      it "returns http unauthorized" do
        get "/api/v1/balance.json"
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
          post "/api/v1/balance/deposit.json", params: { amount_cents: 100 }, headers: default_headers
        }.to change { user.reload.amount_cents }.by(100).and change { BalanceTransaction.count }.by(1)
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["amount_cents"]).to eq(200)
      end
    end

    context "when user is not authenticated" do
      it "returns http unauthorized" do
        post "/api/v1/balance/deposit.json", params: { amount_cents: 100 }
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
          post "/api/v1/balance/withdraw.json", params: { amount_cents: 100 }
        }.to change { user.reload.amount_cents }.by(-100).and change { BalanceTransaction.count }.by(1)
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["amount_cents"]).to eq(0)
      end
    end

    context "when user is not authenticated" do
      it "returns http unauthorized" do
        post "/api/v1/balance/withdraw.json", params: { amount_cents: 100 }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "#transfer" do
    let(:other_user) { create(:user, amount_cents: 0) }

    context "when user is authenticated" do
      let(:user) { create(:user, amount_cents: sender_balance) }
      let(:default_headers) { authenticated_user_header(user) }

      context "when sender's balance is sufficient" do
        let(:sender_balance) { 100 }

        it "returns http success" do
          expect {
            post "/api/v1/balance/transfer.json", params: { amount_cents: 100, email: other_user.email }
          }.to change { user.reload.amount_cents }.by(-100).and change { other_user.reload.amount_cents }.by(100).and change { BalanceTransaction.count }.by(2)
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)["amount_cents"]).to eq(0)
        end

        it "does not accept negative amount" do
          expect {
            post "/api/v1/balance/transfer.json", params: { amount_cents: -100, email: other_user.email }
          }.to change { user.reload.amount_cents }.by(0).and change { other_user.reload.amount_cents }.by(0).and change { BalanceTransaction.count }.by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["error"]).to eq("Amount must be greater than 0")
        end
      end

      context "when sender's balance is insufficient" do
        let(:sender_balance) { 0 }

        it "returns http success" do
          expect {
            post "/api/v1/balance/transfer.json", params: { amount_cents: 100, email: other_user.email }
          }.to change { user.reload.amount_cents }.by(0).and change { other_user.reload.amount_cents }.by(0).and change { BalanceTransaction.count }.by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["error"]).to eq("Insufficient balance")
        end
      end

      context "when counterparty is not found" do
        let(:sender_balance) { 100 }
        it "returns http not found" do
          post "/api/v1/balance/transfer.json", params: { amount_cents: 100, email: "nonexistent@example.com" }
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context "when user is not authenticated" do
      it "returns http unauthorized" do
        post "/api/v1/balance/transfer.json", params: { amount_cents: 100, email: other_user.email }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
