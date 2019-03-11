class ApplicationController < ActionController::API
  private

  def current_user
    token = request.headers['Access-Token']
    return nil unless token
    
    payload = JWT.decode(token, ENV['SECRET']).first
    User.find(payload['userId'])
  end

  def authorize!
    render json: {error: "Unauthorized"}, status: :unauthorized unless current_user
  end
end
