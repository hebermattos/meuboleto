# encoding: utf-8

class Usuario < ActiveRecord::Base
  validates :nome, :presence => { :message => " não pode ser nulo" }
  validates :email, :presence => { :message => " não pode ser nulo" }
  validates :email, :uniqueness => { :message => " inválido",  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create } }
  validates :senha, :presence => { :message => " não pode ser nulo" }
  validates :plano_id,:presence => { :message => " não pode ser nulo" }
end

