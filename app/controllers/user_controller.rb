class UserController < ApplicationController

  def create
    @user = User.create(params.User)
  end

end
