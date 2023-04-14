require "test_helper"

class TasteNoteTest < ActiveSupport::TestCase
  test "it should update all the taste notes vectors when I create a 1st level taste_note" do
    taste_note = TasteNote.create(name:"Peach", level: 1)
    sql = "select taste_notes_vector from coffees"
    result = ActiveRecord::Base.connection.exec_query(sql)
    assert result.to_a.all? { | row |
      row['taste_notes_vector'].count(",") == 2
    }
  end

  test "it should update all the taste notes vectors when I create a 2nd level taste_note" do
    taste_note = TasteNote.find_by(name:"Peach")
    taste_note2 = TasteNote.create(name:"PeachChild", parent: taste_note, level: 2) 
    sql = "select taste_notes_vector from coffees"
    result = ActiveRecord::Base.connection.exec_query(sql)
    assert result.to_a.all? { | row |
      row['taste_notes_vector'].count(",") == 2
    }
  end

  test "it should update all the taste notes vectors when I create a 3rd level taste_note" do
    taste_note = TasteNote.find_by(name:"PeachChild")
    taste_note2 = TasteNote.create(name:"PeachChildChild", parent: taste_note, level: 3) 
    sql = "select taste_notes_vector from coffees"
    result = ActiveRecord::Base.connection.exec_query(sql)
    assert result.to_a.all? { | row |
      row['taste_notes_vector'].count(",") == 1
    }
  end

  test "is_like should be true if a taste is itself" do
    taste_note = TasteNote.create(name: "Paarent")
    assert taste_note.is_like?(taste_note)
  end

  test "is_like should be true if a taste is its parent" do
    taste_note = TasteNote.create(name: "Parent")
    taste_note_child = TasteNote.create(name: "ParentChild", parent: taste_note)
    assert taste_note_child.is_like?(taste_note)
  end

  test "is_like should be true if a taste is its parents parent" do
    taste_note = TasteNote.create(name: "Parent")
    taste_note_child = TasteNote.create(name: "ParentChild", parent: taste_note)
    taste_note_child_child = TasteNote.create(name: "ParentChildChild", parent: taste_note_child)
    assert taste_note_child_child.is_like?(taste_note)
  end

  test "is_like should be false if a taste is not a direct parent" do
    taste_note = TasteNote.create(name: "Parent")
    taste_note_child = TasteNote.create(name: "ParentChild", parent: taste_note)
    taste_note_other_child = TasteNote.create(name: "ParentChild", parent: taste_note)
    taste_note_child_child = TasteNote.create(name: "ParentChildChild", parent: taste_note_child)
    assert !taste_note_child_child.is_like?(taste_note_other_child)
  end

  test "is_like should be false if a taste is unrelated" do
    taste_note = TasteNote.create(name: "Parent")
    taste_note_other = TasteNote.create(name: "OtherParent")
    assert !taste_note_other.is_like?(taste_note)
  end
end
