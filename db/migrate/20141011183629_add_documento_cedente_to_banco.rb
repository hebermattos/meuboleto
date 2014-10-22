class AddDocumentoCedenteToBanco < ActiveRecord::Migration
  def change
    add_column :bancos, :DocumentoCedente, :string
  end
end
