class MapsController < ApplicationController

  def index
    @maps = Map.actual

    render json: @maps.to_json, status: :ok
  end
end
