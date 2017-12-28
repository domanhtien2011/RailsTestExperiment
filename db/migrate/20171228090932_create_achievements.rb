class CreateAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :achievements do |t|
      t.string :title
      t.text :tescription
      t.integer :privacy
      t.boolean :featured
      t.string :conver_image

      t.timestamps
    end
  end
end
