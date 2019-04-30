class StatsetsController < ApplicationController
  before_action :authorize!

  def show
    @user = current_user
    @statset = StatSet.new(@user)
    # FIXME: unable to send only hero_sets
    render json: @statset.to_json, status: :ok
  end

end
