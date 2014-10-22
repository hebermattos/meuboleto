class AddContaToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :conta, :string
  end
end
