class ItemsController < ApplicationController
  before_action :set_shelf
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def new
    @item = @shelf.items.build
    render partial: "items/form", locals: { item: @item }
  end

 def create
  @item = @shelf.items.build(item_params)

  if @item.save
    respond_to do |format|
      format.html { redirect_to @shelf, notice: "アイテムを追加しました。" }

      format.turbo_stream do
        render turbo_stream: [
          # ✅ 真ん中カラムの棚コンテンツを再描画（アイテムが増える）
          turbo_stream.replace("shelf_content",
            partial: "shelves/content",
            locals: { selected_shelf: @shelf }),

          # ✅ 右カラムに新しいアイテムの詳細を表示！
          turbo_stream.replace("shelf_details",
            partial: "items/details",
            locals: { item: @item })
        ]
      end
    end
  else
    render partial: "items/form", locals: { item: @item }, status: :unprocessable_entity
  end
end

  def show
    respond_to do |format|
      format.html do
        render partial: "items/details", locals: { item: @item }
      end
      format.turbo_stream do
        render partial: "items/details", locals: { item: @item }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html do
        render partial: "items/form", locals: { item: @item }
      end
      format.turbo_stream do
        render partial: "items/form", locals: { item: @item }
      end
    end
  end

def update
  if @item.update(item_params)
    respond_to do |format|
      format.html { redirect_to @shelf, notice: "アイテムを更新しました。" }

      format.turbo_stream do
        render turbo_stream: [
          # 真ん中カラムを更新（新しいアイテム一覧を再描画）
          turbo_stream.replace("shelf_content",
            partial: "shelves/content",
            locals: { selected_shelf: @shelf }),

          # 右カラムに更新後の詳細を表示
          turbo_stream.replace("shelf_details",
            partial: "items/details",
            locals: { item: @item })
        ]
      end
    end
  else
    render partial: "items/form", locals: { item: @item }, status: :unprocessable_entity
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
