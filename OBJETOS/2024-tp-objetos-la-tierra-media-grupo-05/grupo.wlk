class Grupo {

    const personas = []

    method personas() = personas 

    method elGrupoTiene(cantItem, item) { 
        return personas.sum({ persona => persona.cuantosTiene(item) }) >= cantItem
    }

    method puedeAtravesar(zona) {
        return zona.requerimiento(self)
    }

    method atravesar(zona) {
        if(self.puedeAtravesar(zona)){
            zona.hacerEfecto(self)
        }else{
            throw new Exception(message = "No puede atravesar la zona")
        }
    }

    method atravesarCamino(camino) {
        camino.forEach({zona => self.atravesar(zona)})
    }

    method estaEnCombate(){
        personas.filter({persona => persona.estaEnCombate()})
    }
    method algunoTienePoder(cantPoder) {
        return personas.estaEnCombate().any({ persona => persona.tienePoder(cantPoder) })
    }
    
    method algunoTieneArma(cantArma) {
        return personas.estaEnCombate().any({ persona => persona.tieneArmas(cantArma) })
    }

    method disminuirVida(cantVida) {
        personas.estaEnCombate().forEach({ persona => persona.disminuirVida(cantVida) })
    }
    
    method aumentarVida(cantVida) {
        personas.estaEnCombate().forEach({ persona => persona.aumentarVida(cantVida) })
    }

    method perderItems(item, cantidad) {
        personas.estaEnCombate().forEach({ persona => persona.perderItems(item, cantidad) })
    }

    method ganarItems(item, cantidad) {
        personas.estaEnCombate().forEach({ persona => persona.ganarItems(item, cantidad) })
    }

}