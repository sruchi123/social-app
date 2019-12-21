class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password]) 
      return render json: {error: 'Email not confirmed' } unless  @user.confirmed_at?
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      @user.update(token: token)
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username }, status: :ok                       
    else
      render json: {error: 'Email and password not valid' }, status: :unauthorized
    end
  end

  

  def logout 
    @current_user.update(token: nil)
    render  json: { message: 'Log Out User' }, status: :ok
  end 
  

  private

  def login_params
    params.permit(:email, :password)
  end

end

