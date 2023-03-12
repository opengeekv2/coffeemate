class CoffeesController < ApplicationController
  def index
    if params[:taste_notes].present?
      @coffees = Coffee.all
    else
      @coffees = Coffee.all
    end
  end
end
