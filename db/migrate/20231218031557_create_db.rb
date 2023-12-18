class CreateDb < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :first_name
      t.string :last_name
      t.string :password_digest
    end
    create_table :events do |t|
      t.string :title
      t.string :tag
      t.datetime :date
      t.string :location
      t.string :open_status
      t.timestamps null: false
    end
    create_table :activity_user_relations do |t|
      t.integer :user_id
      t.integer :event_id
    end
  end
end
