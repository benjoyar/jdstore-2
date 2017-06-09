class Admin::ProductsController < ApplicationController

  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required
  def index
    @products = Product.all.recent.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @product = Product.new

    # 商品图片
    @product_image = @product.product_images.build #for multi-pics

    # 商品应用场景图片
    @social_photos = @product.social_photos.build
  end

  def show
    @product = Product.find(params[:id])

    # 商品图片
    @product_images = @product.product_images.all

    # 商品应用场景图片
    @social_photos = @product.social_photos.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      # 商品图片
      if params[:product_images] != nil
        params[:product_images]['image'].each do |i|
          @product_image = @product.product_images.create(:image => i)
        end
      end
      # 商品应用场景图片
      if params[:social_photos] != nil
        params[social_photos]['image'].each do |i|
          @social_photo = @product.social_photos.create(:image => i)
        end
      end

      redirect_to admin_products_path
    else
      render :new
    end
  end

    def update
      @product = Product.find(params[:id])

      # 商品图片
      if params[:product_images] != nil
        #刪除旧图
        @product.product_images.destroy_all

        params[:product_images]['image'].each do |i|
          @product_image = @product.product_images.create(:image => i)
        end

        # 商品应用场景图片
       params[:social_photos] != nil
        #刪除旧图
        @product.social_photos.destroy_all

        params[:social_photos]['image'].each do |i|
          @social_photo = @product.social_photos.create(:image => i)
        end

        @product.update(product_params)
        redirect_to admin_products_path
        flash[:notice] = "商品信息修改成功！"
       elsif @product.update(product_params)
         redirect_to admin_products_path
         flash[:notice] = "商品信息修改成功！"
       else
         render :edit
      end
    end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
    flash[:alert] = "商品已删除！"
  end

  def publish
    @product = Product.find(params[:id])
    @product.publish!
    redirect_to :back
  end

  def hide
    @product = Product.find(params[:id])
    @product.hide!
    redirect_to :back
  end

    private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :is_hidden)
  end
end
