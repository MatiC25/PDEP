import medico.*

class JefeDeDepartamento inherits Medico {

    const subordinados = #{}

    method darOrdenA(subordinado, unaPersona) {
        subordinados.anyOne().atender(unaPersona)
    }
}