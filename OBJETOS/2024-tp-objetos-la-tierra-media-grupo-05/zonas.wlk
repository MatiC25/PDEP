import gandalf.*
// class Zona {
//     method dificultad()

//     method consecuencias()
// }

object lebennin {
    method esDificil(persona) = persona.tienePoder(1500)
    method consecuencia(persona) {}
}

object minasTirith {

    method esDificil(persona) = persona.tieneArma()
    
    method consecuencia(persona) {
        if(persona.puedeAtravesar(self)) {
            persona.disminuirVida(10) 
        }
    }
}

object lossarnach {
    method esDificil() = true 

    method consecuencia(persona) {
        persona.aumentarVida(1)
    }
}

class CaminoGondor {
    const zonas = #{}

    method esDificil(persona) {
        return zonas.all({zona => persona.puedeAtravesar(zona)})
    }

    method consecuencia(persona) {
        zonas.forEach({zona => persona.atravesar(zona)})
        }

}
