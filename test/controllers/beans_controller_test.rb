require "test_helper"
require "docker"

class BeansControllerTest < ActionDispatch::IntegrationTest

  test "should show cofee beans page" do
    get beans_url
    assert_response :success
  end

  test "should show cofee beans page title" do
    get beans_url
    assert_select "h1", "Beans"
  end

  test "should show a cofee in a list" do
    get beans_url
    assert_select "a", "Sumatra Raja Gayo Café de Origen en grano Bio Fairtrade"
  end

  test "should show a cofee in a list with a link" do
    get beans_url
    assert_select "a[href=?]", "https://alternativa3.com/cafe-en-grano/cafe-grano-origen-sumatra-raja-gayo-bio-ft-500g/"
  end

  test "should show another cofee in a list" do
    get beans_url
    assert_select "a", "Estanzuela"
  end

  test "should show another cofee in a list with a link" do
    get beans_url
    assert_select "a[href=?]", "https://syra.coffee/products/estanzuela"
  end
end
