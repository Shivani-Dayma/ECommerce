class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    # debugger
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id) 
      @user.update(token:token)
      time = Time.now + 5.minutes   
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     name: @user.name ,role: @user.role}, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
