import Text.Show.Functions
import Data.List(genericLength)

-- Estructura Ciudad
data Ciudad = Ciudad {
    nombre :: String,
    anio :: Integer,
    atracciones :: [String],
    costoDeVida :: Float
}deriving (Show)

-- Estructura Anio
data Año = Año {
     numAnio :: Integer,
     eventos :: [Evento]
}deriving (Show)

type Evento = Ciudad -> Ciudad
type Criterio a = Ciudad -> a

-- cantidadDeLetrasPorAtraccion :: Ciudad -> Int 
-- cantidadDeLetrasPorAtraccion = length atraccion 

--Ciudades ejemplo
barcelona = Ciudad "Barcelona" 1700 ["Sagrada Familia", "Parc Guell"] 1000
buenosAires = Ciudad "Buenos Aires" 1536 ["Obelisco", "Casa Rosada"] 800
paris = Ciudad "Paris" 300 ["Torre Eiffel", "Louvre"] 1500
tokio = Ciudad "Tokio" 1603 [] 2000

------------------------------------
-- Punto 1 -- Valor de una ciudad --
------------------------------------ 

valorDeUnaCiudad :: Ciudad -> Float
valorDeUnaCiudad (Ciudad nombre anio atracciones costoDeVida)
    | anio < 1800 = fromIntegral (5 * (1800 - anio))
    | null atracciones = 2 * costoDeVida
    | otherwise =  3 * costoDeVida
    
------------------------------------    
-- Punto 2 -- Atracciones Copadas --
------------------------------------

esVocal :: Char -> Bool
esVocal letra =  letra `elem` "aeiouAEIOU"
 
algunaAtraccionCopada :: Ciudad -> Bool
algunaAtraccionCopada ciudad = any atraccionCopada (atracciones ciudad)

atraccionCopada :: String -> Bool
atraccionCopada (x:_) = esVocal x
atraccionCopada _ = False

-------------------------------
-- Punto 2.1 --Ciudad Sobria --
-------------------------------

ciudadSobria :: Int -> Ciudad -> Bool
ciudadSobria cantidadDeLetras ciudad = all (mayorACantidadDeLetras cantidadDeLetras) (atracciones ciudad)

mayorACantidadDeLetras :: Int -> String -> Bool
mayorACantidadDeLetras cantidadDeLetras atraccion = length atraccion > cantidadDeLetras

-----------------------------------------
-- Punto 2.2 -- Ciudad con nombre raro --
-----------------------------------------

ciudadNombreRaro :: Ciudad -> Bool
ciudadNombreRaro ciudad = ((<5) . length) (nombre ciudad)

------------------------
-- Punto 3 -- Eventos --
------------------------

sumarUnaNuevaAtraccion ::  String -> Ciudad -> Ciudad
sumarUnaNuevaAtraccion nuevaAtraccion (Ciudad nombre anio atracciones costoDeVida) = Ciudad nombre anio (nuevaAtraccion : atracciones) (costoDeVida * 1.20)

-------------------------
-- Punto 3.1 -- Crisis --
-------------------------

atravesarCrisis :: Ciudad -> Ciudad
atravesarCrisis (Ciudad nombre anio atracciones costoDeVida) = Ciudad nombre anio (init atracciones) (costoDeVida * 0.9)

------------------------------
-- Punto 3.2 --Remodelación --
------------------------------

remodelacion :: Float -> Ciudad -> Ciudad
remodelacion porcetanje (Ciudad nombre anio atracciones costoDeVida) = Ciudad ("New" ++ nombre) anio atracciones (costoDeVida * (1 + porcetanje/100))

-------------------------------
-- Punto 3.3 -- Reevaluación --
-------------------------------

reevaluacion :: Int -> Ciudad -> Ciudad
reevaluacion cantidadLetras (Ciudad nombre anio atracciones costoDeVida) 
    | ciudadSobria cantidadLetras (Ciudad nombre anio atracciones costoDeVida) = Ciudad nombre anio atracciones (costoDeVida * 1.10)
    | otherwise = Ciudad nombre anio atracciones (costoDeVida - 3)

-------------
-- Punto 4 --
-------------

detonarCiudad :: Ciudad -> Ciudad
detonarCiudad = reevaluacion 5 . remodelacion 10 . atravesarCrisis . sumarUnaNuevaAtraccion "Atraccionnro1" 

----------------------------
-- Punto 5 -- Año Ejemplo --
----------------------------

año2022 :: Año
año2022 = Año 2022 [remodelacion 5, atravesarCrisis, reevaluacion 7]
año2015 :: Año
año2015 = Año 2015 []


--Funciones
pasarPorAnio :: Año -> Ciudad -> Ciudad
pasarPorAnio año = pasarPorListaDeEventos (eventos año)

pasarPorListaDeEventos :: [Evento] -> Ciudad -> Ciudad
pasarPorListaDeEventos = flip $ foldr aplicarEvento 

aplicarEvento :: Evento -> Ciudad -> Ciudad
aplicarEvento evento ciudad = evento ciudad

---------------------------
-- Punto 5.2  Algo mejor --
---------------------------

type Criterio a = Ciudad -> a

terminaMejorSegun :: (Num a, Ord a) => (Criterio a) -> Ciudad -> Evento -> Bool
terminaMejorSegun criterio ciudad evento = criterio ciudad < (criterio . evento) ciudad


cantidadDeAtracciones :: Ciudad -> Int
cantidadDeAtracciones ciudad = length (atracciones ciudad)

---------------
-- Punto 5.3 --
---------------

costoDeVidaQueSuba :: Año -> Ciudad -> Ciudad
costoDeVidaQueSuba = pasarPorListaDeEventosPorCriterio (terminaMejorAun costoDeVida ciudad)

---------------
-- Punto 5.4 --
---------------

costoDeVidaQueBaje :: Año -> Ciudad -> Ciudad
costoDeVidaQueBaje = pasarPorListaDeEventosPorCriterio (not . terminaMejorAun costoDeVida ciudad) 

---------------
-- Punto 5.5 --
---------------

valorDeUnaCiudadQueSuba :: Año -> Ciudad -> Ciudad
valorDeUnaCiudadQueSuba = pasarPorListaDeEventosPorCriterio (terminaMejorAun valorDeUnaCiudad ciudad) 

pasarPorListaDeEventosPorCriterio :: (Evento -> Bool) -> Año -> Ciudad -> Ciudad
pasarPorListaDeEventosPorCriterio criterio unAño = (pasarPorListaDeEventos $ filter criterio (eventos unAño)) ciudad

costoDeVida :: Ciudad -> Float
costoDeVida ciudad = costoDeVida ciudad

-------------
-- Punto 6 --
-------------

esCreciente :: (Num a, Ord a) => [a] -> Bool
esCreciente [] = False
esCreciente [x1] = True
esCreciente (x1:x2:xs) = x1 < x2 && esCreciente (x2:xs)

-- eventosEstanOrdenados :: Año -> Ciudad -> Bool
-- eventosEstanOrdenados unAño unaCiudad = esCreciente (map (costoDeVida . (flip $ aplicarEvento unaCiudad)) (eventos unAño))

-- ciudadesEstanOrdenadas :: Evento -> [Ciudad] -> Bool
-- ciudadesEstanOrdenadas unEvento ciudades = esCreciente (map (costoDeVida . (aplicarEvento unEvento) ciudades))

-- añosEstanOrdenados :: [Año] -> Ciudad -> Bool
-- añosEstanOrdenados años unaCiudad = esCreciente (map (costoDeVida . (flip $ pasarPorAnio unaCiudad) años))

algoEstaOrdenado :: (a -> b) -> [a] -> Bool 
algoEstaOrdenado laTransformacion elTransformado = esCreciente (map (costoDeVida . laTransformacion) elTransformado)

eventosEstanOrdenados :: Año -> Ciudad -> Bool  
eventosEstanOrdenados unAño unaCiudad = algoEstaOrdenado (flip $ aplicarEvento unaCiudad) (eventos años)

ciudadesEstanOrdenadas :: Evento -> [Ciudad] -> Bool
ciudadesEstanOrdenadas unEvento ciudades = algoEstaOrdenado (aplicarEvento unEvento) ciudades

añosEstanOrdenados :: [Años] -> Ciudad -> Bool
añosEstanOrdenados años unaCiudad = algoEstaOrdenado (flip $ pasarPorAnio unaCiudad) años


