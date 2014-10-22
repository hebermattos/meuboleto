class AddAgenciaToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :agencia, :string
  end
end
