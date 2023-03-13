class TasteVectorGeneratorTest < ActiveSupport::TestCase

    test "it should generate empty taste note vector if no taste notes are received" do
        coffee = Coffee.new()
        all_taste_notes = []
        taste_notes = []
        assert "()" == coffee.generate_taste_vector(all_taste_notes, taste_notes)
    end

    test "it should generate a single taste note vector if a taste note is received" do
        coffee = Coffee.new()
        all_taste_notes = [TasteNote.new()]
        taste_notes = []
        assert "(0)" == coffee.generate_taste_vector(all_taste_notes, taste_notes)
    end

    test "it should generate many taste note vector if many taste notes are received" do
        coffee = Coffee.new()
        all_taste_notes = [TasteNote.new(), TasteNote.new()]
        taste_notes = []
        assert "(0,0)" == coffee.generate_taste_vector(all_taste_notes, taste_notes)
    end

end