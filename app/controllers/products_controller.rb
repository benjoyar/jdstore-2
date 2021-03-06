class ProductsController < ApplicationController
  before_action :validate_search_key, only: [:search, :favorite]

  def index
    @products = Product.published.recent.paginate(:page => params[:page], :per_page => 18)
    if params[:favorite] == "yes"
      @products = current_user.products.published.recent.paginate(:page => params[:page], :per_page => 18)
    end
  end

  def show
    @product = Product.find(params[:id])
    # 商品图片
    @product_images = @product.product_images.all
    # 场景图片
    @social_photos = @product.social_photos.all
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

  def search
      if @query_string.present?
        search_result = Product.published.ransack(@search_criteria).result(:distinct => true)
        @products = search_result.paginate(:page => params[:page], :per_page => 12 )
      end
  end

  def add_to_favorite
    @product = Product.find(params[:id])
    @product.users << current_user
    @product.save
    redirect_to :back, notice:"成功加入收藏!"
  end
  def quit_favorite
    @product = Product.find(params[:id])
    @product.users.delete(current_user)
    @product.save
    redirect_to :back, alert: "成功取消收藏!"
  end

    protected

    def validate_search_key
      @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
      @search_criteria = search_criteria(@query_string)
    end


    def search_criteria(query_string)
      { :title_cont => query_string }
    end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :is_hidden)
  end

end
