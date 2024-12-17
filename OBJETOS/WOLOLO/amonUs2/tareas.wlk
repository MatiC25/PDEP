import jugador.*
import nave.*

class Item{}
const llaveInglesa = new Item()
object arreglarElTableroElectrico {

    method requisito(jugador) = jugador.tiene(llaveInglesa)

    method efectoPorRealizar(jugador) { 
        jugador.aumentarSospecha(10)
    }

}

const escoba = new Item()
const bolsaDeConsorcio = new Item()
object sacarBasura {
    
    method requisito(jugador) = jugador.tiene(escoba) && jugador.tiene(bolsaDeConsorcio)

    
    method efectoPorRealizar(jugador) { 
        jugador.disminuirSospecha(4) //:D
    }
    
}

object ventilarLaNave {

    method requisito(jugador) = true

    method efectoPorRealizar(){
        nave.aumentarOxigeno(5)
    } // Nave is a well known object

}


// Sabotajes
const tuboOxigeno = new Item()
object reducirOxigeno {
    
    method efectoPorRealizar(){
        if(nave.alguienTieneItem(tuboOxigeno).negate()){
        nave.disminuirOxigeno(10)}
    }
    
} 