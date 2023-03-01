class TasteNote < ApplicationRecord
    has_and_belongs_to_many :coffees
end
