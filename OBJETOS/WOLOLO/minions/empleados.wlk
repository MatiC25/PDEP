class Empleado {

    var estamina
    const rol

    method puedeRealizar(tarea) = tarea.puedeRealizar(self)
    
    method tiene() = 
}

class Biclope inherits Empleado {
    // Estamina Limitada a 10

}

class Ciclope inherits Empleado {
    // Estamina sin limite

}