class ItemsController < ApplicationController
  before_action :check_permission, only: %i[new edit create update destroy]
  before_action :find_item, only: %i[show edit update destroy]

  def index
    @items = Item
    @items = @items.where('price <= ?', params[:max_price]) if params[:max_price]
    @items = @items.where('price >= ?', params[:min_price]) if params[:min_price]
    @items = @items.order('price')
  end

  def show; end

  def new
    @item = Item.new
  end

  def edit; end

  def create
    @item = Item.create(item_params)

    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render 'new'
    end
  end

  def update
    @item.update(item_params)

    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    if @item.destroy
      flash[:notice] = t(:deleted, scope: %i[items messages])
    else
      flash[:alert] = @item.errors.full_messages.join(' / ')
    end

    redirect_to admin_items_path
  end

  def destroy_image
    item = Item.find_by(id: params[:item_id])
    image_id = params[:id].to_i

    item.images[image_id].remove!
    item.images.delete_at(image_id)
    item.save

    redirect_to edit_item_path(item)
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :price, :name, :description, { images: [] })
  end

  def find_item
    @item = Item.find_by(id: params[:id])
    render_404 unless @item
  end
end
