class ReplayFilesController < ApplicationController
  before_action :authorize!, only: [:create]

  def create
    @replay_files = replay_file_params.collect do |file|
      @file_name = file.original_filename
      @file = file.tempfile

      match = Adapter.post_replay(@file)
      replay_id = (match["status"] == "AiDetected" ? nil : match["id"])

      @replay_file = ReplayFile.find_or_create_by(
        name: @file_name,
        user: current_user,
        match: Match.find_or_create_by(replay_id: replay_id)
      )

      sleep(1.5)
      @replay_file
    end

    render json: @replay_files.to_json, status: :create
  end

  private

  def replay_file_params
    params.require(:files)
  end
end
