// import efectos.*
// class Zona {

//     const efecto
//     var region
//     method requerimiento(grupo)
//     method efecto()

// }
// class Region {

// }



// class Belfalas inherits Zona {


//     override method requerimiento(grupo) = true

// }

// class Lebennin inherits Zona {

//     var property poderNecesario = 10000000 

//     override method requerimiento(grupo){
//         return grupo.algunoTienePoder(poderNecesario)
//     }
// }

// class MinasTirith inherits Zona {

//     const itemNecesario = lemba
//     const cantItem = 10

//     override method requerimiento(grupo) {
//         return grupo.elGrupoTiene(cantItem, itemNecesario)
//     }
// }

// class BosqueDeFangorn inherits Zona {

//     override method requerimiento(grupo){
//         return grupo.algunoTieneArma()
//     }
// }

// class Edoras inherits Zona {
//     override method requerimiento(grupo) = true
// }



// class Estremnet inherits Zona {
    
//     const itemNecesario = lemba
//     const cantItem = 30

//     override method requerimiento(grupo) {
//         return grupo.elGrupoTiene(cantItem, itemNecesario)
//     }
// }
// class Item {

// }

// const lemba = new Item()

// class CaminoGondor {
//     const zonas = []

//     method requerimiento(grupo) {
//         return zonas.all({zona => grupo.puedeAtravesar(zona)})
//     }

//     // method consecuencia(persona) {
//     //     zonas.forEach({zona => persona.atravesar(zona)})
//     //     }

// }

// // const bosqueF = new BosqueDeFangorn()
// // const edoras = new Edoras()
// // const estemnet = new Estremnet()
// // const belfalas = new Belfalas()