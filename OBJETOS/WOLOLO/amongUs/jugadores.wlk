
import nave.*

class Jugador {
    const color = "rojo"
    var mochila = []
    var nivelDeSospecha = 40
    var tareas = #{}

    method nivelDeSospecha() = nivelDeSospecha

    method esSospechoso() = nivelDeSospecha > 50

    method aumentarSospecha(cantSospecha) {
        nivelDeSospecha += cantSospecha
    }

    method disminuirSospecha(cantSospecha) {
        nivelDeSospecha = 0.max(nivelDeSospecha- cantSospecha)
    }


    method realizarTarea()

    method tareaHacible() {
        return tareas.find {tarea => tarea.puedeRealizar(self)}
    }

    method buscarItem(item) {
        mochila.add(item)
    } 

    method tieneItem(item) = mochila.contains(item)

    method tieneItems(items) {
        mochila.all {item => self.tieneItem(item)}
    }

    method usarItem(item){
        mochila.remove(item)
    }

    method usarItems(items) {
        mochila.all {item => self.usarItem(item)}
    }

    method tareaCompletada(tarea) {
        tareas.remove(tarea)
        nave.tareaHecha()
    }

    method todasLasTareasCompleatadas() 
}

class Tripulante inherits Jugador {

    override method todasLasTareasCompleatadas() {
        return tareas.isEmpty()
    }

    override method realizarTarea() {
        const tarea = self.tareaHacible()
        tarea.realizarsePor(self)
        self.tareaCompletada(tarea)
    }

}

class Impostor inherits Jugador {
    override method todasLasTareasCompleatadas() = true

    override method realizarTarea() {
        //No hace un carajo
    }
}