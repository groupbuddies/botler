class API::CategoriesController < API::BaseController
  include Roar::Rails::ControllerAdditions
  represents :json, entity: CategoryRepresenter

  def index
    respond_with Category.main.to_a, represent_items_with: CategoryRepresenter
  end

  def show
    respond_with Category.find(params[:id])
  end
end
