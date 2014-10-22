class AddTesteToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :teste, :string
  end
end
