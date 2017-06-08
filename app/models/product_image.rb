class ProductImage < ApplicationRecord
  # 关联 #
  belongs_to :product

  # 商品图片 #
  mount_uploader :image, ImageUploader
end
