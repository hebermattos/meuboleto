class AddCarteiraToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :carteira, :string
  end
end
