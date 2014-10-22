class CreateBoletogerados < ActiveRecord::Migration
  def change
    create_table :boletogerados do |t|
      t.decimal :valor
      t.string :sacado
      t.string :sacado_documento
      t.string :sacado_endereco
      t.references :banco, index: true
      t.references :usuario, index: true

      t.timestamps
    end
  end
end
