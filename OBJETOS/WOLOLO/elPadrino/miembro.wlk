// EL PADRINO 

class Miembro {
    var rango
    var estaHerida = false
    var property estaMuerto = false 
    const armas = []
    
    method mata(persona){
    }

    method durmiendoConLosPeces(){
        return estaMuerto       
    }

    method atacar(personaQueAtaca, personaAtacada){
        rango.atacar(personaQueAtaca, personaAtacada)
    }

    method cambiarHerida(){
        estaHerida = true 
    }

    method armaMasAMano() = armas.first()
    
    method cantArmas() = armas.size() // >:)
    
    // Restaron puntos 
    // mati.hoyleCaeUnPocoPeor(juli) //????????????
    // mati.hoyleCaeUnPocoPeor(mili) //A 
    // juli,confundida()
    // arce.a()
    
    method agregarArma(arma) = armas.add(arma)
    
    method tieneElegancia(persona){
    }
}   

class Familia {

    const miembros = #{}

    method miembrosVivos(){
        miembros.filter({miembro => miembro.esta})
    }
    
    method peligroso(){
        miembros.miembrosVivos().max({miembro => miembro.cantArmas()}) //miembro con mayor cantidad
    }

    method brindarArmas(arma){
        miembros.forEach({miembro => miembro.agregarArma(arma)})
    }
}

//------------------------------ARMAS----------------------------------------------//
class Revolver {

    var property contBalas = 0

    method disparo(persona){
        if(contBalas > 0){
            persona.muere()
            contBalas -= 1
        }
    }
        
}

class Escopeta {

    var property contBalas = 0

    method disparo(persona){
        if (persona.estaHerida()){
            persona.muere()
        } else persona.cambiarHerida()
    }
}

class CuerdaDePiano {

    const esDeCalidad = true

    method disparo(persona){
        if(esDeCalidad){
            persona.muere()
        }
    }
}

//----------------------------RANGOS----------------------------------//

class Don {

    var subordinados = #{}
    
    method atacar(subordinado, aQuien){    
        subordinado.atacar(aQuien)
    }
}

object donVito inherits Don {

    override method atacar(subordinado, aQuien){
        subordinado.atacar(aQuien)
        subordinado.atacar(aQuien)
    }
}
    

class Subjefe{

    var subordinados = #{}
    // var subordinado = new Set() //colecciones 
    
    method atacar(subordinado, aQuien){
        subordinado.armaRandom().disparo(aQuien)               
    }

}

class Soldados {

    method atacar(personaQueAtaca, aQuien){
        personaQueAtaca.armaMasAMano().disparo(aQuien)
    }        
                        
}

//------------------------------ACCIONES----------------------------------//