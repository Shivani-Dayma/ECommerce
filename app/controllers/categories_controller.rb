class CategoriesController < ApplicationController
  before_action :authorize_request
  before_action :set_category, only: [ :show, :update, :destroy]
  before_action :authorize_admin, only: [:create, :update, :destroy]



  def index
    @categories = @current_user.categories
    render json: @categories, status: :ok
  end

  def create
    return if response_body.present? # Add this line to stop execution if response is already rendered
    @category = @current_user.categories.build(category_params)

    if @category.save
      render json: @category, status: :created
    else 
      render json: { errors: @category.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def show
    render json: @category, status: :ok
  end

  def update
    return if response_body.present? # Add this line to stop execution if response is already rendered
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: { errors: @category.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def destroy
    return if response_body.present? # Add this line to stop execution if response is already rendered
    if @category.destroy
      render json: { message: 'Category deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete category' }, status: :unprocessable_entity
    end
  end

  private


  def category_params
    params.permit(:name, :user_id, :id)
  end

  def set_category
    @category = @current_user.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound 
    render json: { errors: 'Category not found' }, status: :not_found
  end
end
