# encoding: utf-8
require 'rubygems'
require 'rghost'

class BoletogeradosController < ApplicationController
  before_action :autenticar, except: [:show]
  skip_before_action :autenticar, only: [:testebb]
  skip_before_action :verify_authenticity_token

  def show
    @boleto_banco = Boletogerado.find(params[:id])

    banco = @boleto_banco.banco.banconome.to_sym

    @boleto = case banco
                when :itau then Brcobranca::Boleto::Itau.new
                when :bb then  Brcobranca::Boleto::BancoBrasil.new
                when :bradesco then Brcobranca::Boleto::Bradesco.new
              end

    @boleto.cedente = @boleto_banco.usuario.nome
    @boleto.documento_cedente = @boleto_banco.banco.DocumentoCedente
    @boleto.sacado = @boleto_banco.sacado
    @boleto.sacado_documento = @boleto_banco.sacado_documento
    @boleto.valor =  @boleto_banco.valor
    @boleto.agencia = @boleto_banco.banco.agencia
    @boleto.conta_corrente = @boleto_banco.banco.conta
    case banco
      when :itau
        # ITAU
        # O que diferencia um tipo de boleto de outro, dentro do itau e o tipo de carteira utilizado.
        @boleto.convenio = "12345"
        @boleto.numero_documento = Time.now.to_i.to_s
      when :bb
        # BB
        # O que diferencia um tipo de boleto de outro, dentro do Banco do Brasil e a quantidade de dígitos do convenio.
        @boleto.convenio = "1238798"
        @boleto.numero_documento = Time.now.to_i.to_s
      when :bb
      else
        @boleto.convenio = "1238798"
        @boleto.numero_documento = Time.now.to_i.to_s
    end

    @boleto.dias_vencimento = 5
    @boleto.data_documento = "2008-02-01".to_date
    @boleto.instrucao1 = "Pagavel na rede bancaria ate a data de vencimento."
    @boleto.instrucao5 = "Apos vencimento pagavel somente nas agencias do banco referido"
    @boleto.instrucao6 = "ACRESCER R$ 3,00 REFERENTE AO BOLETO BANCARIO"
    @boleto.sacado_endereco =  @boleto_banco.sacado_endereco

    headers['Content-Type']= "application/pdf"

    send_data @boleto.to(:pdf), :filename => "boleto_#{banco}.pdf"

  end

  def testebb

    @boleto = Brcobranca::Boleto::BancoBrasil.new

    @boleto.cedente = "nome do cedente"
    @boleto.documento_cedente = "1234356789"
    @boleto.sacado = "nome do sacado"
    @boleto.sacado_documento = "123456789"
    @boleto.valor =  "45.60"
    @boleto.agencia = "1234"
    @boleto.conta_corrente = "123456"
    @boleto.convenio = "1238798"
    @boleto.numero_documento = Time.now.to_i.to_s
    @boleto.dias_vencimento = 5
    @boleto.data_documento = "2008-02-01".to_date
    @boleto.instrucao1 = "Pagavel na rede bancaria ate a data de vencimento."
    @boleto.instrucao5 = "Apos vencimento pagavel somente nas agencias do banco referido"
    @boleto.instrucao6 = "ACRESCER R$ 3,00 REFERENTE AO BOLETO BANCARIO"
    @boleto.sacado_endereco =  "av. brasil 500"

    headers['Content-Type']= "application/pdf"

    send_data @boleto.to(:pdf), :filename => "boleto_teste.pdf"

  end

  def create
    @banco = Banco.find_by_nome params[:boleto][:configuracao]
    if @banco.nil?
      respond_to do |format|
        format.json { render :json => "configuracao de banco não encontrada. configuracoes disponiveis: " + Banco.pluck(:nome).join(", ") , :status => '400' }
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
    data = Date.strptime(params[:data].to_s, "%d-%m-%Y")
    @boletos = Boletogerado.where(usuario_id: @usuario.id, created_at: (data)..(data + 23.hours + 59.minutes + 59.seconds) )
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


