require 'rails_helper'

RSpec.describe "User flow", type: :request do
  it "registers, deposits, transfers funds, withdraws, requests balance" do
    post "/api/v1/users.json", params: { user: attributes_for(:user) }
    first_jwt_token = response.headers['Authorization']

    post "/api/v1/users.json", params: { user: attributes_for(:user) }
    second_jwt_token = response.headers['Authorization']
    second_user_email = JSON.parse(response.body)['email']

    expect(first_jwt_token).not_to eq(second_jwt_token)

    post "/api/v1/balance/deposit.json", params: { amount_cents: 100 }, headers: { 'Authorization' => first_jwt_token }
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)["amount_cents"]).to eq(100)

    post "/api/v1/balance/transfer.json", params: { amount_cents: 50, email: second_user_email }, headers: { 'Authorization' => first_jwt_token }
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)["amount_cents"]).to eq(50)

    post "/api/v1/balance/withdraw.json", params: { amount_cents: 50 }, headers: { 'Authorization' => first_jwt_token }
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)["amount_cents"]).to eq(0)

    get "/api/v1/balance.json", headers: { 'Authorization' => first_jwt_token }
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)["amount_cents"]).to eq(0)

    get "/api/v1/balance.json", headers: { 'Authorization' => second_jwt_token }
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)["amount_cents"]).to eq(50)
  end
end
