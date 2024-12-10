-------------------
-- DECLARACIONES --
-------------------

data Auto = Auto {
    color :: Color,
    velocidad :: Int,
    distancia :: Int
} deriving (Show)

type Color = String

data Carrera = Carrera {
    autos :: [Auto]
} deriving (Show)

----------------------------
-- Punto 1.a -- estaCerca --
----------------------------

tieneDistancia :: Auto -> Int
tieneDistancia auto = distancia auto 

type Criterio = (Auto -> Int)

autoGana :: Criterio -> Auto -> Auto -> Bool
autoGana criterio auto1 auto2 = criterio auto1 > criterio auto2 

-- estadoAuto :: Carrera -> (Auto -> Bool) -> Auto -> [Bool]
-- estadoAuto carrera estadoComparador auto = map (estadoComparador auto) (autos carrera)

estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = color auto1 /= color auto2 && ((>10) . abs . subtract (distancia auto1)) (distancia auto2)

------------------------------
-- Punto 1.b -- vaTranquilo --
------------------------------

vaTranquilo :: Carrera -> Auto -> Bool
vaTranquilo carrera auto = not (algunoEstaCerca carrera auto) && vaGanando carrera auto

vaGanando :: Carrera -> Auto -> Bool
vaGanando carrera auto = all (autoGana distancia auto) (autos carrera)

algunoEstaCerca :: Carrera -> Auto -> Bool
algunoEstaCerca carrera auto = any (estaCerca auto) (autos carrera)

------------------------------
-- Punto 1.c -- puestoAuto ---
------------------------------

cantidadAutosGana :: Carrera -> (Auto -> Bool) -> Auto -> Int
cantidadAutosGana carrera estadoComparador auto = (length . filter (estadoComparador)) (autos carrera)

puestoAuto :: Carrera -> Auto -> Int
puestoAuto carrera auto = 1 + cantidadAutosGana carrera (autoGana distancia auto) auto

-----------------------------------------
-- Punto 2 -- autoCorrePorTiempo --
-----------------------------------------

autoCorrePorTiempo :: Int -> Auto -> Auto 
autoCorrePorTiempo tiempo auto = auto { distancia = distancia auto + (tiempo * (velocidad auto)) }

---------------------------------------
-- Punto 2.i -- modificadorVelocidad --
---------------------------------------

modificadorVelocidad :: (Int -> Int) -> Auto -> Auto
modificadorVelocidad modificador auto = auto {velocidad = modificador (velocidad auto)}

---------------------------------------
-- Punto 2.ii -- bajarVelocidad --
---------------------------------------
bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad velocidad = modificadorVelocidad (max 0 . (subtract velocidad))

-------------------------
-- Punto 3 -- powerUps --
-------------------------

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista


type PowerUp = Auto -> Carrera -> Carrera 

terremoto :: PowerUp
terremoto auto carrera = carrera { autos = afectarALosQueCumplen (estaCerca auto) (modificadorVelocidad (subtract 50)) (autos carrera) }

miguelitos :: Int -> PowerUp 
miguelitos velocidad auto carrera = carrera { autos = afectarALosQueCumplen (not . vaGanando carrera) (modificadorVelocidad (subtract velocidad)) (autos carrera) }

jetPack :: Int -> PowerUp
jetPack tiempo auto carrera = carrera { autos = afectarALosQueCumplen (sonDelMismoColor auto) (modificadorVelocidad (div 2) . autoCorrePorTiempo tiempo . modificadorVelocidad (*2)) (autos carrera) }

sonDelMismoColor :: Auto -> Auto -> Bool
sonDelMismoColor auto1 auto2 = color auto1 == color auto2

----------------------------------
-- Punto 4 -- tablaDePosiciones --
----------------------------------

-- simularCarrera :: Carrera -> [Carrera -> Carrera] -> [(Int, Color)]
-- simularCarrera carrera eventos = map (posicionEnQueQuedo carrera) (autos (foldl (aplicarEventoCarrera) carrera eventos))

simularCarrera :: Carrera -> [Carrera -> Carrera] -> [(Int , Color)]
simularCarrera carrera = (map (posicionEnQueQuedo carrera) . (autos . (foldl (aplicarEventoCarrera) carrera)))

aplicarEventoCarrera :: Carrera -> (Carrera -> Carrera) -> Carrera
aplicarEventoCarrera carrera evento = evento carrera 

posicionEnQueQuedo :: Carrera -> Auto -> (Int, Color)
posicionEnQueQuedo carrera auto = (puestoAuto carrera auto, color auto)

--------------------------------------------------------------
-- Punto 4 -- ni idea Funciones que se usan para la carrera --
--------------------------------------------------------------

correnTodos :: Int -> Carrera -> Carrera
correnTodos tiempo carrera = carrera {autos = map (autoCorrePorTiempo tiempo) (autos carrera) }


--------------------------------------------------------------
-- Punto 4 -- ni idea Funciones que se usan para la carrera --
--------------------------------------------------------------
type Evento estructura = estructura -> estructura


usaPowerUp :: Color -> Carrera -> PowerUp -> Carrera
usaPowerUp color carrera powerUp = powerUp (buscarAutoSegunColor color carrera) carrera

buscarAutoSegunColor :: Color -> Carrera -> Auto
buscarAutoSegunColor color carrera = (head . filter (coincideColor color)) (autos carrera)

coincideColor :: Color -> Auto -> Bool
coincideColor colorAuto = (== colorAuto) . color


