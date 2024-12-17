class EfectoItem {

    const item 
    const cantidad

    method ganarItem(persona){
        persona.ganarItems(item, cantidad)
    }

    method perderItem(persona){
        persona.perderItems(item, cantidad)
    }
}


class EfectoVida {

    method aumentarVida(persona)

    method disminuirVida(persona)
}


class EfectoVidaPorcetaje inherits EfectoVida {

    const porcentaje
    method porcentaje() = porcentaje

    override method aumentarVida(persona) {
      persona.aumentarVida(persona.cantVida(porcentaje))
    }

    override method disminuirVida(persona) {
      persona.disminuirVida(persona.cantVida(porcentaje))
    }

}

class EfectoVidaPorValor inherits EfectoVida {

    const cantidad 

    override method aumentarVida(persona) {
        persona.aumentarVida(cantidad)
    }

    
    override method disminuirVida(persona) {
        persona.disminuirVida(cantidad)
    }

}

object sinEfecto {

    method aplicar(persona) {}
    
}