class Fila
  include Singleton

  def initialize
    @fila = []
  end

  def enfila(objeto)
    @fila << objeto
  end

  def fila
    @fila
  end

  def limpa
    @fila = []
  end
end
