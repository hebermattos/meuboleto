class AddCedenteToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :cedente, :string
  end
end
