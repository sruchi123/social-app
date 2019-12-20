class UsersController < ApplicationController
  before_action :authorize_request, except: [:create , :reset_password, :update_forget_password, :confirm]                            
  before_action :find_user , only: [:update]
  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end


  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end  
  end

    
  def reset_password
    user = User.find_by_email(params[:email])
    if user.present?
      user.send_reset_password_link
      render json: { status: 'Successfully send reset password email', token: user.reset_password_token}, status: :ok
    else
      render json: { status: 'Not found user'}
    end 
  end


  def update_forget_password
    @user = User.find_by_reset_password_token(params["reset_password_token"])
    return render json: { status: 'Invalid token'} unless @user.present?
    if @user.update( password: params[:password], password_confirmation: params[:password_confirmation], reset_password_token: nil)
      render json: { status: 'Successfully reset password', user: @user}, status: :ok
    else
      render json: {errors:  @user.errors.full_messages},  status: :unprocessable_entity
    end
  end  


  def confirm
    token = params[:token].to_s
    user = User.find_by(confirmation_token: token)
    if user.present? && user.confirmation_token_valid?
      user.mark_as_confirmed!
      render json: {status: 'User confirmed successfully' }, status: :ok
    else
      render json: {status: 'Invalid token'}, status: :not_found
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :image, :name, :username, :email, :password, :password_confirmation, :id
    )
  end
end
