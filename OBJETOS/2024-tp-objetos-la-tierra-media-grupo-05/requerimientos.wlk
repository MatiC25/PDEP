

// CLASE ABSTRACTA DE REQUERIMIENTO
// class Requerimiento {

//     method requerimiento(grupo)
// }

// CLASE DE REQUERIMIENTO ITEM, TODOS COMPARTE UN ITEM Y UNA CANTIDAD
class RequerimientoItem {

    const item
    const cantItem

    method requerimiento(grupo) {
        return grupo.elGrupoTiene(cantItem, item)
    }

}

// REQUERIMIENTO GUERRERO, "NUNCA SE VIAJA SOLO" -> SE EVALUA SIEMPRE EN GRUPO

class RequerimientoGuerrero {

    method requerimiento(grupo)
}


class RequerimientoPoder inherits RequerimientoGuerrero {

    const poderNecesario

    override method requerimiento(grupo) = grupo.algunoTienePoder(poderNecesario)

}

class RequerimientoVida inherits RequerimientoGuerrero {

    const vidaNecesaria

    override method requerimiento(grupo) = grupo.algunoTieneVida(vidaNecesaria)

}

class RequerimientoArma inherits RequerimientoGuerrero {

    const cantArmas

    override method requerimiento(grupo) = grupo.algunoTieneArma(cantArmas)
}

// Sin requerimiento generalizado
object sinRequerimiento {
    method requerimiento(grupo) = true
}
