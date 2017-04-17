require_relative 'manejo_automata.rb'
class ManejoCadena

  def esDigito (simbolo)
    return simbolo.match(/^[0-9]/)
  end

  def esPunto(simbolo)
    return simbolo.match(/[.]/)
  end

  def esExponente(simbolo)
    return simbolo.match(/[\^]/)
  end

  def esE(simbolo)
    return simbolo.match(/[eE]/)
  end

  def esSignoMasMenos(simbolo)
    if(simbolo.match(/[-+]/))
      return true
    else
      return false
    end
  end

  def esLetra(simbolo)
    return simbolo =~/^[a-zA-Z]/
  end

  def esOperador(simbolo)
    if(simbolo.match(/^[+]/))
      return true
    elsif(simbolo.match(/^[-]/))
      return true
    elsif(simbolo.match(/^[*]/))
      return true
    elsif(simbolo.match(/^[\/]/))
      return true
    else
      return false
    end
  end

  def separarCadena(cadena)
    cadena = cadena.gsub(" ","")
    cadena = cadena.gsub("*"," * ")
    cadena = cadena.gsub("/"," / ")
    cadena = cadena.gsub("+"," + ")
    cadena = cadena.gsub("-"," - ")
    cadena = cadena.gsub("("," ( ")
    cadena = cadena.gsub(")"," ) ")
    cadena = cadena.gsub("$"," $ ")
    array = cadena.split(" ")
    array.reverse!
    return array
  end

  def separarRegla(regla)
    if(regla.match(/.+'/))
      regla = regla.gsub("E'"," E' ")
      regla = regla.gsub("T'"," T' ")
      regla = regla.gsub("+"," + ")
      regla = regla.gsub("-"," - ")
      regla = regla.gsub("*"," * ")
      regla = regla.gsub("/"," / ")
    else
      regla = regla.gsub("T"," T ")
      regla = regla.gsub("E"," E ")
    end
    return regla.split(" ")
  end

  def esTerminal(cadena)
    begin
      if cadena.match(/[+]|[-]|[\/]|[*]|[(]|[)]|[$]/)
        return true
      elsif ManejoAutomata.new.esIdentificador(cadena)&&cadena!="E"&&cadena!="E'"&&cadena!="T"&&cadena!="T'"&&cadena!="F"
        return true
      elsif ManejoAutomata.new.esNumero(cadena)
        return true
      else
        return false
      end
    rescue =>error
      return false
    end
  end

  def queEs(simbolo)
    begin
      if simbolo.match(/[+]|[-]|[\/]|[*]|[(]|[)]|[$]/)
        return simbolo
      elsif ManejoAutomata.new.esIdentificador(simbolo)
        return "id"
      elsif ManejoAutomata.new.esNumero(simbolo)
        return "num"
      else
        return simbolo
      end
    rescue =>error

      if ManejoAutomata.new.esIdentificador(simbolo)
        return "identificador"
      elsif ManejoAutomata.new.esNumero(simbolo)
        return "numero"
      end

      return simbolo
    end
  end


end
=begin
=end