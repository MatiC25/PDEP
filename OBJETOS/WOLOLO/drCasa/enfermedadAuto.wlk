import enfermedad.*
import persona.*


class EnfermedadAutoInmune inherits Enfermedad{
    // var celulasAmenzadas
    var diasConEnfermedad
    
    override method afectarA(persona){
        0.max(persona.destruirCelulas(celulasAmenzadas))
        self.aumentarDiasAfecto()
    }

    method esAgresivaPara(persona) = diasConEnfermedad > 30

    method aumentarDiasAfecto() {
        diasConEnfermedad += 1    
    }
    // method recibirDosis(cantDeMedicamento, persona) {
    //     if(celulasAmenzadas <= cantDeMedicamento * 15){
    //         persona.enfermedades().remove(self)
    //     }
    // }       
}