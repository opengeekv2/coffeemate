class BeansController < ApplicationController
  def index
    @coffees = Coffee.all
  end
end
