class ShelvesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shelf, only: [:show, :edit, :update, :destroy]

  def index
    @shelves = current_user.shelves
  end

  def show
  end

  def new
    @shelf = current_user.shelves.new
  end

  def create
    @shelf = current_user.shelves.new(shelf_params)
    if @shelf.save
      redirect_to @shelf, notice: "棚を作成しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shelf.update(shelf_params)
      redirect_to @shelf, notice: "棚を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @shelf.destroy
    redirect_to shelves_path, notice: "棚を削除しました。"
  end

  private

  def set_shelf
    @shelf = current_user.shelves.find(params[:id])
  end

  def shelf_params
    params.require(:shelf).permit(:title, :description, :image)
  end
end
