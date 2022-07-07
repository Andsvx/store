class CategoriesController < ApplicationController
  before_action :check_permission, only: %i[new edit create update destroy]
  before_action :find_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
  end

  def show
    @all_items = []
    @categories = Category.where("lft >= #{@category.lft} AND rgt <= #{@category.rgt}")

    @categories.each do |category|
      items = Item.where(category_id: category.id)
      items.each { |item| @all_items << item }
    end
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.create(category_params)

    if @category.errors.empty?
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def update
    @category.update(category_params)

    if @category.errors.empty?
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = t(:deleted, scope: %i[categories messages])
    else
      flash[:alert] = @category.errors.full_messages.join(' / ')
    end

    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:parent_id, :name)
  end

  def find_category
    @category = Category.find_by(id: params[:id])
    render_404 unless @category
  end
end
