class HeroesController < ApplicationController

  def index

    @heroes = Hero.order(:name)

    render json: @heroes.to_json, status: :ok
  end
end
