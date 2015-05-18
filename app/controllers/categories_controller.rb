class CategoriesController < ApplicationController
  def index
    @categories = Category.main
  end

  def show
    @category = Category.find(params[:id])
  end
end
