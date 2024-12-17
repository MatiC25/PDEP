import Data.List (genericLength)
import Data.ByteString.Builder (generic)

-------------
-- Punto 1 --
-------------

data Ladron = Ladron {
    nombre :: String,
    habilidades :: [Habilidad],
    armas :: [Arma]
}

data Rehen = Rehen {
    nombreRehen :: String,
    nivelComplot :: Float,
    nivelMiedo :: Float,
    plan :: [Plan] 
}
type Habilidad = String 
type Arma = Rehen -> Rehen
type Plan = Ladron -> Ladron 

type Mapper campo estructura = (campo -> campo) -> estructura -> estructura

modificarMiedo :: Mapper Float Rehen
modificarMiedo modificador rehen = rehen {nivelMiedo = modificador . nivelMiedo $ rehen}

modificarComplot :: Mapper Float Rehen
modificarComplot modificador rehen = rehen {nivelComplot = modificador . nivelComplot $ rehen}

-------------
-- Punto 2 --
-------------

pistola :: Float -> Arma
pistola calibre = modificarMiedo (subtract (5*calibre)) . aumentarComplot
    
aumentarComplot :: Rehen -> Rehen
aumentarComplot rehen = rehen {nivelComplot = (+3*genericLength (nombreRehen rehen)) . nivelComplot $ rehen} 

ametralladora :: Float -> Arma
ametralladora balas = modificarComplot (/2) . modificarMiedo (+balas)

type Metodo = Ladron -> Arma

disparos :: Ladron -> Rehen -> Arma
disparos ladron rehen = maximumBy (disparar rehen) (armas ladron)

disparar :: Rehen -> Arma -> Float
disparar rehen arma = nivelMiedo . arma $ rehen

metodoDisuasivo :: Metodo
metodoDisuasivo ladron rehen = disparos ladron rehen rehen

maxBy :: Ord b => (a -> b) -> a -> a -> a
maxBy ponderacion unValor otroValor
  | ponderacion unValor > ponderacion otroValor = unValor
  | otherwise                                   = otroValor

maximumBy :: Ord b => (a -> b) -> [a] -> a
maximumBy ponderacion = foldl1 (maxBy ponderacion)


hacerseElMalo :: Metodo
hacerseElMalo (Ladron "Berlin" habilidades armas) = modificarMiedo (+ genericLength (concat habilidades))   
hacerseElMalo (Ladron "Rio" habilidades armas) = modificarComplot (+30)
hacerseElMalo _ = modificarMiedo (+10) 

modificadorArmas :: Mapper [Arma] Ladron
modificadorArmas modificador ladron = ladron {armas = modificador . armas $ ladron} 

atacarAlLadron :: Rehen -> Plan
atacarAlLadron rehen = modificadorArmas quitarArmas
    where quitarArmas = drop (length . nombreRehen $ rehen)

esconderse :: Plan 
esconderse ladron = modificadorArmas perderArmas ladron 
    where perderArmas = drop (length . habilidades $ ladron)

tokio = Ladron "Tokio" ["trabajo psiclogico", "entrar en moto"] [pistola 9, pistola 9, ametralladora 30]
profesor = Ladron "Profesor" ["disfrazarse de linyera", "disfrazarse de payaso" , "estar siempre"] []
pablo = Rehen "pablo" 40 30 [esconderse]
arturito = Rehen "autorito" 70 50 [esconderse, atacarAlLadron pablo]

esLadronInteligente :: Ladron -> Bool
esLadronInteligente = (>2) . genericLength . habilidades

agregarArma :: Arma -> Ladron -> Ladron
agregarArma arma = modificadorArmas (arma :)

intimidar :: Ladron -> Rehen -> Metodo -> Rehen
intimidar ladron rehen metodo = metodo ladron rehen 

calmeLasAguas :: Ladron -> [Rehen] -> [Rehen]
calmeLasAguas ladron = map (metodoDisuasivo ladron) . filter ((<60). nivelComplot)

puedeEscaparse :: Ladron -> Bool
puedeEscaparse ladron = any (elem "disfrazarsede" . words) (habilidades ladron)

laCosaPintaMal :: [Ladron] -> [Rehen] -> Bool
laCosaPintaMal ladrones rehenes = 
    (sumaDelComplot rehenes / fromIntegral (cantidadRehenes rehenes)) > 
    (sumaDelMiedo rehenes / fromIntegral (cantidadRehenes rehenes)) * fromIntegral (sumaDeArmas ladrones)

sumaDelComplot :: [Rehen] -> Float
sumaDelComplot = sum . map nivelComplot

sumaDelMiedo :: [Rehen] -> Float
sumaDelMiedo = sum . map nivelMiedo

sumaDeArmas :: [Ladron] -> Int
sumaDeArmas = sum . map (length . armas)

cantidadRehenes :: [Rehen] -> Int
cantidadRehenes = length

losRehenesSeRebelan :: [Rehen] -> [Rehen]
losRehenesSeRebelan = map (modificarComplot (subtract 10))

planValencia :: [Ladron] -> Int
planValencia = (*100000000) . sumaDeArmas . map (agregarArma (ametralladora 45)) 