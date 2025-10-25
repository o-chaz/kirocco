class ItemsController < ApplicationController
  before_action :set_shelf
  before_action :set_item, only: [:show, :edit, :update, :destroy] # ← ✅ show追加！

  def create
    @item = @shelf.items.build(item_params)
    if @item.save
      redirect_to @shelf, notice: '画像を追加しました。'
    else
      render :new
    end
  end

  def show
  end
  
  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @shelf, notice: 'アイテム情報を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to @shelf, notice: 'アイテムを削除しました。'
  end

  private

  def set_shelf
    @shelf = Shelf.find(params[:shelf_id])
  end

  def set_item
    @item = @shelf.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description, :image, :purchased_on, :purchased_at)
  end
end
