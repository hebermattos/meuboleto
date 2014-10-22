# encoding: utf-8

class Banco < ActiveRecord::Base
  validates :nome , :presence => { :message => " não pode ser nulo" }
  validates :banco ,:presence => { :message => " não pode ser nulo" }
  validates :agencia, :presence => { :message => " não pode ser nulo" }
  validates :conta , :presence => { :message => " não pode ser nulo" }
  validates :cedente , :presence => { :message => " não pode ser nulo" }
  validates :carteira , :presence => { :message => " não pode ser nulo" }
  validates :DocumentoCedente , :presence => { :message => " não pode ser nulo" }
end
