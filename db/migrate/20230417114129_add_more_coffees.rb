class AddMoreCoffees < ActiveRecord::Migration[7.0]
  def change
    TasteNote.delete_all
    Coffee.delete_all

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

    cocoa = TasteNote.find_by(name: "Cocoa")
    nutty = TasteNote.find_by(name: "Nutty")
    Coffee.create(title: "Cafe Venezuela Santa Cruz de Mora", taste_notes: [cocoa, nutty])

    sweet = TasteNote.find_by(name: "Sweet")
    chocolate = TasteNote.find_by(name: "Chocolate")
    other_fruit = TasteNote.find_by(name: "Other fruit")
    Coffee.create(title: "Cafe Brasil Minas Gerais Fazendas", taste_notes: [sweet, chocolate, other_fruit])

    caramelized = TasteNote.find_by(name: "Caramelized")
    citrus_fruit = TasteNote.find_by(name: "Citrus fruit")
    jasmine = TasteNote.find_by(name: "Jasmine")
    Coffee.create(title: "Cafe Light Roast Etiopia Limu Moplaco", taste_notes: [caramelized, citrus_fruit, jasmine])

    caramelized = TasteNote.find_by(name: "Caramelized")
    citrus_fruit = TasteNote.find_by(name: "Citrus fruit")
    Coffee.create(title: "Cafe Etiopia Limu Moplaco", taste_notes: [caramelized, citrus_fruit])

    woody = TasteNote.find_by(name: "Woody")
    tobacco = TasteNote.find_by(name: "Tobacco")
    Coffee.create(title: "Cafe Dark Roast Uganda Bujanga Victoria Lake", taste_notes: [woody, tobacco])

    sweet = TasteNote.find_by(name: "Sweet")
    hazelnut = TasteNote.find_by(name: "Hazelnut")
    Coffee.create(title: "Cafe Perú Cajamarca Jaén", taste_notes: [sweet, hazelnut])

    floral = TasteNote.find_by(name: "Floral") 
    sweet = TasteNote.find_by(name: "Sweet")
    almond = TasteNote.find_by(name: "Almond")
    Coffee.create(title: "Cafe Guatemala Quetzaltenango Mujeres Dechuwa", taste_notes: [floral, sweet, almond])

    cinnamon = TasteNote.find_by(name: "Cinnamon") 
    clove = TasteNote.find_by(name: "Clove")
    dark_chocolate = TasteNote.find_by(name: "Dark chocolate")
    strawberry = TasteNote.find_by(name: "Strawberry")
    Coffee.create(title: "Cafe Sumatra Aceh Trenggiling", taste_notes: [cinnamon, clove, dark_chocolate, strawberry])

    woody = TasteNote.find_by(name: "Woody") 
    citrus = TasteNote.find_by(name: "Citrus fruit")
    Coffee.create(title: "Cafe Roast Brasil Minas Gerais Fazendas", taste_notes: [woody, citrus])

    dark_chocolate = TasteNote.find_by(name: "Dark chocolate") 
    orange = TasteNote.find_by(name: "Orange")
    Coffee.create(title: "Cafe Ruanda Rubavu Nyamyumba", taste_notes: [dark_chocolate, citrus])
  end
end
