class CartsController < ApplicationController

    before_action :authorize_request
    before_action :show,only: [:show]

  def index
  @carts=@current_user.cart.cart_items
  render json: @carts,status: :ok 
  end

  def show
    # debugger
    @cart=@current_user.cart.cart_items.find_by(id: params[:id])
    render json: @cart,status: :ok
  end

  def create
    @cart=@current_user.cart.cart_items.new(cart_item_params)
    if @cart.save
        render json: @cart,status: :ok
    else
        render josn: { errors: @cart.errors.full_messages}, status: :unprocessable_entity  
    end
  end

  def destroy
    @cart=@current_user.cart.cart_items.find_by(id: params[:id])
    if @cart
        @cart.destroy
        render json: {message: 'CardItem deleted succesfully'}, status: :ok
    else
        render json: {message: 'CardItem is not available'}, status: :ok
    end
  end


  private

  def cart_item_params
      params.permit(:name,:price,:description)    
  end

end
