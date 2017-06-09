class SocialPhoto < ApplicationRecord
  # 关联 #
  belongs_to :product

  # 应用场景图片 #
  mount_uploader :image, ImageUploader
end
