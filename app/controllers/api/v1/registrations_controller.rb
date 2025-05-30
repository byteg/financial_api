class Api::V1::RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def respond_with(resource, opts = {})
      unless resource.errors.blank?
        render json: resource.errors, status: :unprocessable_entity
      else
        render json: UserSerializer.render(resource), status: :created
      end
    end

    private

    def sign_up_params
      params.require(:user).permit(:email)
    end
end
