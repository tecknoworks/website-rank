class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :url
      t.string :sid
      t.integer :score
      t.json :payload

      t.timestamps null: false
    end
  end
end
