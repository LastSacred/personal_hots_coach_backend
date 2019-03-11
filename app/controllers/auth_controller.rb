class AuthController < ApplicationController
  def create
    @user = User.find_by(name: user_params[:name])

    if @user && @user.authenticate(user_params[:password])
      token = JWT.encode({userId: @user.id}, ENV['SECRET'])
      render json: {token: token}, status: :ok
    else
      message = "Username and password not found"
      render json: {errors: message}, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit([:name, :password])
  end
end
