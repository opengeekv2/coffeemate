class FixSelfRelationshipTasteNote < ActiveRecord::Migration[7.0]
  def change
    remove_reference :taste_notes, :taste_note
    add_reference :taste_notes, :parent
  end
end
