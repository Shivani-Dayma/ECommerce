class SessionsController < ApplicationController
    before_action :authorize_request
    def signout
        # debugger
        if @current_user.present? && !@current_user.token.nil?
            token = JsonWebToken.encode(user_id: @current_user.id) 
           @current_user.update(token:nil)
          render json: 'You have been successfully signed out.'
        else
            render json: "Your session is expired"  
       end
    end   
end



