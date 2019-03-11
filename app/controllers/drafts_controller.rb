class DraftsController < ApplicationController
  before_action :authorize!, only: [:create]

  def create
    @draft = Draft.new(draft_params)
    @draft.user = current_user
    # FIXME: unable to send only picklist
    render json: @draft.to_json, status: :ok
  end

  private

  def draft_params
    params.require(:draft).permit(:map, bans: [], with_heroes: [], against_heroes: [])
  end
end
