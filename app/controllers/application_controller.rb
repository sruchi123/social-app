class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    begin
      @current_user = User.find_by_token(header) if header.present?
      unless @current_user.present?
        render json: { errors: 'You are not authorize to access this' }, status: :unauthorized
      end  
    rescue  ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    end  
  end
end
