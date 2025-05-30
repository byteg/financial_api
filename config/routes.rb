Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  constraints format: :json do
    defaults format: :json do
      scope :"api/v1" do
        devise_for :users, controllers: {
                                          registrations: "api/v1/registrations"
                                        }
      end
    end

    namespace :api do
      namespace :v1 do
        get "balance" => "balance#show"
        post "balance/deposit" => "balance#deposit"
        post "balance/withdraw" => "balance#withdraw"
        post "balance/transfer" => "balance#transfer"
      end
    end
  end
end
