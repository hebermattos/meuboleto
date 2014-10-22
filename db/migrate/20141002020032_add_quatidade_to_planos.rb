class AddQuatidadeToPlanos < ActiveRecord::Migration
  def change
    add_column :planos, :quantidade, :integer
  end
end
