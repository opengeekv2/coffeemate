class AddTasteNoteToTasteNote < ActiveRecord::Migration[7.0]
  def change
    add_reference :taste_notes, :taste_note
    add_column :taste_notes, :is_basic, :boolean
  end
end
