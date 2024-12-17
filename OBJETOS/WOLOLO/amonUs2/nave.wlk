import jugador.*
import tareas.*

object nave {
    var importores = #{}
    var tripulantes = #{}
    var jugadores = #{}
    var oxigeno = 0
    var votos = #{} 
    var votosEnblanco = 0

    method aumentarOxigeno(cantOxigeno) {
        oxigeno += cantOxigeno
    }

    
    method disminuirOxigeno(cantOxigeno) {
        oxigeno -= cantOxigeno
        self.validarGanador()
    }


    method todasLasTareasCompletadas() {

        if(tripulantes.all({tripulante => tripulante.completoTodasLasTareas()})){
            throw new Exception(message = "Ganaron los tripulantes !!!")
        }

    }

    method impostoresVivos() {
    return importores.occurrencesOf({ impostor => jugadores.contains(impostor) })
    } 
      
    method tripulantesVivos() {
    return tripulantes.occurrencesOf({ tripulante => jugadores.contains(tripulante) })
    }

    method validarGanador() {
        if(oxigeno <= 0 || (self.tripulantesVivos() == 0)){ //:)
            throw new Exception(message = "Ganaron los impostores !!!")
        } else if (self.impostoresVivos() == 0){
            throw new Exception(message = "Ganaron los tripulantes !!!")
        }
    }
    

    method alguienTieneItem(item) = tripulantes.any({ tripulante => tripulante.tieneItem(item) })
    
    method personaMasSospechosa(){
        return jugadores.max({ jugador => jugador.nivelDeSospecha()} ) 
    } //captado
    //mati es reboludoma

    method personaPobre(){
        return jugadores.findOrDefault({ jugador => jugador.tieneMochilaVacia()})
    }

    method personaNoSospechosa(){
        return jugadores.findOrDefault({ jugador => jugador.esSospechoso().negate()})
    }

    method alguienRandom(){
        return jugadores.findOrDefault()
    }

    method personaConMasVotos() {
        return votos.max({voto => votos.occurrencesOf(voto)})
    }
    
    method cantBlancos() = votosEnblanco.size()
    
    method expulsar() {
        var persona = self.personaConMasVotos()
        var cantVotos = votos.occurrencesOf(persona)

        if(cantVotos > self.cantBlancos()){
        jugadores.remove(persona)
        self.validarGanador()
        }
    }

    method reunionEmergencia() {
        jugadores.forEach({jugador => jugador.votar()})
        self.expulsar()
        votos.clear()
    }

    method agregarVotoBlanco() {
        votosEnblanco =+ 1
    }

    method agregarVoto(persona) {
        votos.add(persona)
    }
}
