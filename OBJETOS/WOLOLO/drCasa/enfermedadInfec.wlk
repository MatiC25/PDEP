import enfermedad.*
import persona.*


class EnfermedadInfecciosa inherits Enfermedad {

    override method afectarA(persona){
        persona.aumentarTemperatura(self.celulasAmenzadas() / 1000)// hasta 45
    }

    method reproducirse(){
        celulasAmenzadas = celulasAmenzadas * 2
    }

    method esAgresivaPara(persona) = celulasAmenzadas > persona.celulasTotales() * 0.1
  
}