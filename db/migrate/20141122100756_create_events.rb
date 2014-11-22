class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :starts_at
      t.integer :admin_user_id, index: true

      t.timestamps
    end
  end
end
