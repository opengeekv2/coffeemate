class TasteNote < ApplicationRecord
    has_and_belongs_to_many :coffees

    after_save :update_all_taste_vectors

    def update_all_taste_vectors(taste_note = nil)
        coffees = Coffee.all
        coffees.each { | coffee |
            coffee.update_taste_vector()
        }
    end



end
