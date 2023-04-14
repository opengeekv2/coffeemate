class TasteNote < ApplicationRecord
    has_and_belongs_to_many :coffees
    belongs_to :parent, class_name: "TasteNote", optional: true
    after_save :update_all_taste_vectors

    def update_all_taste_vectors
        coffees = Coffee.all
        coffees.each { | coffee |
            coffee.update_taste_vector
        }
    end

    def is_like?(taste_note)
        if self == taste_note
            return true
        else
            if self.parent
                return self.parent.is_like?(taste_note)
            else
                return false
            end
        end
    end

end
