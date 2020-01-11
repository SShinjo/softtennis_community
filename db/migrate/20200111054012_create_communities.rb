class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities do |t|
      t.string :name
      t.text :introduction
      t.date :date
      t.time :time
      t.string :place
      t.integer :capacity
      t.boolean :is_closed, default: false
      t.boolean :is_held, default: false

      t.timestamps
    end
  end
end
