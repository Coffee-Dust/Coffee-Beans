class CreateReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :reactions do |t|
      t.integer :reaction_type
      t.integer :user_id
      t.references :reactable, polymorphic: true, null: false
    end
  end
end
