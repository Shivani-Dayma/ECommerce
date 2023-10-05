class ItemsController < ApplicationController
    before_action :authorize_request
    before_action :find_item, only: [:show, :update, :destroy]
    before_action :authorize_admin, only: [:create, :update, :delete] 

    def index
     @item = @current_user.items.all
      render json: @item, status: :ok
    end
  
    def create
      @item = @current_user.items.new(item_params)
      # @item = User.find(params[:id]).items.new(item_params)
      if @item.save
        render json: @item, status: :ok
      else
        render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      render json: @item, status: :ok
    end
  
    def update
      return if response_body.present? # Add this line to stop execution if response is already rendered
      if @item.update(item_params)
        render json: @item, status: :ok
      else
        render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
      end
    end
        

 
    def destroy
      return if response_body.present? # Add this line to stop execution if response is already rendered
      if @item.destroy
        render json: { message: 'Item deleted successfully' }, status: :ok
      else
        render json: { error: 'Failed to delete Item' }, status: :unprocessable_entity
      end
    end

    def find_item
      @item = Item.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Item  not found' }, status: :not_found
    end
  
    private
  
    def item_params
        params.permit(:name, :description, :price,:user_id)
    end
  end



