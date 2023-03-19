class AddLevelToTasteNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :taste_notes, :level, :integer
  end
end
