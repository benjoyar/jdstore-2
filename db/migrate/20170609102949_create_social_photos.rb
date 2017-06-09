class CreateSocialPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :social_photos do |t|
      t.integer :product_id
      t.string :image

      t.timestamps
    end
  end
end
