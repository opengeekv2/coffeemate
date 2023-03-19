class InsertTasteNotes < ActiveRecord::Migration[7.0]
  def change
    taste_file = File.read("./db/taste_model/taste_model.json")
    taste_model = JSON.parse(taste_file)
    taste_notes = taste_model["data"].each { | json_family |
      family = TasteNote.create(name: json_family["name"], color: json_family["colour"], is_basic: false)
      json_family["children"].each { | json_subfamily | 
        if !json_subfamily["children"]
          TasteNote.create(name: json_subfamily["name"], color: json_subfamily["colour"], taste_note_id: family.id, is_basic: true)
          next
        end
        subfamily = TasteNote.create(name: json_subfamily["name"], color: json_subfamily["colour"], taste_note_id: family.id, is_basic: false)
        json_subfamily["children"].each { | json_taste_note |
          TasteNote.create(name: json_taste_note["name"], color: json_taste_note["colour"], taste_note_id: subfamily.id, is_basic: true)
        }
      } 
    }
  end
end
