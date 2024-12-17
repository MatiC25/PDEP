import enfermedadAuto.*
import enfermedadInfec.*



class Enfermedad { // SuperClase 

    var celulasAmenzadas 

    method celulasAmenzadas() = celulasAmenzadas

    method atenuarse(cantDeMedicamento, persona) {
        self.disminuirCelulas(cantDeMedicamento * 15)
    }   

    method disminuirCelulas(cantDeCelulas) {
        celulasAmenzadas -= cantDeCelulas
    }

    method estaCurada() = celulasAmenzadas <= 0

    method afectarA(persona) // Clase abstracta, que no se puede instanciar
                            // Clase abstracta -> enfermedadInfec y enfermedadAuto lo tienen 
                            // al tener este metodo abstracto, no podes crear una enfermedad ya que es abstracta
}
