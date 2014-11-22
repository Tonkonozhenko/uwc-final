class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.integer :event_id, index: true

      t.string :title
      t.decimal :price, scale: 2, precision: 8

      t.integer :total
      t.integer :remained

      t.timestamps
    end
  end
end
