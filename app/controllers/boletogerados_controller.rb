# encoding: utf-8
require 'rubygems'
require 'rghost'

class BoletogeradosController < ApplicationController
  before_action :autenticar, except: [:show]
  skip_before_action :verify_authenticity_token

  def show
    @boleto_banco = Boletogerado.find(params[:id])

    banco = @boleto_banco.banco.banconome.to_sym

    @boleto = case banco
                when :itau then Brcobranca::Boleto::Itau.new
                when :bb then  Brcobranca::Boleto::BancoBrasil.new
                when :bradesco then Brcobranca::Boleto::Bradesco.new
              end

    @boleto.cedente = "Kivanio Barbosa"
    @boleto.documento_cedente = "12345678912"
    @boleto.sacado = "Claudio Pozzebom"
    @boleto.sacado_documento = "12345678900"
    @boleto.valor = 11135.00
    @boleto.agencia = "4042"
    @boleto.conta_corrente = "61900"

    case banco
      when :itau
        # ITAU
        # O que diferencia um tipo de boleto de outro, dentro do itau e o tipo de carteira utilizado.
        @boleto.convenio = "12345"
        @boleto.numero_documento = "102008"
      when :bb
        # BB
        # O que diferencia um tipo de boleto de outro, dentro do Banco do Brasil e a quantidade de dígitos do convenio.
        @boleto.convenio = "1238798"
        @boleto.numero_documento = "7777700168"
      else
        @boleto.convenio = "1238798"
        @boleto.numero_documento = "102008"
    end

    @boleto.dias_vencimento = 5
    @boleto.data_documento = "2008-02-01".to_date
    @boleto.instrucao1 = "Pagavel na rede bancaria ate a data de vencimento."
    @boleto.instrucao2 = "Juros de mora de 2.0% mensal(R$ 0,09 ao dia)"
    @boleto.instrucao3 = "DESCONTO DE R$ 29,50 APOS 05/11/2006 ATE 15/11/2006"
    @boleto.instrucao4 = "NaO RECEBER APoS 15/11/2006"
    @boleto.instrucao5 = "Apos vencimento pagavel somente nas agencias do Banco do Brasil"
    @boleto.instrucao6 = "ACRESCER R$ 4,00 REFERENTE AO BOLETO BANCARIO"
    @boleto.sacado_endereco = "Av. Rubens de Mendonca, 157 - 78008-000 - Cuiaba/MT"

    headers['Content-Type']= "application/pdf"

    send_data @boleto.to(:pdf), :filename => "boleto_#{banco}.pdf"

  end

  def create
    @banco = Banco.find_by_banconome params[:boleto][:banconome]
    if @banco.nil?
      respond_to do |format|
        format.json { render :json => "configuracao de banco não encontrada. bancos: " + Banco.all.to_s , :status => '400' }
      end
    else
    @boleto = Boletogerado.create(boleto_params)
    @boleto.usuario_id = @usuario.id
    @boleto.banco_id = @banco.id
    if @banco
      if @boleto.save
      respond_to do |format|
        format.json { render :json => @boleto }
      end
    else
      respond_to do |format|
        format.json { render :json => @boleto.errors.full_messages, :status => '400' }
      end
    end
    else
      respond_to do |format|
        format.json { render :json => "Configuração não encontrada", :status => '400' }
      end
    end
    end
  end

  def get
    @boletos = Boletogerado.find(params[:id])
    respond_to do |format|
      format.json { render :json => @boletos }
    end
  end

  def getall
    @boletos = Boletogerado.where(usuario_id: @usuario.id)
    respond_to do |format|
      format.json { render :json => @boletos }
    end
  end

  private
  def boleto_params
    params.require(:boleto).permit(:valor,:sacado,:sacado_endereco, :sacado_documento)
  end

  def autenticar
    authenticate_or_request_with_http_basic do |username, password|
      @usuario = Usuario.find_by email: username, senha: password
    end
  end

end


