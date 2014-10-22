require 'rubygems'
require 'rghost'

#coding : utf-8
class TestesController < ApplicationController
  layout 'brlayout'

  #TODO passar esses caras para Brcobranca::Boleto::Base
  FORMATOS_SUPORTADOS={
    :pdf => 'application/pdf',
    :jpg => 'image/jpg',
    :tif => 'image/tiff',
    :png => 'image/png'
  }

  def gerar_boleto
    banco=params[:banco].to_sym

    RGhost::Config::GS[:path]="C:\\Boleto\\gswin64c.exe"

    @boleto = case banco
    when :itau then Brcobranca::Boleto::Itau.new
    when :bb then  Brcobranca::Boleto::BancoBrasil.new
    when :hsbc then Brcobranca::Boleto::Hsbc.new
    when :real then Brcobranca::Boleto::Real.new
    when :bradesco then Brcobranca::Boleto::Bradesco.new
    when :unibanco then Brcobranca::Boleto::Unibanco.new
    when :caixa then Brcobranca::Boleto::Caixa.new
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
    when :hsbc
      # HSBC
      # O que diferencia um tipo de boleto de outro, dentro do HSBC e a quantidade de dígitos do numero do documento.
      @boleto.numero_documento = "102008"
    when :unibanco
      # UNIBANCO
      @boleto.convenio = "1238798"
      @boleto.numero_documento = "7777700168"
    when :caixa
      # CAIXA
      @boleto.agencia = "1565"
      @boleto.numero_documento = "123456789123456"
      @boleto.conta_corrente = "0013877"
      @boleto.convenio = "100000"
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

    #formato=params[:boleto][:formato].to_sym
    # formato.inspect

    headers['Content-Type']= "application/pdf"

    send_data @boleto.to(:pdf), :filename => "boleto_#{banco}.pdf"
  end

  def index
    @formatos=FORMATOS_SUPORTADOS.keys.map{|v| v.to_s}.sort.map{|v| [v,v]}.sort
  end

  def boleto_hash
    @boleto = Brcobranca::Boleto::BancoBrasil.new :cedente => "Kivanio Barbosa",
    :documento_cedente => "12345678912",
    :sacado => "Claudio Pozzebom",
    :sacado_documento => "12345678900",
    :valor => 135.00,
    :agencia => "4042",
    :conta_corrente => "61900",
    :convenio => "1238798",
    :numero_documento => "7777700168",
    :dias_vencimento => 5,
    :data_documento => "2008-02-01".to_date,
    :instrucao1 => "Pagavel na rede bancaria ate a data de vencimento.",
    :instrucao2 => "Juros de mora de 2.0% mensal(R$ 0,09 ao dia)",
    :instrucao3 => "DESCONTO DE R$ 29,50 APOS 05/11/2006 ATE 15/11/2006",
    :instrucao4 => "NAO RECEBER APOS 15/11/2006",
    :instrucao5 => "Apos vencimento pagavel somente nas agencias do Banco do Brasil",
    :instrucao6 => "ACRESCER R$ 4,00 REFERENTE AO BOLETO BANCARIO",
    :sacado_endereco => "Av. Rubens de Mendonca, 157 - 78008-000 - Cuiaba/MT"

    send_data @boleto.to_pdf, :filename => "boleto_hash.pdf"
  end

  def boleto_em_bloco
    @boleto = Brcobranca::Boleto::BancoBrasil.new do |boleto|
      boleto.cedente = "Kivanio Barbosa",
      boleto.documento_cedente = "12345678912",
      boleto.sacado = "Claudio Pozzebom",
      boleto.sacado_documento = "12345678900",
      boleto.valor = 135.00,
      boleto.agencia = "4042",
      boleto.conta_corrente = "61900",
      boleto.convenio = "1238798",
      boleto.numero_documento = "7777700168",
      boleto.dias_vencimento = 5,
      boleto.data_documento = "2008-02-01".to_date,
      boleto.instrucao1 = "Pagavel na rede bancaria ate a data de vencimento.",
      boleto.instrucao2 = "Juros de mora de 2.0% mensal(R$ 0,09 ao dia)",
      boleto.instrucao3 = "DESCONTO DE R$ 29,50 APOS 05/11/2006 ATE 15/11/2006",
      boleto.instrucao4 = "NAO RECEBER APOS 15/11/2006",
      boleto.instrucao5 = "Apos vencimento pagavel somente nas agencias do Banco do Brasil",
      boleto.instrucao6 = "ACRESCER R$ 4,00 REFERENTE AO BOLETO BANCARIO",
      boleto.sacado_endereco = "Av. Rubens de Mendonca, 157 - 78008-000 - Cuiaba/MT"
    end

    send_data @boleto.to_pdf, :filename => "boleto_em_bloco.pdf"
  end


  def multi_boleto
    boleto_dados = {:cedente => "Kivanio Barbosa",
      :documento_cedente => "12345678912",
      :sacado => "Claudio Pozzebom",
      :sacado_documento => "12345678900",
      :valor => 135.00,
      :agencia => "4042",
      :conta_corrente => "61900",
      :convenio => "1238798",
      :numero_documento => "7777700168",
      :dias_vencimento => 5,
      :data_documento => "2008-02-01".to_date,
      :instrucao1 => "Pagavel na rede bancaria ate a data de vencimento.",
      :instrucao2 => "Juros de mora de 2.0% mensal(R$ 0,09 ao dia)",
      :instrucao3 => "DESCONTO DE R$ 29,50 APOS 05/11/2006 ATE 15/11/2006",
      :instrucao4 => "NAO RECEBER APOS 15/11/2006",
      :instrucao5 => "Apos vencimento pagavel somente nas agencias do Banco do Brasil",
      :instrucao6 => "ACRESCER R$ 4,00 REFERENTE AO BOLETO BANCARIO",
      :sacado_endereco => "Av. Rubens de Mendonca, 157 - 78008-000 - Cuiaba/MT"}

      @boletos = []
      @boleto = Brcobranca::Boleto::BancoBrasil.new(boleto_dados)
      @boleto2 = Brcobranca::Boleto::Bradesco.new(boleto_dados)
      @boletos << @boleto
      @boletos << @boleto2

      send_data Brcobranca::Boleto::Base.lote(@boletos), :filename => "multi_boleto.pdf"
    end

  end
