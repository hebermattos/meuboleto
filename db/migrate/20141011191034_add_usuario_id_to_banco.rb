class AddUsuarioIdToBanco < ActiveRecord::Migration
  def change
    add_reference :bancos, :usuario_id, index: true
  end
end
