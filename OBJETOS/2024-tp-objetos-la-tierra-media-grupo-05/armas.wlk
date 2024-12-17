class Espada {

    const origen
    const multiplicadorDePoder
    method origen() = origen 
    // method multiplicadorDePoder() = multiplicadorDePoder

    method poderio() = multiplicadorDePoder * origen.valorExtra()
}

class Origen {
    const valorExtra
    method valorExtra() = valorExtra
}
class Elfica inherits Origen(valorExtra = 30){ }

class Enana inherits Origen(valorExtra = 20){}

class Humana inherits Origen(valorExtra = 15){}

class Baculo {
    const poder
    method poderio() = poder 
}

class Daga inherits Espada {
    override method poderio() = super() / 2
}

class Arco {
    var property tension = 40
    const largo

    method poderio() = 0.1 * tension * largo
}

class Hacha {
    const mango
    const hojaMetalica

    method largo() = mango
    method peso() = hojaMetalica 

    method poderio() = mango * hojaMetalica
}

