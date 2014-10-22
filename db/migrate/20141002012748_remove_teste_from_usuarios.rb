class RemoveTesteFromUsuarios < ActiveRecord::Migration
  def change
    remove_column :usuarios, :teste, :String
  end
end
