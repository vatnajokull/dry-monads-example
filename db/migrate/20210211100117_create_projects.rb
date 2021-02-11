class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 14, scale: 2
      t.integer :status, defaul: 0

      t.timestamps
    end
  end
end
