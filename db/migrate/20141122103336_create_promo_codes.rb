class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|
      t.references :promocodable, polymorphic: true

      t.string :code

      t.integer :discount_percent
      t.integer :total_applies
      t.integer :remained_applies

      t.timestamps
    end
  end
end
