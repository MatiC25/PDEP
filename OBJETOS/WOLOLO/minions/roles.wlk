class Rol {
    // Clase Abstracta

}

class Arma {
    
    var danioQueCausa

    method danioQueCausa() = danioQueCausa
}
class Soldado inherits Rol {
    var arma = new Arma()
    var practica = 0

    method usarArma() {
        practica += 2
    }

    method danioCausado() = arma.danioCausado() + practica



}

class Obrero inherits Rol {

    var cinturon = #{}

}

class Mucama inherits Rol {

    // method defenderSector(){}
}