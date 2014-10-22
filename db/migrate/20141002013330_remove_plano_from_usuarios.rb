class RemovePlanoFromUsuarios < ActiveRecord::Migration
  def change
    remove_column :usuarios, :plano, :integer
  end
end
