class UpdateTasteNotes < ActiveRecord::Migration[7.0]
  def change
    TasteNote.delete_all
    taste_file = File.read("./db/taste_model/taste_model.json")
    taste_model = JSON.parse(taste_file)
    count = 0
    taste_notes = taste_model["data"].each { | json_family |
      family = TasteNote.create(name: json_family["name"], color: json_family["colour"], is_basic: false)
      json_family["children"].each { | json_subfamily |
        TasteNote.create(name: json_subfamily["name"], color: json_subfamily["colour"], parent: family, is_basic: true) 
      } 
    }
  end
end
