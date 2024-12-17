import jugadores.*
import nave.*

class Tarea {
    
    const itemsNecesarios = []

    method puedeRealizar(jugador){
        jugador.tieneItems(itemsNecesarios)
    }

    method realizarsePor(jugador) {
        self.realizarPor(jugador)
        jugador.usarItems(itemsNecesarios)
    }

    method realizarPor(jugador)

}


object arreglarTableroElectrico inherits Tarea(itemsNecesarios = ["llaveInglesa"]) {
    
    override method realizarPor(jugador) {
        jugador.aumentarSospecha(10)
    }
}

object sacarLaBasura inherits Tarea(itemsNecesarios = ["escoba", "bolsa"]){

    override method realizarPor(jugador) {
        jugador.disminuirSospecha(4)
    }
}

object ventilarLaNave inherits Tarea() {

    override method realizarPor(jugador) {
        nave.aumentarNivelOxigeno(5)
    }
}