class ApplicationController < ActionController::API
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from JWT::DecodeError, with: :jwt_decode_error

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
      role = @current_user.role
      time=Time.at(@decoded[:exp])
        # if @decoded[:exp].present? && Time.now > time
        if @current_user.token.nil?
        render json: { error: 'Your session is expired' }, status: :unauthorized
        return
    end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def authorize_admin
    unless @current_user.role == 'supplier'
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  end

 
  private

  def record_not_found
    render json: { errors: 'Record not found' }, status: :not_found
  end

  def jwt_decode_error
    render json: { errors: 'Invalid token' }, status: :unauthorized
  end
end







