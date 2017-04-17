require_relative 'automata.rb'
require_relative 'manejo_cadena.rb'

class AutomataIdentificador < Automata

  def initialize(estado)
    super(estado)
    @estadosFinales = [2]
  end

  def transicion(simbolo)
    case @estado
      when 1
        if ManejoCadena.new.esLetra(simbolo)
          @estado=2
        else
          @estado=-3
        end
      when 2
        if ManejoCadena.new.esDigito(simbolo)
          @estado=2
        elsif ManejoCadena.new.esLetra(simbolo)
          @estado=2
        else
          @estado=-4
        end
    end
  end

  def esFinal(estado)
    @estadosFinales.each{|estadoFinal|
      if(estado==estadoFinal)
        return true
      end
    }
    return false
  end
end