class ReplayFilesController < ApplicationController
  before_action :authorize!, only: [:create]

  def create
    @file_name = replay_file_params.original_filename
    @file = replay_file_params.tempfile

    match = Adapter.post_replay(@file)
    replay_id = (match["status"] == "AiDetected" ? nil : match["id"])

    @replay_file = ReplayFile.find_or_create_by(
      name: @file_name,
      user: current_user,
      match: Match.find_or_create_by(replay_id: replay_id)
    )

    render json: @replay_file.to_json, status: :created
  end

  private

  def replay_file_params
    params.require(:file)
  end
end
