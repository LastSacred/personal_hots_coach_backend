class StatsetsController < ApplicationController
  before_action :authorize!, only: [:show]

  def show
    @user = current_user
    @statset = StatSet.new(@user)

    render json: @statset.to_json, status: :ok
  end

end
