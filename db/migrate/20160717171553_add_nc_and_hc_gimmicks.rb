class AddNcAndHcGimmicks < ActiveRecord::Migration[5.0]
  def change
    remove_column :charts, :gimmicks
    add_column :charts, :nc_gimmicks, :boolean
    add_column :charts, :hc_gimmicks, :boolean
  end
end
