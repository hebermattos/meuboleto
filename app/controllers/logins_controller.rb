# encoding: utf-8

class LoginsController < ApplicationController
  def create
    @usuariobanco = Usuario.find_by email: params[:usuario][:email], senha: params[:usuario][:senha]
    if @usuariobanco.nil?
      flash[:alert] = "Usuário não encontrado"
      redirect_to controller: "logins", action: 'index'
    else
      session[:id] = @usuariobanco.id
      session[:nome] = @usuariobanco.nome
      redirect_to controller: "usuarios", action: 'show', id: @usuariobanco.id
    end
  end

  def index
    @login = Usuario.new
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
