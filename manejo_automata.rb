require_relative 'automata.rb'
require_relative 'automata_numero.rb'
require_relative 'automata_identificador.rb'
require_relative 'manejo_cadena.rb'

class ManejoAutomata

  def esNumero(cadena)

    estado = 1
    automataNumero = AutomataNumero.new(estado)
    cadena.each_char{|simbolo|
      begin
        estado = automataNumero.transicion(simbolo)
        if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
        end
      rescue => error
        return false
      end
    }
    return automataNumero.esFinal(estado)
  end

  def esIdentificador(cadena)
    estado = 1
    automataIdentificador = AutomataIdentificador.new(estado)
    cadena.each_char{|simbolo|
      begin
        estado = automataIdentificador.transicion(simbolo)
        if estado<0
        puts "Error: #{simbolo} : #{ManejoErrores.new.obtenerDescripcion(estado)}"
        break
        end
      rescue => error
        return false
      end
    }
      return automataIdentificador.esFinal(estado)

  end

end