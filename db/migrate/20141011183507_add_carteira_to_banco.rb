class AddCarteiraToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :carteira, :String
  end
end
