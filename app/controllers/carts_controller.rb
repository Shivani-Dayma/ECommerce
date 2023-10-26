class CartsController < ApplicationController

  before_action :authorize_request
  before_action :show,only: [:show]

def index
@carts=@current_user.cart.cart_items
@count=@current_user.cart.count
render json:{status: {message: 'Number of items in your cart is',counts: @count,cartss: @carts}}
end

  def create
   if @current_user.cart
      @cart_id=@current_user.cart.id
      @current_item=CartItem.find_by(cart_id: @cart_id, name: params[:name], description: params[:description], price: params[:price])
      if @current_item
        @current_item.update(quantity: @current_item.quantity+1)
        render json: @current_item, status: :ok
        return
      else
        @cart = @current_user.cart.cart_items.new(cart_item_params)
      end
   else
       @cart_id = Cart.create(user_id: @current_user.id,count: 0)
       @cart=@cart_id.cart_items.new(cart_item_params)
   end
   if @cart.save
    render json: @cart, status: :ok
   else
     render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
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
    params.permit(:name,:price,:description,:item_id)    
  end

end



