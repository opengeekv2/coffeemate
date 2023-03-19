class AddColorToTasteNote < ActiveRecord::Migration[7.0]
  def change
    add_column :taste_notes, :color, :string
  end
end
