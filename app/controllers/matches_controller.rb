class MatchesController < ApplicationController
  before_action :authorize!, only: [:create]
  
  def create
    current_user.import

    render status: :accepted
  end
end
