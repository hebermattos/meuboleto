# encoding: utf-8

class Boletogerado < ActiveRecord::Base
  belongs_to :banco
  belongs_to :usuario

  validates :valor, :presence => { :message => " não pode ser nulo" }
  validates :valor, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/, :message => " com formato inválido ex: 12.50" }
  validates :valor, :numericality => {:greater_than => 0, :message => " não pode ser menor que zero"}
  validates :sacado, :presence => { :message => " não pode ser nulo" }
  validates :sacado_documento, :presence => { :message => " não pode ser nulo" }
  validates :banco_id, :presence => { :message => " não pode ser nulo" }
  validates :usuario_id,:presence => { :message => " não pode ser nulo" }
end
