class CreateJoinTableCoffeeTasteNote < ActiveRecord::Migration[7.0]
  def change
    create_join_table :coffees, :taste_notes
  end
end
