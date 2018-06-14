//Practica 09.rkt

//Alumno: Javier Rivilla Arredondo

//Ejercicio 1

//a)

//a.1)
let nums = [1,2,3,4,5,6,7,8,9,10]

print(nums.filter{$0 % 3 == 0}.count)

//a.2)
let nums2 = [1,2,3,4,5,6,7,8,9,10]

print(nums2.map{$0 + 100}.filter{$0 % 5 == 0}.reduce(0, +))

//a.3)

let cadenas = ["En", "un", "lugar", "de", "La", "Mancha"]

print(cadenas.sorted{ $0.characters.count < $1.characters.count}.map{$0.characters.count})

print(cadenas.sorted{$0 < $1})

//a.4)

let cadenas2 = ["En", "un", "lugar", "de", "La", "Mancha"]

print(cadenas2.reduce([]) {(res: [(String, Int)], c: String) -> [(String, Int)] in res + [(c, c.characters.count)]}.sorted {$0.1 > $1.1})

//b Pon un ejemplo de las siguientes funciones

//b.1
let numsb = [100, 200, 300, 400]

func f(nums: [Int], n: Int) -> Int {
    return nums.filter{$0 == n}.count
}

print(f(nums: numsb, n: 100))

//Cuenta los numeros que son iguales al pasado como parametro

//b.2)

func g(nums: [Int]) -> [Int] {
    return nums.reduce([], {(res: [Int], n: Int) -> [Int] in
                        if !res.contains(n) {
                            return res + [n]
                        } else {
                            return res
                        }
                    })
}
let numsb2 = [1,1,2,2,2,2,3,3,3,3,10,10,20]
print(g(nums: numsb2))

//Si el resultado acumulado contiene el numero que vas a almacenar no lo almacena, digamos que es un eliminado de duplicados.

//b.3)

func h(nums: [Int], n: Int) -> ([Int], [Int]) {
   return nums.reduce(([],[]), {(res: ([Int],[Int]), num: Int ) -> ([Int],[Int]) in
                            if (num >= n) {
                                return (res.0, res.1 + [num])
                            } else {
                                return ((res.0 + [num], res.1))
                            }
                        })
}

let numsh = [1,2,3,4,5,6,7,8,9,10]

print(h(nums: numsh, n: 8))

//Lo que hace es esta función es le pasas un array de nums y un numero y si el numero pasado por parametro es menor que el del array se suma a la derecha del array derecho si no izquierdo

//c)

//c.1) suma(palabras)

/*func suma(palabras: [String], contienen: Character) -> Int {
  return palabras.reduce(0) {(res: Int, cadena: String) -> Int in

    if (cadena.contains(contienen)) {
      return res + cadena.characters.count
    }
    else{
      return res
    }
  }
}
*/
let sumaMeMa = [1,2,3,4,5]
func sumaMenoresMayores(nums: [Int], pivote: Int) -> (Int, Int) {
  return nums.reduce((0,0)) {
    (res: (Int, Int), n: Int) -> (Int, Int) in
    if (n < pivote) {
      return (res.0 + n, res.1)
    }
    else{
      return (res.0, res.1 + n)
    }
  }
}

print(sumaMenoresMayores(nums: sumaMeMa, pivote: 3))

//Ejercicio 2

indirect enum ArbolGenerico<T> {
  case nodo(T, [ArbolGenerico])
}

let arbolInt: ArbolGenerico = .nodo(53, [.nodo(13, []), .nodo(32, []), .nodo(41, [.nodo(36, []), .nodo(39, [])])])
let arbolString: ArbolGenerico = .nodo("Zamora", [.nodo("Buendía", [.nodo("Albeza", []), .nodo("Berenguer", []), .nodo("Bolardo", [])]), 
                                          .nodo("Galván", [])])


func toArray<T>(arbol: ArbolGenerico<T>) -> [T] {
  switch arbol {
    case let .nodo(dato, hijos):
      return [dato] + toArray(bosque: hijos)
  }
}

func toArray<T>(bosque: [ArbolGenerico<T>]) -> [T] {
  if let primero = bosque.first {
    let resto = Array(bosque.dropFirst())
    return toArray(arbol: primero) + toArray(bosque: resto)
  }
  else{
    return []
  }
}

print(toArray(arbol: arbolInt))
// Imprime: [53, 13, 32, 41, 36, 39]

func toArrayFOS<T>(arbol: ArbolGenerico<T>) -> [T] {
  switch arbol {
    case let .nodo(dato, hijos):
      return hijos.map(toArrayFOS).reduce([dato], +)
  }
}

import Foundation

func imprimirListadoAlumnos(_ alumnos: [(String, Double, Double, Double, Int)]) {
    print("Alumno   Parcial1   Parcial2   Cuest  Años")
    for alu in alumnos {
        alu.0.withCString {
            print(String(format:"%-10s %5.2f      %5.2f    %5.2f  %3d", $0, alu.1,alu.2,alu.3,alu.4))
        }
    }
}

func imprimirListadosNotas(_ alumnos: [(String, Double, Double, Double, Int)]) {
    var alumnosOrdenados: [(String, Double, Double, Double, Int)]

    print("LISTADO ORIGINAL")
    imprimirListadoAlumnos(alumnos)

    print("LISTADO ORDENADO por Nombre")
    alumnosOrdenados = alumnos.sorted(by: {a1, a2 in a1.0 < a2.0})
    imprimirListadoAlumnos(alumnosOrdenados)

    print("LISTADO ORDENADO por Parcial1")
    alumnosOrdenados = alumnos.sorted(by: {a1,a2 in a1.1 > a2.1})
    imprimirListadoAlumnos(alumnosOrdenados)

    print("LISTADO ORDENADO por Parcial2")
    alumnosOrdenados = alumnos.sorted(by: {$0.2 < $1.2})
    imprimirListadoAlumnos(alumnosOrdenados)

    print("LISTADO ORDENADO por Parcial 2 y Año de Matriculación")
    alumnosOrdenados = alumnos.sorted(by: {a1, a2 in
                                             if a1.2 > a2.2 {
                                                return true
                                             } else if a1.2 == a2.2 {
                                                return a1.4 > a2.4
                                             } else {
                                                return false
                                             }
                                          }
                                      )
    imprimirListadoAlumnos(alumnosOrdenados)

    print("LISTADO ORDENADO por Nota para aprobar en Junio")
    alumnosOrdenados = alumnos.sorted(by: {a1, a2 in
                                              let notaP3Alumno1 = (5 / 0.3) - a1.3 * (0.1 / 0.3) - a1.1 - a1.2
                                              let notaP3Alumno2 = (5 / 0.3) - a2.3 * (0.1 / 0.3) - a2.1 - a2.2
                                              return notaP3Alumno1 < notaP3Alumno2
                                          }
                                     )
    imprimirListadoAlumnos(alumnosOrdenados)
}

// DEMOSTRACIÓN

print("Ejercicio 3")
print("===========")
let listaAlumnos = [("Pepe", 8.45, 3.75, 6.05, 1), 
                    ("Maria", 9.1, 7.5, 8.18, 1), 
                    ("Jose", 8.0, 6.65, 7.96, 1),
                    ("Carmen", 6.25, 1.2, 5.41, 2), 
                    ("Felipe", 5.65, 0.25, 3.16, 3), 
                    ("Carla", 6.25, 1.25, 4.23, 2), 
                    ("Luis", 6.75, 0.25, 4.63, 2), 
                    ("Loli", 3.0, 1.25, 2.19, 3)]

imprimirListadosNotas(listaAlumnos)

//A) Número de alumnos que han aprobado primer parcial y suspendido el segundo

print(listaAlumnos.filter {$0.1 >= 5}.filter {$0.2 < 5}.count)
// Resultado: 5
//B) Nota que deben tener en el parcial 3 para sacar un 5 en la nota final

print(listaAlumnos.map {(alumno: (String, Double, Double, Double, Int)) -> Double in 
                          let nota = (5 / 0.3) - alumno.3 * (0.1 / 0.3) - alumno.1 - alumno.2
                          return nota})

// Resultado:
// [2.4500000000000011, -2.6599999999999984, -0.63666666666666671, 7.4133333333333331, 9.7133333333333347, 7.7566666666666677, 8.1233333333333348, 11.686666666666667]
//C) Nota media de todos los alumnos en forma de tupla (media_p1, media_p2, media_cuest)


var tupla = listaAlumnos.reduce((0, 0, 0)) {
  (res: (Double, Double, Double), alumno: (String, Double, Double, Double, Int)) -> (Double, Double, Double) in
  return (res.0 + alumno.1, res.1 + alumno.2, res.2 + alumno.3)
}
tupla = (tupla.0 / Double(listaAlumnos.count), tupla.1 / Double(listaAlumnos.count), tupla.2 / Double(listaAlumnos.count))
print(tupla)

// Resultado: (6.6812499999999995, 2.7624999999999997, 5.2262500000000003)

//Ejercicio 5
var exp = "$1 * 2.0"
let arrayPalabras = exp._split(separator: " ").map(String.init)



/*
let tuplas = [(1.0, 2.5), (10.8, 3.3), (-1.0, 12.0), (-3.4, 4.0)]

print(calcular(exp: "$1 * 2.0", sobre: tuplas)!)
// [5.0, 6.5999999999999996, 24.0, 8.0]
print(calcular(exp: "$0 - 5.0", sobre: tuplas)!)
// [-4.0, 5.8000000000000007, -6.0, -8.4000000000000004]
print(calcular(exp: "$0 + $1", sobre: tuplas)!)
// [3.5, 14.100000000000001, 11.0, 0.60000000000000009]

*/