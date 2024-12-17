object pepita {
    var energia = 500
    var posicion = 0

    method energia() = energia
    method posicion() = posicion

    method vuela(kilometros) {
        energia -= 10 + kilometros
    }

    method come(gramo){
        energia += 4 * gramo
    }

    method ir(lugar) {
      self.vuela(lugar.kilometro() - posicion)
      posicion = lugar.kilometro()
    }

    method puedeIr(lugar){
        // self.vuela(lugar.kilometro())
        if (self.energia() >= lugar.kilometro() + 10){
            return "Puede viajar"
        } else {
        return "No puede viajar"
        }
    }
}

object ruta9 {
    method kilometro() = 100
}

object laLomaDelOrto {
  method kilometro() = 90000
}