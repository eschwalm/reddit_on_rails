class CreateSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :subs do |t|
      t.string :name, null: false
      t.text :description
      t.integer :moderator_id, null: false

      t.timestamps
    end

    add_index :subs, :name, unique: true
    add_index :subs, :moderator_id
  end
end
