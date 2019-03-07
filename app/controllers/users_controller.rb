class UsersController < ApplicationController

  def create
     @user = User.new(user_params)

    if @user.save
      render json: @user.to_json, status: :created
    else
      render json: {errors: @user.errors.full_messages}, status: :conflict
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :battletag, :replay_path)
  end

end
