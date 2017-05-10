class ProductsController < ApplicationController
  def index
    @products = Product.where(:is_hidden => false).recent
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :is_hidden)
  end

end
