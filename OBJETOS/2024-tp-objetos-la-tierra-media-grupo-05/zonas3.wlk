import requerimientos.*
import efectos.*
    class Zona {

        const zonasLimitrofes = []
        const tipoDeRequerimiento
        const tipoDeEfecto

        method tipoDeRequerimiento(nuevoTipo) = nuevoTipo

        method requerimiento(grupo){
            return tipoDeRequerimiento.requerimiento(grupo)
        } 

        method hacerEfecto(grupo){
            tipoDeEfecto.aplicar(grupo)
        }

        method esLimitrofeCon(zona) {
            if(zona == null){
                return true
            }else{
            zonasLimitrofes.contains(zona)
            }
        }
    }


// REGION GONDOR
const incrementarVida30 = new EfectoVidaPorcetaje(porcentaje = 30)
class Lamedon inherits Zona(tipoDeRequerimiento = sinRequerimiento, tipoDeEfecto = incrementarVida30){

    override method hacerEfecto(persona){
        tipoDeEfecto.aumentarVida(persona)
    }
}
const masPan = new EfectoItem(item = "pan", cantidad = 1)
class Belfalas inherits Zona(tipoDeRequerimiento = sinRequerimiento, tipoDeEfecto = masPan){

    override method hacerEfecto(persona){
        tipoDeEfecto.ganarItem(persona)
    }   
}


const requerimientoLebennin = new RequerimientoPoder (poderNecesario = 1500)
class Lebennin inherits Zona(tipoDeRequerimiento = requerimientoLebennin, tipoDeEfecto = sinEfecto) {}


const requerimientoMinas = new RequerimientoItem(item = "Lembas", cantItem = 10)
const pierdeVida15 = new EfectoVidaPorValor(cantidad = 15)
class MinasTirith inherits Zona(tipoDeRequerimiento = requerimientoMinas, tipoDeEfecto = pierdeVida15){

    override method hacerEfecto(persona){
        tipoDeEfecto.disminuirVida(persona)
    }
}


// REGION DE ROHAN

const requerimientoBosque = new RequerimientoArma(cantArmas = 1)
const pierdeCapa = new EfectoItem(item = "Capa Elfica", cantidad = 1)
class BosqueDeFaragon inherits Zona(tipoDeRequerimiento = requerimientoBosque, tipoDeEfecto = pierdeCapa){

    override method hacerEfecto(persona){
        tipoDeEfecto.aumentarVida(tipoDeEfecto.porcentaje())
    }
}

const botellaVino = new EfectoItem(item = "Botella de Vino", cantidad = 1)
class Edoras inherits Zona(tipoDeRequerimiento = sinRequerimiento, tipoDeEfecto = botellaVino){
    override method hacerEfecto(persona){
        tipoDeEfecto.aumentarVida(tipoDeEfecto.porcentaje())
    }
}

const requerimientoCapas = new RequerimientoItem(item = "Capa Elfica", cantItem = 3)
const duplicaVida = new EfectoVidaPorcetaje(porcentaje = 100)
class Estremnet inherits Zona(tipoDeRequerimiento = requerimientoCapas, tipoDeEfecto = requerimientoCapas){

    override method hacerEfecto(persona){
        tipoDeEfecto.aumentarVida(tipoDeEfecto.porcentaje())
    }
}