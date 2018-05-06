-- ============================================================================
-- Grundlagen der Programmierung 2
-- Aufgabenblatt 4
-- ============================================================================

    module Blatt4 where
    import Data.Char
    import Data.List
    
    -- =============================================================================
    -- =
    -- = Aufgabe 1
    -- =
    
    -- -
    -- - a)
    -- -
    
    -- Unvollst"andige gegebene List-Comprehension: [(a,b,c,d,e,f,g) | a <- [1..7], ]
    
    wege = [(a,b,c,d,e,f,g) | 
      a <- [1..7], a == 7,    -- first step should be 7
      b <- [4..6],            -- b,c,d can only take 4,5 or 6
      c <- [4..6],
      d <- [4..6],
      e <- [2],               -- last 3 are set
      f <- [3], 
      g <- [1],
      b /= c, c /= d, b /= d, -- these and the next one are actually redundant because 
                              -- of the last condition
      [a,b,c,d,e,f,g] /= [7, 5, 4, 6, 2, 3, 1],
      -- implements the third bullet point
      [b, c, d] `elem` [[4, 5, 6], [5, 6, 4]]
      ]

    -- => Es gibt zwei Möglichkeiten, die Stadt zu durchqueren:
    --    (7,4,5,6,2,3,1) und (7,5,6,4,2,3,1)
    
    -- -
    -- - b)
    -- -
    data Tragetasche = Tragetasche [Lieferung]
      deriving(Eq,Show)
    data Lieferung = Lieferung Objekt Bezahlung Zielort
      deriving(Eq,Show)
    data Objekt = Objekt Zerbrechlich Gewicht Abmessungen
      deriving(Eq,Show)
    type Bezahlung = Float
    type Zielort = String
    type Zerbrechlich = Bool
    type Gewicht = Float
    type Abmessungen = (Float,Float,Float)
    
    -- -
    -- - b1)
    -- - 

    tragetasche :: Tragetasche
    tragetasche = Tragetasche [Lieferung (Objekt True 30 (0.50,0.50,0.50)) 100 "Eden Village", 
      Lieferung (Objekt False 15 (2.20, 3.24, 0.05)) 100 "Eden Village"]
    
    -- -
    -- - b2)
    -- - 
    weightLieferung :: Lieferung -> Gewicht
    weightLieferung (Lieferung (Objekt _ weight _) _ _) = weight

    gesamtGewicht :: Tragetasche -> Float
    gesamtGewicht (Tragetasche lieferungen) = foldl (\acc l -> acc + weightLieferung l) 0 lieferungen
    
    -- -
    -- - b3)
    -- - 
    changeZerbrechlich :: Abmessungen -> Lieferung -> Lieferung
    changeZerbrechlich abmessung (Lieferung (Objekt zerbrechlich w a) m g) = 
      Lieferung (Objekt (zerbrechlich || abmessung == a) w a) m g

    aendereZerbrechlich :: Tragetasche -> Abmessungen -> Tragetasche
    aendereZerbrechlich (Tragetasche lieferungen) abmessung = Tragetasche (map (changeZerbrechlich abmessung) lieferungen)  
    
    -- =
    -- =
    -- =============================================================================
    
    -- =============================================================================
    -- =
    -- = Aufgabe 2
    -- =
    
    -- -
    -- - a)
    -- -
    aufgabeA :: [Int]
    aufgabeA = [x | x <- [1..], odd x, x `mod` 13 == 3 && x `mod` 20 == 5 ]
    
    -- -
    -- - b)
    -- -
    aufgabeB :: [(Int, Int)] -> [Int]
    aufgabeB xs = [x | (i,j) <- xs, x <- [i,j] ]
    
    -- -
    -- - c)
    -- -
    aufgabeC :: [(Int, Bool, Char)]
    aufgabeC = [(a,b,c) | b <- [True, False], a <- [0,3,20,25,37,97], c <- ['a', 'b', 'c', 'd']]
    
    -- -
    -- - d)
    -- -
    aufgabeD :: [(Int, Int, Int)]
    aufgabeD = [(a,b,c) | a <- [1..4], b <- [1..4], let c = a + b, even c] ++ [(a,b,c) | a <- [1..4], b <- [1..4], let c = a - b, even c]
    
    -- -
    -- - e)
    -- -
    aufgabeE = undefined -- zu implementieren!
    
    -- =
    -- =
    -- =============================================================================