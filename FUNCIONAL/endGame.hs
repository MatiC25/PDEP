
--------------
-- Punto 01 --
--------------

ironMan = SuperHeroe "Tony Stark" 100 "Tierra" traje thanos
thor = SuperHeroe "Thor Odinson" 300 "Asgard" stormBreaker loki

traje = Artefacto "Traje" 12
stormBreaker = Artefacto "StormBreaker" 0

-- b --
thanos = Villano "Thanos" "Titán" guanteleDelInfito
loki = Villano "Loki Laufeyson" "Jotunheim" (centro 20)

data SuperHeroe = SuperHeroe {
    nombre :: String,
    vida :: Float,
    planetaOrigen :: String,
    artefacto :: Artefacto, 
    villanoEnemigo :: Villano
}

data Artefacto = Artefacto {
    nombreArtefacto :: String,
    daño :: Int
} 

data Villano = Villano {
    nombreVillano :: String,
    planetaDeOrigen :: String,
    arma :: Arma
    } 

type Arma = SuperHeroe -> SuperHeroe

instance Eq Villano where
    unVillano == otroVillano = 
        nombreVillano unVillano == nombreVillano otroVillano &&
        planetaDeOrigen unVillano == planetaDeOrigen otroVillano 

--------------
-- Punto 02 --
--------------

guanteleDelInfito :: Arma 
guanteleDelInfito = modificarVida (*0.20)

centro :: Float -> Arma
centro porcentaje superHeroe
    | esTerricola superHeroe = modificarVida (*transformarPorcentaje porcentaje) . modificarArtefacto artefactoSeRompe $ superHeroe
    | otherwise              = modificarVida (*transformarPorcentaje porcentaje) superHeroe

esTerricola :: SuperHeroe -> Bool
esTerricola = (=="Tierra") . nombre

transformarPorcentaje :: Float -> Float
transformarPorcentaje porcentaje = 1 - (porcentaje/100)

type Mapper campo estructura = (campo -> campo) -> estructura -> estructura

modificarVida :: Mapper Float SuperHeroe
modificarVida modificador superHeroe = superHeroe {vida = modificador . vida $ superHeroe}

modificarArtefacto :: Mapper Artefacto SuperHeroe
modificarArtefacto modificador superHeroe = superHeroe {artefacto = modificador . artefacto $ superHeroe}

artefactoSeRompe :: Artefacto -> Artefacto
artefactoSeRompe artefacto = artefacto {nombreArtefacto = "machacado" ++ nombreArtefacto artefacto, daño =  (+30) . daño $ artefacto } 

--------------
-- Punto 03 --
--------------

sonAtagonistas :: Villano -> SuperHeroe -> Bool
sonAtagonistas villano superHeroe = esEnemigo superHeroe villano || sonOriundos villano superHeroe

esEnemigo :: SuperHeroe -> Villano -> Bool
esEnemigo superHeroe villano = villano == villanoEnemigo superHeroe

sonOriundos :: Villano -> SuperHeroe -> Bool
sonOriundos villano superHeroe = planetaDeOrigen villano == planetaOrigen superHeroe

--------------
-- Punto 04 --
--------------

superHeroeAtacado :: [Villano] -> SuperHeroe -> SuperHeroe
superHeroeAtacado villanos superHeroeAtacado = foldl villanoAtaca superHeroeAtacado villanos

villanoAtaca :: SuperHeroe -> Villano  -> SuperHeroe
villanoAtaca superHeroeAtacado villano
    | esEnemigo superHeroeAtacado villano = superHeroeAtacado
    | otherwise                           = arma villano superHeroeAtacado

--------------
-- Punto 05 --
--------------

quienesSobreviven :: Villano -> [SuperHeroe] -> [SuperHeroe] 
quienesSobreviven villano = map (modificarNombre (++"Super")) . filter ((<50) . vida) . map (flip villanoAtaca villano)

modificarNombre :: Mapper String SuperHeroe
modificarNombre modificador superHeroe = superHeroe {nombre = modificador . nombre $ superHeroe} 


--------------
-- Punto 06 --
--------------

vuelvenACasa :: [SuperHeroe] -> [SuperHeroe]
vuelvenACasa = map descansa . quienesSobreviven thanos

descansa :: SuperHeroe -> SuperHeroe
descansa = modificarVida (+30) . modificarArtefacto artefactoSeArregla

--------------
-- Punto 07 --
--------------

esDebil :: Villano -> [SuperHeroe]-> Bool
esDebil villano superHeroes = all (sonAtagonistas villano) superHeroes && all (estaArtefactoMachacado . artefacto) superHeroes

artefactoSeArregla :: Artefacto -> Artefacto
artefactoSeArregla artefacto = artefacto {daño = const 0 . daño $ artefacto, 
                                          nombreArtefacto = filter (`elem` "machacado") . nombreArtefacto $ artefacto}

estaArtefactoMachacado :: Artefacto -> Bool
estaArtefactoMachacado artefacto = "manchado" `elem` words (nombreArtefacto artefacto)

--------------
-- Punto 08 --
--------------

drStrange = SuperHeroe "Sthepehen Strange" 60 "Tierra" capaDeLevitacion thanos

capaDeLevitacion = Artefacto "capa de levitacion" 0

ejercitoDeClones :: SuperHeroe -> [SuperHeroe]
ejercitoDeClones superHeroe = map (flip agregarNumeroANombre superHeroe) [1..]

agregarNumeroANombre :: Int -> SuperHeroe -> SuperHeroe
agregarNumeroANombre numero = modificarNombre (++ "numero")