import armas.*

class Gandalf {
    // const glamdring = new EspadaElfica() 
    const armas = #{}
    var property vida // Como hacerlo de 0 a 100 ??
    method poder() {
        if(self.vida() < 15){
            return self.vida() * 300 + self.sumatoriaDePoder() * 2 
        }
        else{
            return self.vida() * 15 + self.sumatoriaDePoder() * 2
        }
    }

    method poderArma(arma) {
        arma.poderio()
    }

    method sumatoriaDePoder() {
        return armas.sum({arma => arma.poderio()})
    }

    method tieneArma() = !armas.isEmpty()

    method disminuirVida(unPocoDeVida) {
        vida -= unPocoDeVida
    }

    method aumentarVida(unPocoDeVida) {
        vida += unPocoDeVida
    }

    method tienePoder(valor) = self.poder() > valor
    

    method puedeAtravesar(zona) = zona.esDificil(self)

    method atravesar(zona) {
        zona.consecuencia(self)
    }

}
class TomBardi inherits Gandalf {
    override method puedeAtravesar(zona) = true
    override method atravesar(zona) {}
}
