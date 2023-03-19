class CoffeesController < ApplicationController

  def index
    @taste_notes = TasteNote.where(is_basic: true)
    if params[:taste_notes].present?
      @coffees = Coffee.query_by_taste_notes(params[:taste_notes])
    else
      @coffees = Coffee.all
    end
  end
end
