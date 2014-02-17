class NoticiasController < ApplicationController
  include ActionController::Live
  before_action :fila

  def index
    @noticias = Noticia.all
    @ultima_noticia = Noticia.last
  end

  def new
    @noticia = Noticia.new
  end

  def create
    @noticia = Noticia.new noticias_params
    if @noticia.save
      @central.notifica(@noticia)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update(ultima_noticia)
    @ultima_noticia = ultima_noticia
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    @central.add_observer(self)
    begin
      loop do
        if @ultima_noticia
          response.stream.write "id: #{Time.now}\n"
          response.stream.write "event: update\n"
          response.stream.write "data: {'id': #{@ultima_noticia.id}, 'titulo': #{@ultima_noticia.titulo}, 'descricao': #{@ultima_noticia.descricao}}\n\n"
          @ultima_noticia = nil
        end
      end
    rescue IOError
    ensure
      response.stream.close
    end
  end

  def noticias_params
    params.require(:noticia).permit :id, :titulo, :descricao
  end

  def fila
    @central = Fila.instance
  end
end
