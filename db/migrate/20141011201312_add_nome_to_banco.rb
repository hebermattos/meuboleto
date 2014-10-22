class AddNomeToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :nome, :string
  end
end
