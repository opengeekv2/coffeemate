class CreateCoffees < ActiveRecord::Migration[7.0]
  def change
    create_table :coffees do |t|
      t.string :title
      t.string :ecommerce_link

      t.timestamps
    end
  end
end
