class Coffee < ApplicationRecord
    has_and_belongs_to_many :taste_notes, after_add: :update_taste_vector

    after_save :update_taste_vector

    def update_taste_vector(taste_note = nil)
        all_taste_notes = TasteNote.order('id ASC')
        taste_notes_vector = "("
        all_taste_notes.each_with_index do | taste_note, index |
            if index != 0
                taste_notes_vector += ","
            end
            if self.taste_notes.any? {|coffee_taste_note| coffee_taste_note == taste_note }
                taste_notes_vector += "1"
            else
                taste_notes_vector += "0" 
            end
        end
        taste_notes_vector += ")"
        sql = "UPDATE coffees SET taste_notes_vector = '" + taste_notes_vector + "' WHERE id = " + self.id.to_s
        ActiveRecord::Base.connection.execute(sql)
    end
end
