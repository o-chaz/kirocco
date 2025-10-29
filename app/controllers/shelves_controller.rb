class ShelvesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shelf, only: %i[ show edit update destroy ]

  # GET /shelves or /shelves.json
  def index
    @shelves = current_user.shelves
    @selected_shelf = @shelves.first
  end

  # GET /shelves/1 or /shelves/1.json
def show
  @shelves = current_user.shelves
  @selected_shelf = @shelves.find(params[:id])

  respond_to do |format|
    format.html { render :index }
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.replace("shelf_content",
          partial: "shelves/content",
          locals: { selected_shelf: @selected_shelf }),
        turbo_stream.replace("shelf_details",
          partial: "shelves/details",
          locals: { selected_shelf: @selected_shelf })
      ]
    end
  end
end

  # GET /shelves/new
  def new
    @shelf = Shelf.new
    render partial: "shelves/form", locals: { shelf: @shelf }
  end

  # GET /shelves/1/edit
  def edit
    @shelf = current_user.shelves.find(params[:id])

    respond_to do |format|
      format.turbo_stream do
        render partial: "shelves/form", locals: { shelf: @shelf }
      end
      format.html
    end
  end

  # POST /shelves or /shelves.json
  def create
    @shelf = current_user.shelves.build(shelf_params)

    respond_to do |format|
      if @shelf.save
        format.turbo_stream do
          render turbo_stream: [
            # 左カラム更新
            turbo_stream.replace(
              "shelf_list",
              partial: "shelves/list",
              locals: { shelves: current_user.shelves }
            ),
            # 真ん中更新
            turbo_stream.replace(
              "shelf_content",
              partial: "shelves/content",
              locals: { selected_shelf: @shelf }
            ),
            # 右カラム更新
            turbo_stream.replace(
              "shelf_details",
              partial: "shelves/details",
              locals: { selected_shelf: @shelf }
            )
          ]
        end
        format.html { redirect_to @shelf, notice: "棚を作成しました。" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "shelf_details",
            partial: "shelves/form",
            locals: { shelf: @shelf }
          )
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shelves/1 or /shelves/1.json
def update
  if @shelf.update(shelf_params)
    respond_to do |format|
      format.html { redirect_to shelves_path, notice: "棚を更新しました。" }

      format.turbo_stream do
        render turbo_stream: [
          # 真ん中カラムを更新（最新の棚内容を再表示）
          turbo_stream.replace(
            "shelf_content",
            partial: "shelves/content",
            locals: { selected_shelf: @shelf }
          ),
          # 右カラムを詳細に戻す
          turbo_stream.replace(
            "shelf_details",
            partial: "shelves/details",
            locals: { selected_shelf: @shelf }
          )
        ]
      end
    end
  else
    render partial: "shelves/form", locals: { shelf: @shelf }, status: :unprocessable_entity
  end
end

  # DELETE /shelves/1 or /shelves/1.json
def destroy
  @shelf.destroy!

  respond_to do |format|
    format.turbo_stream do
      # ✅ 削除後に左カラムを更新
      @shelves = current_user.shelves
      render turbo_stream: turbo_stream.replace("shelf_list",
        partial: "shelves/list",
        locals: { shelves: @shelves })
    end

    format.html { redirect_to shelves_path, notice: "Shelf was successfully destroyed.", status: :see_other }
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shelf
      @shelf = Shelf.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shelf_params
      params.require(:shelf).permit(:title, :description, :image)
    end
end
