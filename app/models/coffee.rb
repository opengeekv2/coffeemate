class Coffee < ApplicationRecord
    has_and_belongs_to_many :taste_notes
end
