import transfusion.*

class Persona {
    var property temperatura
    var property celulasTotales     // var estaVivo
    var enfermedades = #{}

    const grupoSanguineo = new GrupoO()
    const factorSanguineo = new Positivo() // o negativo 

    method factorSanguineo() = factorSanguineo

    method enComa() = temperatura == 45 || celulasTotales < 1000000

    method contrae(unaEnfermedad){
        enfermedades.add(unaEnfermedad)
    }

    method aumentarTemperatura(unosGrados) {
        temperatura = 45.min(temperatura + unosGrados)
    }

    method destruirCelulas(cantCelulas) {
        celulasTotales -= cantCelulas
    }

    method vivirUnDia(){
        enfermedades.forEach({enfermedad => enfermedad.afectarA(self)})
    }

    method vivirDias(cantDias){
        cantDias.time {self.vivirUnDia()}
    }

    method disminuirCelulas(cantDeCelulas) {
        celulasTotales -= cantDeCelulas
    }

    method aumentarCelulas(cantDeCelulas) {
        celulasTotales = cantDeCelulas        
    }


    method recibirDosis(unaDosis) {
        self.aplicarDosis(unaDosis)
        self.sacarCuradas()
    }

    method muerte() {
        temperatura = 0
    }

    method estaMuerto() = temperatura == 0

    method tieneEnfermedad(enfermedad) {
        enfermedades.contains(enfermedad)
    }

    method curarEnfermedad(enfermedad) {
        enfermedades.remove(enfermedad)
    }

    method aplicarDosis(unaDosis) {
      enfermedades.forEach({enfermedad => enfermedad.atenuarse(unaDosis, self)})
    }

    method sacarCuradas() {
        enfermedades.forEachAllSuchThat({enfermedad => enfermedad.estaCurada()})
    }

    // method esCompatible(persona) {
    //     return self.sonCompatiblesGrupos(persona) && self.coincidenFactores(persona)
    // }
    
    method esCompatible(persona) = grupoSanguineo.puedeDonarle(persona.grupoSanguineo()) && factorSanguineo.coincidenCon(persona.factorSanguineo())


    // method sonCompatiblesGrupos(persona) {
    //     return grupoSanguineo.puedeDonarle(persona.grupoSanguineo())
    // }

    // method coincidenFactores(persona) {
    //     return factorSanguineo.habilitado(persona.factorSanguineo())
    // }

    method tieneCelulas(cantCelulas) {
        // return cantCelulas > 500 and celulasTotales * 0.25 >= cantCelulas
        return cantCelulas.between(500, celulasTotales * 0.25) 
    }

    method puedeDonar(cantCelulas, persona) {
        return self.tieneCelulas(cantCelulas) && self.esCompatible(persona)
    }

    method donarA(cantDeCelulas, persona) {
        self.verificarCantidadDeCelulas(cantDeCelulas)
        self.verificarCompatibilidad(persona)
        self.disminuirCelulas(cantDeCelulas)
        persona.aumentarCelulas(cantDeCelulas)

    }
    method verificarCantidadDeCelulas(cantDeCelulas){
        if(!self.tieneCelulas(cantDeCelulas)){
            throw new Exception(message = "No tenes la celulas necesarias")
        }
    }

    method verificarCompatibilidad(persona) {
        if(!self.esCompatible(persona)){
            throw new Exception(message = "No son compatibles")
        }
    }
}


