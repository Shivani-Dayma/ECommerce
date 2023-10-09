
class UsersController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find, only: [:show]
  
    # GET /users
    def index
      @users = User.all
      render json: @users, status: :ok
    end
  
    # GET /users/{username}
    def show
      render json: @user, status: :ok
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
        @user = User.find_by(id: params[:id])
        if @user.update(user_params)
            render json:@user, status: :ok
        else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # DELETE /users/{username}
    def destroy
        @user = User.find(params[:id])
      @user.destroy
    end
  
    private
  
     def find
   @user = User.find(params[:id])
    if @user
     render json:@user,status: 200
    else
     render json: "Supplier is not found"
  end
end
    def user_params
      params.permit(
         :name, :address, :email, :password, :password_confirmation,:contactno,:role
      )
    end
  end