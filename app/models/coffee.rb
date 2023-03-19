class Coffee < ApplicationRecord
    has_and_belongs_to_many :taste_notes, after_add: :update_taste_vector

    after_save :update_taste_vector

    def self.query_by_taste_notes(taste_notes)
        all_taste_notes = TasteNote.order('id ASC')
        self.find_by_sql(["select *, cube_distance(taste_notes_vector, ?) dist FROM coffees ORDER BY dist", Coffee.generate_taste_vector(all_taste_notes, taste_notes)])
      end

    def self.generate_taste_vector(all_taste_notes, taste_notes)
        taste_notes_vector = all_taste_notes.map { |taste_note|
            next "1" if taste_notes.any? { |coffee_taste_note|
                coffee_taste_note == taste_note
            }
            "0"
        }
        return "(" + taste_notes_vector.join(",") + ")"
    end

    def all_taste_notes()
        complete_test_notes = []
        self.taste_notes.each { | taste_note |
            complete_test_notes << taste_note
            family = taste_note.parent
            if !family
                next
            end
            complete_test_notes << family
        }
        return complete_test_notes
    end

    def update_taste_vector(taste_note = nil)
        all_taste_notes = TasteNote.order('id ASC')
        taste_vector = Coffee.generate_taste_vector(all_taste_notes, self.all_taste_notes)
        sql = "UPDATE coffees SET taste_notes_vector = '" + taste_vector + "' WHERE id = " + self.id.to_s
        ActiveRecord::Base.connection.execute(sql)
    end
end
