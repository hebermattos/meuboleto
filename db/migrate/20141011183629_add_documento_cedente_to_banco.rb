class AddDocumentoCedenteToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :DocumentoCedente, :String
  end
end
