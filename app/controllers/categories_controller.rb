class CategoriesController < ApplicationController
  def index
    @categories = Category.supercategories
  end

  def show
    @category = Category.find(params[:id])
  end
end
