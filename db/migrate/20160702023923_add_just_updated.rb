class AddJustUpdated < ActiveRecord::Migration[5.0]
  def change
    add_column :charts, :just_updated, :boolean
  end
end
