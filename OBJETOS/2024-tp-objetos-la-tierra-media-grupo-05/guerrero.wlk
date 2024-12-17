class Guerrero {

    const raza
    var property vida
    const armas = []
    const items = []
    var property estaEnCombate = true

    method vida() = vida
    method cantItems() = items.size()
    method raza() = raza

    method poderArma(arma) {
        arma.poderio()
    }

    method sumatoriaDePoder() {
        return armas.sum({arma => arma.poderio()})
    }

    method tieneArma() = !armas.isEmpty()

    method disminuirVida(unPocoDeVida) {
        vida -= unPocoDeVida
        self.comprobacionVida()
    }

    method comprobacionVida() {
        if(vida < 0){
            vida = 0
            estaEnCombate = false
        }
    }

    method aumentarVida(unPocoDeVida) {
        vida += unPocoDeVida
    }
    method poderio() = raza.poderio(self)

    method cuantosTiene(item) = items.occurrencesOf(item)

    method tienePoder(cantPoder) = self.poderio() > cantPoder
    method tieneArmas(cantArmas) = armas.size() > cantArmas 
    method tieneVida(cantVida) = vida > cantVida 

    method ganarItems(item, cantidad) {
        cantidad.times(items.add(item))
    }

    method perderItems(item, cantidad) {
        cantidad.times(items.remove(item))
    }

    method cantVida(porcentaje) {
        return vida * porcentaje / 100
    }


    
}

class Hobbit {

    method poderio(guerrero) = guerrero.vida() + guerrero.sumatoriaDePoder() + guerrero.cantItems()

}

class Enano {
    const factorDelPoder

    method poderio(guerrero) = guerrero.vida() + factorDelPoder * guerrero.sumatoriaDePoder()
}

class Elfo {
    var property destrezaBase = 2
    var property destrezaPropia

    method poderio(guerrero) = guerrero.vida() + guerrero.sumatoriaDePoder() * (destrezaBase + destrezaPropia)
}

class Humano {
    const limitadorDePoder

    method poderio(guerrero) = guerrero.vida() * guerrero.sumatoriaDePoder() / limitadorDePoder

}

class Maiar {

    var property poderBasico = 15
    var property poderBajoAmenaza = 300

    // method poderio2(guerrero) = guerrero.vida() * poderBasico + guerrero.sumatoriaDePoder() * 2

    method poderio(guerrero) {
        if(guerrero.vida() < 15){
            return guerrero.vida() * 300 + guerrero.sumatoriaDePoder() * 2 
        }
        else {
            return guerrero.vida() * 15 + guerrero.sumatoriaDePoder() * 2
        }
    }
}

class Gollum inherits Hobbit {

    override method poderio(guerrero) = super(guerrero) / 2
    
}