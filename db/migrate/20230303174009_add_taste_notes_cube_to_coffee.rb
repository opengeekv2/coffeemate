class AddTasteNotesCubeToCoffee < ActiveRecord::Migration[7.0]
  def change
    enable_extension "cube"
    reversible do |dir|
      dir.up do
        # add a CHECK constraint
        execute <<-SQL
          ALTER TABLE coffees
            ADD COLUMN taste_notes_vector cube
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE distributors
            DROP column taste_notes_vector
        SQL
      end
    end

  end
end
