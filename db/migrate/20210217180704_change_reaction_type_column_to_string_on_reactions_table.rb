class ChangeReactionTypeColumnToStringOnReactionsTable < ActiveRecord::Migration[6.0]
  def change
    change_column :reactions, :reaction_type, :string
  end
end
