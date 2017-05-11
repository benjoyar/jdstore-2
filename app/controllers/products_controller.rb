class ProductsController < ApplicationController
  def index
    @products = Product.where(:is_hidden => false).recent.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @product = Product.find(params[:id])

    if @product.is_hidden
      flash[:warning] = "抱歉，该商品已下架！"
      redirect_to root_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :is_hidden)
  end

end
