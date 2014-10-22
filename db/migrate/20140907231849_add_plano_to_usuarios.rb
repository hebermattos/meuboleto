class AddPlanoToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :plano, :int
  end
end
