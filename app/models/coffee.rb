class Coffee < ApplicationRecord
    has_and_belongs_to_many :taste_notes, after_add: :update_taste_vector

    after_save :update_taste_vector

    def generate_taste_vector(all_taste_notes)
        taste_notes_vector = all_taste_notes.map { |taste_note|
            next "1" if self.taste_notes.any? {|coffee_taste_note| coffee_taste_note == taste_note }
            "0"
        }
        return "(" + taste_notes_vector.join(",") + ")"
    end

    def update_taste_vector(taste_note = nil)
        all_taste_notes = TasteNote.order('id ASC')
        taste_vector = self.generate_taste_vector(all_taste_notes)
        sql = "UPDATE coffees SET taste_notes_vector = '" + taste_vector + "' WHERE id = " + self.id.to_s
        ActiveRecord::Base.connection.execute(sql)
    end
end
