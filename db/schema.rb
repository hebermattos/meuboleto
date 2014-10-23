# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141023002753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bancos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "carteira"
    t.string   "cedente"
    t.string   "DocumentoCedente"
    t.integer  "usuario_id_id"
    t.string   "nome"
    t.string   "conta"
    t.string   "agencia"
    t.string   "banconome"
  end

  add_index "bancos", ["usuario_id_id"], name: "index_bancos_on_usuario_id_id", using: :btree

  create_table "boleto_gerados", force: true do |t|
    t.string   "sacado"
    t.string   "sacadoDocumento"
    t.decimal  "valor"
    t.string   "sacadoEndereco"
    t.datetime "dataDocumento"
    t.integer  "diasVencimento"
    t.integer  "banco_id_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boleto_gerados", ["banco_id_id"], name: "index_boleto_gerados_on_banco_id_id", using: :btree

  create_table "boletogerados", force: true do |t|
    t.decimal  "valor"
    t.string   "sacado"
    t.string   "sacado_documento"
    t.string   "sacado_endereco"
    t.integer  "banco_id"
    t.integer  "usuario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boletogerados", ["banco_id"], name: "index_boletogerados_on_banco_id", using: :btree
  add_index "boletogerados", ["usuario_id"], name: "index_boletogerados_on_usuario_id", using: :btree

  create_table "planos", force: true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantidade"
  end

  create_table "usuarios", force: true do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "senha"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plano_id"
  end

end
