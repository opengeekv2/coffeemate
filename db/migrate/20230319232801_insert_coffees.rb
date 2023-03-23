class InsertCoffees < ActiveRecord::Migration[7.0]
  def change
    TasteNote.delete_all
    taste_file = File.read("./db/taste_model/taste_model.json")
    taste_model = JSON.parse(taste_file)
    taste_notes = taste_model["data"].each { | json_family |
      family = TasteNote.create(name: json_family["name"], color: json_family["colour"], is_basic: false, level: 1)
      json_family["children"].each { | json_subfamily | 
        if !json_subfamily["children"]
          TasteNote.create(name: json_subfamily["name"], color: json_subfamily["colour"], parent: family, is_basic: true, level: 2)
          next
        end
        subfamily = TasteNote.create(name: json_subfamily["name"], color: json_subfamily["colour"], parent: family, is_basic: false, level: 2)
        json_subfamily["children"].each { | json_taste_note |
          TasteNote.create(name: json_taste_note["name"], color: json_taste_note["colour"], parent: subfamily, is_basic: true, level: 3)
        }
      } 
    }
    
    spices = TasteNote.find_by(name: "Spices")
    tobacco = TasteNote.find_by(name: "Tobacco")
    woody = TasteNote.find_by(name: "Woody")
    Coffee.create(title: "Sumatra Raja Gayo Café de Origen en grano Bio Fairtrade 500g test", taste_notes: [spices, tobacco, woody])
    fruity = TasteNote.find_by(name: "Fruity")
    jasmin = TasteNote.find_by(name: "Jasmine")
    citrus = TasteNote.find_by(name: "Citrus fruit")
    Coffee.create(title: "Etiopía Sidamo Café de Origen en grano Bio Fairtrade 500g", taste_notes: [fruity, jasmin, citrus])
    caramelized = TasteNote.find_by(name: "Caramelized")
    Coffee.create(title: "Brasil Santos Café de Origen en grano Bio Fairtrade 500g", taste_notes: [caramelized])
    cocoa = TasteNote.find_by(name: "Cocoa")
    brown_sugar = TasteNote.find_by(name: "Brown sugar")
    lemon = TasteNote.find_by(name: "Lemon")
    Coffee.create(title: "Cafe Colombia Risaralda El Vergel", taste_notes: [cocoa, brown_sugar, lemon])
  end
end
