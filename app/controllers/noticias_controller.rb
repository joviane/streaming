class NoticiasController < ApplicationController
  include ActionController::Live
  before_action :pega_fila

  def index
    @noticias = Noticia.all
  end

  def new
    @noticia = Noticia.new
  end

  def create
    @noticia = Noticia.new noticias_params
    if @noticia.save
      @fila.enfila @noticia
      redirect_to root_path
    else
      render 'new'
    end
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'

    if @fila.fila
      begin
        @fila.fila.each do |noticia|
          response.stream.write "id: #{noticia.id}\n"
          response.stream.write "event: update\n"
          response.stream.write "data: {'titulo': #{noticia.titulo}, 'descricao': #{noticia.descricao}}\n\n"
        end
        #@fila.limpa
      rescue IOError
      ensure
        response.stream.close
      end
    end
  end

  def noticias_params
    params.require(:noticia).permit :id, :titulo, :descricao
  end

  def pega_fila
    @fila = Fila.instance
  end
end
