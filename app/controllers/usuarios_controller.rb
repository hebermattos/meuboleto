# encoding: utf-8

class UsuariosController < ApplicationController

  def new
    @usuario = Usuario.new
  end

  def show
    if session[:id].to_i == params[:id].to_i
      @usuario = Usuario.find(params[:id])
    else
      return redirect_to root_path
    end
  end

  def create
    if !senha_valida
      flash[:alert] = "Senhas não coincidem"
      render :new
    else
      @usuario = Usuario.new(usuario_params)
      if !@usuario.save
        render :new
      else
        session[:id] = @usuario.id
        session[:nome] = @usuario.nome
        redirect_to root_path
      end
    end
  end

  def update
    @usuario = Usuario.find(params[:id])
    if !@usuario.update(usuario_params)
      render :show
    else
      flash[:notice] = "Usuário atualizado com sucesso"
      redirect_to action: "show"
    end
  end

  private
  def usuario_params
    params.require(:usuario).permit(:nome,:senha,:email,:plano_id)
  end

  def senha_valida
    params[:usuario][:senha].to_s == params[:usuario][:confirmacao].to_s
  end

end
