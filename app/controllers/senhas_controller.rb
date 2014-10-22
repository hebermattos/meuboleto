# encoding: utf-8

class SenhasController < ApplicationController

  def index
    if session[:id].to_i == params[:id].to_i
      @usuario = Usuario.find(params[:id])
    else
      return redirect_to root_path
    end
  end

  def update
    @usuario = Usuario.find(session[:id].to_i)
    if !senha_valida
      flash[:alert] = "Senhas não coincidem"
      render :index
    else
      if !@usuario.update(usuario_params_senha)
        render :index
      else
        flash[:notice] = "Usuário atualizado com sucesso"
        render :index
      end
    end
  end

  private
  def usuario_params_senha
    params.require(:usuario).permit(:senha)
  end

  def senha_valida
    params[:usuario][:senha].to_s == params[:usuario][:confirmacao].to_s
  end

end
