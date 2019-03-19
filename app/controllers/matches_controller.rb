class MatchesController < ApplicationController
  before_action :authorize!, only: [:create]
  # TODO write test for matches#create action
  def create
    current_user.import

    render status: :accepted
  end
end
