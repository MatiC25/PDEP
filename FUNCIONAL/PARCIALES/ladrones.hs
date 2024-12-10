data Tesoro = Tesoro {
    año :: Int,
    precio :: Int 
}

data TipoTesoro = DeLujo | TelaSucia | Estandar
---------------------------
-- Punto 1 -- Antiguedad --
---------------------------

esDeLujo :: Tesoro -> Bool
esDeLujo tesoro = precio tesoro > 2000 || año tesoro > 200

queTipoEs :: Tesoro -> TipoTesoro
queTipoEs tesoro
    | esDeLujo tesoro = DeLujo
    | precio tesoro < 50 && (not . esDeLujo) tesoro = TelaSucia
    | otherwise = Estandar

antiguedad :: Int -> Int 
antiguedad añoDescubrimiento = subtract añoDescubrimiento 2024

valorDeUnaTesoro :: Tesoro -> Int 
valorDeUnaTesoro tesoro = precio tesoro + 2 * antiguedad (año tesoro)

---------------------------
-- Punto 2 -- Cerradura --
---------------------------

type Cerradura = [Char]
type Herramienta = Cerradura -> Cerradura

martillo :: Herramienta
martillo = (drop 3)

llaveMaestra :: Herramienta
llaveMaestra = const []

type Criterio = Char -> Bool

ganzuaSegun :: Criterio -> Herramienta
ganzuaSegun = filter criterio

ganzuaGancho :: Herramienta
ganzuaGancho = ganzuaSegun (not . isUpper)

esNumero :: Char -> Bool
esNumero a = a `elem` "123456789"

ganzuaRastrillo :: Herramienta
ganzuaRastrillo = ganzuaSegun (isDigit)

type Inscripcion = [Char]
ganzuaRombo :: Inscripcion -> Herramienta 
ganzuaRombo inscripcion = ganzuaSegun (`elem` inscripcion)

tensor :: Herramienta
tensor = map toUpper

socotroco :: Herramienta -> Herramienta -> Herramienta
socotroco herramienta1 herramienta2 = herramienta1 . herramienta2 

----------------------------
-- Punto 3 -- LosLadrones --
----------------------------

data Ladron = Ladron {
    nombre :: String, 
    herramientas :: [Herramienta],
    tesoros :: [Tesoro]
}

esLadronLegendario :: Ladron -> Bool
esLadronLegendario = sonDeLujo ladron && ((>100) . experienciaLadron) ladron

experienciaLadron :: Ladron -> Int 
experienciaLadron ladron = sum . map valorDeUnaTesoro . tesoros

sonDeLujo :: Ladron -> Bool
sonDeLujo = all esDeLujo . tesoros

data Cofre = Cofre {
    cerradura :: Cerradura
    tesoroCofre :: Tesoro
}

-- Una solución
-- ladronRobaCofre :: Cofre -> Ladron -> Ladron
-- ladronRobaCofre cofre ladron 
--     | null (herramientas ladron) = ladron = {herramientas = []}
--     | null (cerradura cofre) = Ladron { tesoros = (tesoroCofre cofre) : tesoros}
--     | otherwise = ladronRobaCofre cofreDesbloqueado ladronSinHerramienta
--     where
--         herramienta = head (herramientas ladron)
--         cofreDesbloqueado = cofre {cerradura = herramienta (cerradura cofre)}
--         ladronSinHerramienta = ladron {herramientas = tail (herramientas ladron)}

-- aplicarHerramientACofre :: Herramienta -> Cofre -> Cofre
-- aplicarHerramientACofre herramienta cofre = cofre {cerradura = herramienta (cerradura cofre)} 

-- Otra solución que es mejor
ladronRobaCofre2 :: Ladron -> Cofre -> Ladron
ladronRobaCofre2 (Ladron nombre tesoro []) cofre = Ladron nombre tesoro []
ladronRobaCofre2 (Ladron nombre tesoros herramientas) (Cofre [] tesoroCofre) = Ladron nombre (tesoroCofre : tesoros) herramientas
ladronRobaCofre2 (Ladron nombre tesoros (x:xs)) (Cofre cerradura tesoroCofre)  =
    ladronRobaCofre (Ladron nombre tesoros xs) (Cofre (x cerradura) tesoroCofre) 

-- Esto fue idea de mili, yo usé map como un boludo !!!REVISAR!!!
atraco :: Ladron -> [Cofre] -> Ladron
atraco = foldl ladronRobaCofre2

----------------------------------
-- Punto 3.d -- ListasInfinitas --
----------------------------------

--i e ii. Suponiendo que un ladron tiene una infinita listas de herramientas, en algun momento
-- va a poder abrir todos los cofres. Lo mismo sucede con el caso contrario, donde hay una infinita cantidad de cofres, en ese
-- caso en algún momento el ladrón se quedará sin herramientas y la recursividad terminará. El unico caso en el que puede quedar
-- iterando es si hay una infinita cantidad de herramientas y una infinita cantidad de cofres, el ladron robará cada cofre pero
-- nunca terminará de robar todos.
