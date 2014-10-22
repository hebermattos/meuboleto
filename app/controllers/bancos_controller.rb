# encoding: utf-8

class BancosController < ApplicationController
  before_action :set_vars 

  def index    
    @bancos = Banco.where(usuario_id_id: @usuario_id)
    @bancos
  end

  def show
    @banco = Banco.find_by usuario_id_id: @usuario_id, id: params[:id]
  end

  def new
    @banco = Banco.new
  end

  def create
    @banco = Banco.new(banco_params)
    @banco.usuario_id_id = @usuario_id
    if @banco.save
      flash[:notice] =  "Configuração criada com sucesso..."
      redirect_to controller: "bancos", action: "index"
    else
      render :new
    end
  end

  def update
    @banco = Banco.find_by usuario_id_id: @usuario_id, id: params[:id]
    if @banco.update(banco_params);
      flash[:notice] =  "Configuração atualizada com sucesso..."
      redirect_to controller: "bancos", action: "index"
    else
      render :show
    end
  end

  def destroy
    @banco = Banco.find(params[:id])
    if @banco.destroy
      flash[:notice] = "Configuração excluída com sucesso..."
    else
      flash[:error] = "Erro ao excluir configuração, tente novamente mais tarde..."
    end
    render :js => "window.location = '/bancos'"
  end

  private
    def set_vars
      @usuario_id = session[:id]
    end

    def banco_params
      params.require(:banco).permit(:nome,:banco, :agencia,:conta,:cedente,:carteira,:DocumentoCedente)
    end
end
