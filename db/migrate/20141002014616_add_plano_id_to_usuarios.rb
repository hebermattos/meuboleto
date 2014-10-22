class AddPlanoIdToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :plano_id, :integer
  end
end
