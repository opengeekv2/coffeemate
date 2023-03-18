class TasteVectorGeneratorTest < ActiveSupport::TestCase

    test "it should generate empty taste note vector if no taste notes are received" do
        all_taste_notes = []
        taste_notes = []
        assert "()" == Coffee.generate_taste_vector(all_taste_notes, taste_notes)
    end

    test "it should generate a single taste note vector if a taste note is received" do
        all_taste_notes = [TasteNote.new()]
        taste_notes = []
        assert "(0)" == Coffee.generate_taste_vector(all_taste_notes, taste_notes)
    end

    test "it should generate many taste note vector if many taste notes are received" do
        all_taste_notes = [TasteNote.new(), TasteNote.new()]
        taste_notes = []
        assert "(0,0)" == Coffee.generate_taste_vector(all_taste_notes, taste_notes)
    end

    test "it should set to one positions of the vector that are taste notes of the coffee" do
        taste_note = TasteNote.new()
        taste_notes = [taste_note]
        all_taste_notes = [taste_note, TasteNote.new()]
        assert "(1,0)" == Coffee.generate_taste_vector(all_taste_notes, taste_notes)
    end

end