import nave.*
import tareas.*
class Jugador {
    const color
    var mochila = #{} // items adentro
    var nivelDeSospecha = 40
    var tareasARealizar = #{}
    var puedeVotar = true

    method buscarItem(item) {
        mochila.add(item)
    }

    method usarItem(item){
        mochila.remove(item)
    }

    method esSospechoso() = nivelDeSospecha > 50

    method puedeHacer(tarea) = tarea.requisito(self)

    method tieneItem(elemento) {
        mochila.contains(elemento)
    }
    
    method aumentarSospecha(cantidad) {
        nivelDeSospecha += cantidad
    }

    method disminuirSospecha(cantidad) {
        nivelDeSospecha -= cantidad
    }    //Para Juli -> ⭐⭐⭐ :D

    method completarTarea(tarea)

    method completoTodasLasTareas()

    method realizarTarea() {
        const tareaPendiente = tareasARealizar.find({tarea => self.puedeHacer(tarea)})  
        self.completarTarea(tareaPendiente)  
    }

    method tieneMochilaVacia() = mochila.isEmpty()

    method votar()
    
    method votarEnBlanco(){
        nave.agregarVotoBlanco()
    }


}

class Impostor inherits Jugador {

    override method puedeHacer(tarea) = true

    override method completoTodasLasTareas() = true
    
    override method votar() {
        nave.alguienRandom()
    }



}

class Tripulantes inherits Jugador {
    
    var personalidad
    
    override method completarTarea(tarea) {
        tarea.efectoPorRealizar(self)
        tareasARealizar.remove(tarea)
        nave.todasLasTareasCompletadas() // Aviso a la nave
    }

    override method completoTodasLasTareas() = tareasARealizar.isEmpty()

    override method votar() {
        if(puedeVotar){
            nave.agregarVoto(personalidad.votarPorPersonalidad()) //:D
        }else{
            self.votarEnBlanco()
        }
    }
    
}

//ROLES

object troll {
    method votarPorPersonalidad() = nave.personaNoSospechosa()
}

object detective {
    method votarPorPersonalidad() = nave.personaMasSospechosa()
}

object materialistas {
    method votarPorPersonalidad() = nave.personaPobre() 
}

