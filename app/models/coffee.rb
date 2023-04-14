class Coffee < ApplicationRecord
    has_and_belongs_to_many :taste_notes, after_add: :update_taste_vector

    after_save :update_taste_vector

    def self.query_by_taste_notes(taste_notes)
        complex_taste_notes = TasteNote.where(level: [1, 2]).order('id ASC')
        request_taste_notes = taste_notes.reduce(Set[]) { | acc, taste_note_name |
            taste_note = TasteNote.find_by(name: taste_note_name)
            if not complex_taste_notes.include? taste_note
                taste_note = taste_note.parent
            end
            acc << taste_note
            family = taste_note.parent
            if !family
                next
            end
            acc << family
        }
        self.find_by_sql(["select *, cube_distance(taste_notes_vector, ?) dist FROM coffees ORDER BY dist", Coffee.generate_taste_vector(complex_taste_notes, request_taste_notes)])
      end

    def self.generate_taste_vector(all_taste_notes, taste_notes)
        taste_notes_vector = all_taste_notes.map { |taste_note|
            next "1" if taste_notes.any? { |coffee_taste_note|
                coffee_taste_note.is_like?(taste_note)
            }
            "0"
        }
        return "(" + taste_notes_vector.join(",") + ")"
    end

    def update_taste_vector(taste_note = nil)
        if self.id
            all_taste_notes = TasteNote.where(level: [1, 2]).order('id ASC')
            taste_vector = Coffee.generate_taste_vector(all_taste_notes, self.taste_notes)
            ActiveRecord::Base.connection.exec_query("UPDATE coffees SET taste_notes_vector = '" + taste_vector + "' WHERE id = " + self.id.to_s)
        end
    end
end
