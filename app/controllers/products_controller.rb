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

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = "你的购物车内已有此物品"
    end
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :is_hidden)
  end

end
