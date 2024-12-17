class CaminoGondor {
    const zonas = []

    method requerimiento(grupo) {
        return zonas.all({zona => grupo.puedeAtravesar(zona)})
    }

    method atravesar(grupo) {
        zonas.forEach({zona => grupo.atravesar(zona)})
        }

    method esValido() = self.caminoIndividual() || self.validacion()
    

    method validacion() {
        return zonas.all({zona => zona.esLimitrofeCon(zonas.zonaSiguiente(zona))}) 
    }

    // method zonaSiguiente(zona) {
    //     return zonas.get(zonas.indexOf(zona) + 1)
    // }

    method zonaSiguiente(zona) {
        if (zonas.indexOf(zona) == -1 || zonas.indexOf(zona) == (zonas.size() - 1)) {
            return null
        }else{
        return zonas.get(zonas.indexOf(zona) + 1)
        }
    }

    method caminoIndividual() = zonas.size() == 1
}