class AddCedenteToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :cedente, :String
  end
end
