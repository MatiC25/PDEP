object nave {

  	const jugadores = #{}
    var nivelDeOxigeno = 100

    method aumentarNivelOxigeno(cantOxigeno) {
        nivelDeOxigeno += cantOxigeno
    }

	
	method tareaHecha() {
		if (self.completaronTodasLasTareas()) {
			throw new Exception(message = "Tripulantes ganan")
		}
	}
		
	method completaronTodasLasTareas() {
		return jugadores.all { jugador => jugador.todasLasTareasCompleatadas() }
	}


}