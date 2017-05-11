class Product < ApplicationRecord
  validates :title, :description, :quantity, :price, presence: true
  validates :quantity, :price, numericality: { greater_than_or_equal_to: 0 }
  mount_uploader :image, ImageUploader

  scope :recent, -> { order("created_at DESC")}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
end
