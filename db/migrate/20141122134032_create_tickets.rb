class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :ticket_type_id
      t.string :name
      t.string :email
      t.string :cc_number
      t.string :promo_code_id
      t.decimal :price, scale: 2, precision: 8

      t.timestamps
    end
    add_index :tickets, :ticket_type_id
    add_index :tickets, :cc_number
  end
end
