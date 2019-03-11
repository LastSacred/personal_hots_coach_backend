class HeroesController < ApplicationController

  def index

    @heroes = Hero.all

    render json: @heroes.to_json, status: :ok
  end
end
