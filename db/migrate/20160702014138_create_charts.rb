class CreateCharts < ActiveRecord::Migration[5.0]
  def change
    create_table :charts do |t|
      t.integer :songid
      t.string :diff
      t.integer :notes
      t.string :title
      t.integer :version
      t.integer :clear
      t.integer :score
      t.integer :miss
      t.boolean :gimmicks
      t.integer :nc_level
      t.integer :hc_level
      t.integer :target_clear
      t.integer :target_priority
      t.string :description

      t.timestamps
    end
  end
end
