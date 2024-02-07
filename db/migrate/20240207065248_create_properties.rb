class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :property_type
      t.string :city
      t.string :district
      t.integer :bedrooms
      t.decimal :rent_per_month
      t.string :mrt_line
      t.string :description
      t.string :net_size

      t.timestamps
    end
  end
end
