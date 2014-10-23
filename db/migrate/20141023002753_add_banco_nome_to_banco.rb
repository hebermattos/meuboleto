class AddBancoNomeToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :banconome, :string
  end
end
