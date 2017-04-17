require_relative 'automata.rb'
require_relative 'manejo_cadena.rb'
class AutomataNumero < Automata
  def initialize(estado)
    super @estado = estado
    @estadosFinales = [3,7]
  end

  def transicion(simbolo)
      case @estado
        when 1
          if ManejoCadena.new.esDigito(simbolo)
            @estado = 3
          elsif ManejoCadena.new.esSignoMasMenos(simbolo)
            @estado = 2
          else
            @estado = -5
          end
        when 2
          if ManejoCadena.new.esDigito(simbolo)
            @estado = 3
          else
            @estado = -6
          end
        when 3
          if ManejoCadena.new.esDigito(simbolo)
            @estado = 3
          elsif ManejoCadena.new.esPunto(simbolo)
            @estado = 4
          elsif ManejoCadena.new.esE(simbolo)
            @estado = 5
          elsif ManejoCadena.new.esExponente(simbolo)
            @estado = 6
          else
            @estado = -2
          end
        when 4
          if ManejoCadena.new.esDigito(simbolo)
            @estado = 7
          else
            @estado = -7
          end

        when 5
          if ManejoCadena.new.esDigito(simbolo)
            @estado = 7
          elsif ManejoCadena.new.esSignoMasMenos(simbolo)
            @estado = 8
          else
            @estado = -8
          end
        when 6
          if ManejoCadena.new.esDigito(simbolo)
            @estado = 7
          else
            @estado = -9
          end
        when 8
          if ManejoCadena.new.esDigito(simbolo)
            @estado = 7
          else
            @estado=-6
          end
        when 7
        if ManejoCadena.new.esDigito(simbolo)
          @estado = 7
        else
          @estado = -10
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