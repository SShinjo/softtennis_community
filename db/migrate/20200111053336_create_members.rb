class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.references :user
      t.references :community
      t.boolean :is_host, default: false
      t.boolean :is_member, default: false
      t.boolean :is_checked, default: false

      t.timestamps
    end
    add_foreign_key :members, :users, :communities
  end
end
