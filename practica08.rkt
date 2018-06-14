// Práctica 08.rkt

// Alumno: Javier Rivilla Arredondo 

//Ejercicio 2 //Modificado a mi manera

func compruebaParejas(_ valores:[Int],funcion f:(Int) -> Int) -> [(Int, Int)] {
    if let primero = valores.first {
      let resto = Array(valores.dropFirst())
      return [(primero, f(primero))] + compruebaParejas(resto, funcion: f)
    } else {
      return []
    }
}



func cuadrado(_ x: Int) -> Int {
   return x * x
}
//print(compruebaParejas([2, 4, 16, 5, 10, 100, 105], funcion: cuadrado))
// Imprime [(2,4), (4,16), (10,100)]

//Ejercicio 3

indirect enum ArbolBinario{
  case nodo(Int, ArbolBinario, ArbolBinario)
  case vacio
}

//print(suma(arbolb: arbol))
let arbolBinario: ArbolBinario = .nodo(8, .vacio, .nodo(12, .vacio, .vacio))

func sumaArbol(arbolb : ArbolBinario) -> Int {
  switch arbolb {
    case let .nodo(dato, hijoDer, hijoIzq):
      return dato + sumaArbol(arbolb : hijoDer) + sumaArbol(arbolb : hijoIzq)
    case .vacio:
      return 0
  }
}

let array = [(2,4), (4,14), (4,16), (5,25), (10,100)]

func coinciden(parejas: [(Int, Int)], funcion f:(Int) -> Int) -> [Bool] {
  if let primero = parejas.first {
    let resto = Array(parejas.dropFirst())
    if (f(primero.0) == primero.1) {
      return [true] + coinciden(parejas:resto, funcion:f)
    }
    else{
      return [false] + coinciden(parejas:resto, funcion:f)
    }
  }
  else{
    return []
  }
}


print("Resultado coinciden:  \(coinciden(parejas: array, funcion: cuadrado))\n")
// Imprime: Resultado coinciden:  [true, false, true, true, true]

indirect enum Movimiento {
  case deposito(Double)
  case cargoRecibo(String, Double)
  case cajero(Double)
}

func aplica(movimientos: [Movimiento]) -> (Double, [String]) {
  var suma = 0.0
  var concepto = [String]()

  for movimiento in movimientos {
    switch movimiento {
      case let .deposito(cantidad):
        suma = suma + cantidad
      case let .cargoRecibo(lugar, cantidad):
        suma = suma - cantidad
        concepto.append(lugar)
      case let .cajero(cantidad):
        suma = suma - cantidad
    }
  }

  return (suma, concepto)
}

let movimientos: [Movimiento] = [.deposito(830.0), .cargoRecibo("Gimnasio", 45.0), .deposito(400.0), .cajero(100.0), .cargoRecibo("Fnac", 38.70)]
print(aplica(movimientos: movimientos))

//Ejercicio 6

indirect enum ArbolGenerico {
  case nodo(Int, [ArbolGenerico])
}

let arbol1 = ArbolGenerico.nodo(10, [])
let arbol3 = ArbolGenerico.nodo(3, [arbol1])
let arbol5 = ArbolGenerico.nodo(5, [])
let arbol8 = ArbolGenerico.nodo(8, [])
let arbol10 = ArbolGenerico.nodo(10, [arbol3, arbol5, arbol8])

func suma(arbol: ArbolGenerico, cumplen f: (Int) -> Bool) -> Int {
  switch arbol {
    case let .nodo(dato, hijos):
      if (f(dato)) {
        return dato + suma(bosque: hijos, cumplen: f)
      }
        return suma(bosque: hijos, cumplen: f)
  }
}

func suma(bosque: [ArbolGenerico], cumplen f: (Int) ->  Bool) -> Int {
  if let primero = bosque.first {
    let resto = Array(bosque.dropFirst())
    return suma(arbol: primero, cumplen: f) + suma(bosque: resto, cumplen: f)
  }
  else{
    return 0
  }
}

func esPar(x: Int) -> Bool {
    return x % 2 == 0
}

print("La suma del árbol genérico es: \(suma(arbol: arbol10, cumplen: esPar))")
// Imprime: La suma del árbol genérico es: 28

