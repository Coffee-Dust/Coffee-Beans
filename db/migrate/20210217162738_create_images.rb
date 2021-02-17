class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :location
      t.integer :post_id
    end
  end
end
