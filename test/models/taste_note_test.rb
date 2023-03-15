require "test_helper"

class TasteNoteTest < ActiveSupport::TestCase
  test "it should update all the taste notes vectors when I create a taste_note" do
    taste_note = TasteNote.create(name:"Peach")
    sql = "select taste_notes_vector from coffees"
    result = ActiveRecord::Base.connection.exec_query(sql)
    assert result.to_a.all? { | row |
      row['taste_notes_vector'].count(",") == 2
    }
  end
end
