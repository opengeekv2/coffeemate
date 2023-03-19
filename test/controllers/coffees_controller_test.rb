require "test_helper"
require "docker"

class CoffeesControllerTest < ActionDispatch::IntegrationTest

  test "should show coffee beans page" do
    get coffees_url
    assert_response :success
  end

  test "should show coffee beans page title" do
    get coffees_url
    assert_select "h1", "Coffees"
  end

  test "should show a coffee in a list" do
    get coffees_url
    assert_select "a", "Sumatra Raja Gayo Café de Origen en grano Bio Fairtrade"
  end

  test "should show a coffee in a list with a link" do
    get coffees_url
    assert_select "a[href=?]", "https://alternativa3.com/cafe-en-grano/cafe-grano-origen-sumatra-raja-gayo-bio-ft-500g/"
  end

  test "should show another coffee in a list" do
    get coffees_url
    assert_select "a", "Estanzuela"
  end

  test "should show another coffee in a list with a link" do
    get coffees_url
    assert_select "a[href=?]", "https://syra.coffee/products/estanzuela"
  end

  test "should show coffee taste notes" do
    get coffees_url
    assert_select ".taste-note", "Chocolate"
    assert_select ".taste-note", "Raspberry"
  end

  test "should suggest coffees based on notes" do
    get coffees_url, params: {
      taste_notes: ["Raspberry", "Chocolate"]
    }
    assert_select "a", "Sumatra Raja Gayo Café de Origen en grano Bio Fairtrade"
  end

  test "should not show complex coffee taste notes" do
    get coffees_url
    assert_select "label", {count: 0, text: "Nutty"}
  end

end
