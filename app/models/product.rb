class Product < ApplicationRecord
  validates :title, :description, :quantity, :price, presence: true
  validates :quantity, :price, numericality: { greater_than_or_equal_to: 0 }
  mount_uploader :image, ImageUploader

  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images  # 把 product_images 作为 product 的巢状属性

  scope :recent, -> { order("created_at DESC") }
  scope :published, -> { where(is_hidden: false) }

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
end
