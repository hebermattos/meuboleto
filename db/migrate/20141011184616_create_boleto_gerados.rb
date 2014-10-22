class CreateBoletoGerados < ActiveRecord::Migration
  def change
    create_table :boleto_gerados do |t|
      t.string :sacado
      t.string :sacadoDocumento
      t.decimal :valor
      t.string :sacadoEndereco
      t.datetime :dataDocumento
      t.integer :diasVencimento
      t.references :banco_id, index: true

      t.timestamps
    end
  end
end
