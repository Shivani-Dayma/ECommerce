
class ItemsController < ApplicationController
  before_action :authorize_request
  before_action :find_item, only: [:show, :update, :destroy]
  before_action :authorize_admin, only: [:create, :update, :destroy]

  def index
    @items = Item.all
    render json: @items, status: :ok
  end


  def sort
    if params[:sort].present?
      item_name = params[:sort]
      item=item_name.to_sym
      @items = Item.order(item, :asc)
      render json: @items, status: :ok
    else
      render json: {status: {message: 'params not present'}}
    end
  end


  def filter
    if params[:filter].present? && params[:choice].present? || params[:category_type].present?
      filter_query = params[:filter]
      choice = params[:choice]
      category=params[:category_type]
      if Item.column_names.include?(choice)
        @current_items = Item.where("#{choice} LIKE ?", "%#{filter_query}%")
          if @current_items.empty?
          render json: { status: { message: 'Item you want to filter is not present' } }, status: :ok
          else
          render json: @current_items, status: :ok
          end
        elsif
        @current_category=Item.where("category_type LIKE ?","%#{category}")
        if @current_category.empty?
          render json: { status: { message: 'Category is not present' } }, status: :ok
          else
          render json: @current_category, status: :ok
          end
      else
        render json: { status: { message: 'Invalid choice' } }, status: :unprocessable_entity
      end
    
    else
      render json: { status: { message: 'Search parameter or choice not present' } }, status: :unprocessable_entity
    end
  end
  

    # def search
    #   search_query = params[:search]
    #   if search_query.present?
    #     @search_results = Item.where("name LIKE ? OR description LIKE ? OR category_type LIKE ? OR price LIKE ?", "%#{search_query}%", "%#{search_query}%", "%#{search_query}%", "%#{search_query}%")

    #     if @search_results.empty?
    #       render json: { status: { message: 'No items found for the specified search criteria' } }, status: :ok
    #     else
    #       render json: @search_results, status: :ok
    #     end
    #   else
    #     render json: { status: { message: 'Search query is required' } }, status: :unprocessable_entity
    #   end
    # end

    def search
      search_query = params[:search]
      if search_query.present?
        @q = Item.ransack(name_or_description_or_category_type_or_price_or_id_cont: search_query)
        @search_results = @q.result
        if @search_results.empty?
          render json: { status: { message: 'No items found for the specified search criteria' } }, status: :ok
        else
          render json: @search_results, status: :ok
        end
      else
        render json: { status: { message: 'Search query is required' } }, status: :unprocessable_entity
      end
    end
   
 
  def create
  category_name = params[:category_type]
  @category = Category.find_by(name: category_name)
    if @category.present?
      @item = @current_user.items.new(item_params)
      @item.category_id = @category.id
      if @item.save
        render json: @item, status: :ok
      else
        render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Category not found" }, status: :unprocessable_entity
    end
  end
  

  def show
    render json: @item, status: :ok
  end

  def update
    return if response_body.present?
    if @item.update(item_params)
      render json: @item, status: :ok
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    return if response_body.present?
    if @item.destroy
      render json: { message: 'Item deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete Item' }, status: :unprocessable_entity
    end
  end

  def find_item
    @item = Item.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Item not found' }, status: :not_found
  end

  private

  def item_params
    params.permit(:name, :description, :price, :category_type,:category_id)
  end
end


