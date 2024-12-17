import enfermedad.*
import enfermedadAuto.*
import enfermedadInfec.*

class EnfermedadAutoEinfec {
    const autoinmune
    const infecciosa

    method afectarA(persona) {
        autoinmune.afectarA(persona)
        infecciosa.afectarA(persona)
    }

    method esAgresivaPara(unaPersona) {
        return autoinmune.esAgresivaPara(unaPersona) && infecciosa.esAgresivaPara(unaPersona)
    }

    method reproducirse() {
        infecciosa.reproducirse()
    }
     
}





