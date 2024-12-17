
class Persona {
    var carrerasDeseadas = #{}
    var suenosPendientes = []
    var suenoCumplidos = #{}
    var quiereGanar = 100
    var hijos = []  

    method suenioCumplido(suenio){
        suenosPendientes.remove(suenio)
        suenoCumplidos.add(suenio)
    }

    method estaCumplido(suenio) {
        return suenoCumplidos.contains(suenio)
    }

    method cumplir(suenio) {
        if(suenio.puedeRealizarSuenio(self)){
        self.suenioCumplido(suenio)
        }else{
            throw new Exception(message = "El sueño " + suenio + " no está pendiente")
        }
    }

    // method puedeRealizar() = suenosPendientes.find({suenio => suenio.puedeRealizarSuenio(self)})

    method quiereEstudiar(carrera) = carrerasDeseadas.contains(carrera)
   
    method estaConforme(sueldo)  = sueldo >= quiereGanar

    method tieneHijos() = !hijos.isEmpty()

}

//suenios
class Recibirse {
    var carrera

    method puedeRealizarSuenio(persona) {
        return persona.quiereEstudiar(carrera)
    }

}

class Trabajo {
    var sueldo
    
    method puedeRealizarSuenio(persona){
        return persona.estaConforme(sueldo)
    }
}

class Adoptar {

    method puedeRealizarSuenio(persona) {
        return !persona.tieneHijos()
    }
}