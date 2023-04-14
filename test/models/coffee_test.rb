require "test_helper"

class CoffeeTest < ActiveSupport::TestCase
  test "it should set the taste note vector when I create a coffee" do
    coffee = Coffee.create(title: "coffee1")
    sql = "select taste_notes_vector from coffees where id = " + coffee.id.to_s
    result = ActiveRecord::Base.connection.exec_query(sql)
    assert (result.to_a.last['taste_notes_vector'] == "(0, 0)")
  end

  test "it should update the taste note vector when I update a coffee_taste_note" do
    coffee = Coffee.create(title: "coffee1")
    taste_note = TasteNote.find_by_name("Raspberry")
    coffee.taste_notes << taste_note
    sql = "select taste_notes_vector from coffees where id = " + coffee.id.to_s
    result = ActiveRecord::Base.connection.exec_query(sql)
    assert (result.to_a.last['taste_notes_vector'] == "(1, 1)")
  end

  test "it should get cofees by taste note similarity" do
    coffees = Coffee.query_by_taste_notes(["Raspberry"])
    assert coffees[0].title == "Estanzuela 1"
    assert coffees[1].title == "Estanzuela"
  end
end
