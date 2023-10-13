
class WishlistsController < ApplicationController

  before_action :authorize_request
  before_action :show,only: [:show]

def index
  debugger
  @wishlist=@current_user.wishlist.wishlist_items
  @count=@current_user.wishlist.count
  render json:{status: {message: 'Number of items in your wishlist are',counts: @count,cartss: @wishlist}}
end

def create
  if @current_user.wishlist
    @wishlist_id=@current_user.wishlist.id
    @current_item=WishlistItem.find_by(wishlist_id: @wishlist_id, name: params[:name], description: params[:description], price: params[:price])
      if @current_item
        render json: {message: 'Item is already added to wishlist'}, status: :ok
        return
      else
        @wishlist = @current_user.wishlist.wishlist_items.new(wishlist_item_params)
      end
  else
    @wishlist = Wishlist.create(user_id: @current_user.id,count: 0)
    @wishlist=@wishlist.cart_items.new(wishlist_item_params)
  end
  if @wishlist.save
    render json: @wishlist, status: :ok
  else
    render json: { errors: @wishlist.errors.full_messages }, status: :unprocessable_entity
  end
end

def destroy
 @wishlist=@current_user.wishlist.wishlist_items.find_by(id: params[:id])
  if @wishlist
     @wishlist.destroy
      render json: {message: 'Item deleted succesfully'}, status: :ok
  else
      render json: {message: 'Item is not available'}, status: :ok
  end
end


private

def wishlist_item_params
    params.permit(:name,:price,:description)    
end

end
