require 'observer'

class Fila
  include Singleton

  def initialize
    @observers = []
  end

  def notifica(noticia)
    notify_observers(noticia)
  end

  def notify_observers(noticia)
    @observers.each do |observer|
      observer.update(noticia)
    end
  end

  def add_observer(observer)
    @observers << observer
  end
end
