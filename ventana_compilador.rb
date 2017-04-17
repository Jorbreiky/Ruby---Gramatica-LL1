require_relative 'manejo_cadena.rb'
require 'fox16'
include Fox
class VentanaCompilador<FXMainWindow

  def initialize(app)
    super(app,"Ventana",:width=>550,:height=>400)

    @finales = ["+","-","*","/","(",")","num","id","$"]
    @noFinales = ["E","E'","T","T'","F"]
    @reglas = [[nil,nil,nil,nil,"TE'",nil,"TE'","TE'",nil],
               ["+TE'","-TE'",nil,nil,nil,"",nil,nil,""],
               [nil,nil,nil,nil,"FT'",nil,"FT'","FT'",nil],
               ["","","*FT'","/FT'",nil,"",nil,nil,""],
               [nil,nil,nil,nil,"(E)",nil,"num","id",nil]]

    fuente = FXFont.new(app,"Modern,120,BOLD,0")

    lblSintaxis = FXLabel.new(self,"CADENA: ",:opts=>LAYOUT_EXPLICIT,:x=>20,:y=>40,:width=>100,:height=>30)

    @btnAceptar = FXButton.new(self,"Analizar",:opts=>LAYOUT_EXPLICIT,:x=>400,:y=>40,:width=>120,:height=>30)
    @btnAceptar.font= FXFont.new(app,"Aparajita,80,BOLD,0")
    @btnAceptar.connect(SEL_COMMAND)do
      arrayCadena = ManejoCadena.new.separarCadena(@txtSintaxis.getText+"$")
      analizarToken(arrayCadena)
    end

    @txtSintaxis = FXText.new(self,:opts=>LAYOUT_EXPLICIT,:x=>125,:y=>40,:width=>270,:height=>30)
    @txtSintaxis.font= FXFont.new(app,"Aparajita,120,BOLD,0")
    @txtSintaxis.setText("suma-8.1*ide/(88.9*98)")

    @txtConsola = FXText.new(self,:opts=>LAYOUT_EXPLICIT,:x=>20,:y=>75,:width=>505,:height=>270)
    @txtConsola.font= FXFont.new(app,"Aparajita,80,BOLD,0")
    @txtConsola.setText("Consola: \n")


    menubar = FXMenuBar.new(self,LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
    filemenu = FXMenuPane.new(self)
    FXMenuCommand.new(filemenu, "&Analizar\tCtl-O").connect(SEL_COMMAND) do
      arrayCadena = ManejoCadena.new.separarCadena(@txtSintaxis.getText)
      analizarToken(arrayCadena)
    end
    FXMenuCommand.new(filemenu, "&Salir\tCtl-Q", nil, getApp(), FXApp::ID_QUIT)
    FXMenuTitle.new(menubar, "&Archivo", nil, filemenu)

    lblFondo = FXLabel.new(self,"",:opts=>LAYOUT_EXPLICIT,:x=>0,:y=>0,:width=>700,:height=>700)
    lblFondo.icon=FXPNGIcon.new(app,File.open("IMG/fondo.png","rb").read)
    lblFondo.iconPosition=ICON_BEFORE_TEXT
    lblFondo.layoutHints = LAYOUT_CENTER_X|LAYOUT_CENTER_Y
  end

  def analizarToken(arrayCadena)
    @txtConsola.setText("Consola:\n")
    pilaSimbolos = ["E","$"]
    a = arrayCadena.pop
    begin
      x = pilaSimbolos.first
      @txtConsola.appendText("X= #{x}\n")
      @txtConsola.appendText("a= #{a}\n")

      if ManejoCadena.new.esTerminal(x) or x=="$"
        if x==ManejoCadena.new.queEs(a)
          @txtConsola.appendText("#{a} == #{x}\n")
          @txtConsola.appendText("#{x} Es terminal\n")
          pilaSimbolos.shift
          a = arrayCadena.pop
        else
          @txtConsola.appendText("error\n")
          break
        end
      else
        regla = obtenerRegla(a,x)
        @txtConsola.appendText("Regla: #{regla}\n")
        if regla != nil
          pilaSimbolos.shift
          regla = ManejoCadena.new.separarRegla(regla)
          pilaSimbolos=regla.concat(pilaSimbolos)
          @txtConsola.appendText("Pila de Simbolos: #{pilaSimbolos.to_s}\n")
        else
          @txtConsola.appendText("error\n")
          break
        end

      end

    end while(x!="$")
    if pilaSimbolos.length==0
      @txtConsola.appendText("Gramatica Aceptada")
    else
      @txtConsola.appendText("Gramatica no Aceptada")
    end
  end

  def obtenerRegla(terminal,noTerminal)
    begin
      t = @finales.index(ManejoCadena.new.queEs(terminal))
      nt = @noFinales.index(noTerminal)
      regla = @reglas[nt][t]
      return regla
    rescue => error
      @txtConsola.appendText("Error no se encontro le simbolo terminal en la regla: #{terminal}\n")
      @txtConsola.appendText("#{error.message}\n")
    end
  end

  def create
    super
  end

  def show
    super(PLACEMENT_SCREEN)
  end
end

=begin
=end
app = FXApp.new
main = VentanaCompilador.new(app)
main.show
app.create()
app.run()
