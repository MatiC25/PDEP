import persona.*
class Medico inherits Persona {

    const dosis

override method contrae(unaEnfermedad) {
        super(unaEnfermedad)
        self.atender(self)
    }

    method atender(persona) {
        persona.aplicarDosis(dosis)
    }
}

