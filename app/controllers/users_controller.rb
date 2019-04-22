class UsersController < ApplicationController
  before_action :authorize!, only: [:show, :update]

  def show
    @user = current_user
    render json: @user.to_json(
        only: [
          :battletag,
          :auto_roster,
          :track_quick_match,
          :track_unranked_draft,
          :track_ranked_draft
        ],
        include:
          :heroes
      ),
      status: :ok
  end

  def create
     @user = User.new(user_params)

    if @user.save
      render json: @user.to_json(except: :password_digest), status: :created
    else
      render json: {errors: @user.errors.full_messages}, status: :conflict
    end
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)

    if @user.save
      render json: @user.to_json(except: :password_digest), status: :ok
    else
      render json: {errors: @user.errors.full_messages}, status: :conflict
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :battletag, :auto_roster, :track_quick_match, :track_unranked_draft, :track_ranked_draft, roster: [])
  end

end
