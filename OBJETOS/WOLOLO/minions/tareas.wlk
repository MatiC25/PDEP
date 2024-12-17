class Tarea {

    method puedeRealizar(unJugador)
}

class ArreglarUnaMaquina {

    var itemsNecesarios = []
    var complejidad

    method dificultad() = complejidad
    
    method tieneItemsNecesarios(unJugador) = itemsNecesarios.all({item => unJugador.tiene(item)})

    method puedeRealizar(unJugador) = unJugador.estamina() >= complejidad || self.tieneItemsNecesarios(unJugador)

}

class TrabajarMaquina inherits ArreglarUnaMaquina {

    override method dificultad() = super() * 2

    override method puedeRealizar(unJugador) = unJugador.estamina() >= self.dificultad()
}