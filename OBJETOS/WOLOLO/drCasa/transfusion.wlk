
// class GrupoSanguineo {
//     const compatibles = #{}
//     method puedeDonarle(grupoSanguineo){
//         compatibles.contains(grupoSanguineo)
//     }
// }

// class GrupoO inherits GrupoSanguineo(compatibles = #{self, grupoA, grupoB, grupoAB}){} 

// class GrupoA inherits GrupoSanguineo(compatibles = #{}) {}

// class GrupoB inherits GrupoSanguineo(compatibles = #{}) {}

// class GrupoAB inherits GrupoSanguineo(compatibles = #{}) {}

// const grupoO = new GrupoO()
// //     const compatibles = #{self, grupoA, grupoB, grupoAB} 
// // }
// const grupoA = new GrupoA()
// const grupoB = new GrupoB()
// const grupoAB = new GrupoAB()

object o {
    method puedeDonarle(otroTipo) = true
}

object a {
    method puedeDonarle(otroTipo) = [self, ab].contains(otroTipo)
}

object ab {
    method puedeDonarle(otroTipo) = [self].contains(otroTipo)
}

class FactorSanguineo {
    method coincideCon(unFactorSanguineo)
}

class Negativo inherits FactorSanguineo {
    override method coincideCon(unFactorSanguineo) = true
}

class Positivo inherits FactorSanguineo {
    override method coincideCon(unFactorSanguineo) = unFactorSanguineo == self 
}